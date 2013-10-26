gemini_items = {
    currentViewedIssueId: 0,
    subscribed: false,
    currentViewXHR: null,
    pageType: 0,
    init: function (pageType, bulkUpdateText, filterFields) {
        gemini_items.pageType = pageType;
        gemini_filter.init(pageType, filterFields);
        gemini_edit.initEdit(0, pageType, '#cs-popup', '#cs-popup-content', '#data', gemini_items.refreshRow);
        gemini_ui.fancyInputs('#tabledata .fancy');
        gemini_items.bindContextMenu();
        
        $('#data').on('click', '#page-options-box #bulk-update', function () {
            if ($('.checked-items:checked', $('#items-grid')).length > 0) {
                $("#cs-popup-center-content").css("width", "800px");
                $("#cs-popup-center-content").css("height", "600px");
                gemini_popup.centerPopup(csVars.ProjectUrl + "bulk", "", {}, null, bulkUpdateText);
            }
        });
       
        $('#data').on('click', '#page-options-box #bulk-delete', function () {
            if ($('.checked-items:checked', $('#items-grid')).length > 0) {
                gemini_popup.modalConfirm("Delete selected items ?", null,
                        function () {
                            var checked_items = new Array();
                            var index = 0;
                            $('.checked-items:checked', $('#items-grid')).each(function (index, value) {
                                var val = $(value).val();
                                checked_items[index++] = val;
                            });
                            gemini_items.bulkDeleteItems(checked_items);
                        });
            }
            else {
                if ($('.split-view-selected', '#items-grid-control-box').parent().attr('id') == 'split-view-item') {
                    //Split view is active. Delete currently viewing item.
                    gemini_popup.modalConfirm("Delete currently viewed item: " + $('#view-item-slider .item-title').text() + ' ?', null,
                              function () {
                                  var checked_items = new Array();
                                  checked_items[0] = gemini_item.issueId;
                                  gemini_items.bulkDeleteItems(checked_items);
                              });
                }
            }
        });

        gemini_commons.shiftKeyHandler();
        gemini_items.initShiftSelect();

        gemini_items.initInlineEdit();

        if ($('#page-content-zone .layout .items-data-container').length > 0) {
            gemini_items.resizeMainItemsGrid();
            $(window).resize(function () {
                gemini_items.resizeMainItemsGrid();
            });
        }
        
        gemini_items.initCheckAllItems();

        gemini_items.initPageSize();

        if (!($('#tabledata tbody tr:not(.drop-zone):first').length)) {
            $('#pageSizeContainer').hide();
        }

        $('#tabledata tr td:last-child').addClass('cell-border-right');

        gemini_items.initHoverContextMenu();
      
        /// View item
        $('#data').on('click', '#split-view-item', function () {
            gemini_items.splitView(this);
        });
        $('#data').on('click', '#split-view-grid', function () {
            $('#DisplayMode', '#filter-form').val('Table');
            $(this).find('.grid-button').addClass('split-view-selected');
            $('#split-view-item').find('.grid-button').removeClass('split-view-selected');

            $('#data').off('click', '#items-grid td.read-only a');
            $('#view-item-slider').empty().hide();
            gemini_edit.initEdit(0, pageType, '#cs-popup', '#cs-popup-content', '#data', gemini_items.refreshRow);
            gemini_items.bindContextMenu();
            gemini_items.initInlineEdit();
            gemini_items.currentViewedIssueId = 0;
            $.unsubscribe('issue-update.items');
            $.unsubscribe('issue-delete.items');
            gemini_items.subscribed = false;
            gemini_filter.refreshFilterCard();
        });


        /// View item
        var displayMode = $('#DisplayMode', '#filter-form');
        if (displayMode && displayMode.length) {
            var val = displayMode.val();
            if (val == 'SplitViewItem' && $('#split-view-item').is(':visible')) {
                $('#split-view-item').click();
            }
        }
  
        Mousetrap.bindGlobal(['ctrl+,', 'ctrl+.'], gemini_keyboard.navigateGrid);

        $.subscribe('items-grid-page-loaded.gridsplitview', function () {
            if ($('#DisplayMode', '#filter-form').val() == 'SplitViewItem') gemini_items.splitView('#split-view-item');
        });
        $.subscribe('items-grid-filter-executed.gridsplitview', function () {
            if ($('#DisplayMode', '#filter-form').val() == 'SplitViewItem') gemini_items.splitView('#split-view-item');
        });
    },

    splitView: function(elem) {
        $('#DisplayMode', '#filter-form').val('SplitViewItem');
        $(elem).find('.grid-button').addClass('split-view-selected');
        $('#split-view-grid').find('.grid-button').removeClass('split-view-selected');
        gemini_filter.refreshFilterCard();

        $('#data').off('click', '#items-grid td.read-only a').on('click', '#items-grid td.read-only a', function (e) {
            gemini_items.splitViewShow(e, this);
        });

        gemini_items.splitViewShow(null, '#data #items-grid td a:first');
    },

    splitViewShow: function(e, elem) {
        var issue;
        var project = 0;
        if (e == null || !e.ctrlKey)
        {
            issue = $(elem).parents('tr:eq(0)').attr('data-issue-id');
            project = $(elem).parents('tr:eq(0)').attr('data-project-id');
                    
            if (issue == undefined) {
                $('#view-item-slider').empty().hide();
                return;
            }

            if (e != null) gemini_commons.stopClick(e);
            $('#items-grid tr').removeClass('view-issue-highlight');
            var parent = $(elem).parent().parent();
            parent.addClass('view-issue-highlight');
            gemini_items.currentViewedIssueId = issue;
            if (!gemini_items.subscribed) {
                $.subscribe('issue-update.items', function (_, issueId, fromPageType) {
                    if (fromPageType != gemini_commons.PAGE_TYPE.Item) return;
                    // Ok, we have to update a row!
                    var url = csVars.ProjectUrl + 'items/' + issueId + '/refreshrow';
                    gemini_ajax.call(url, gemini_items.pageType, function (response) {
                        if (response.success) {
                            gemini_items.refreshRow(response, issueId, true);
                            $("tr[id^='tr-issue-'] td", '#tabledata').destroyContextMenu();
                            $('#tr-issue-' + issueId, '#data').addClass('view-issue-highlight');
                        }
                    });
                });
                $.subscribe('issue-delete.items', function (_, issueIds) {                            
                    var viewedDeleted = false;
                    if (issueIds instanceof Array) {
                        for (var l = 0; l < issueIds.length; l++) {
                            if (issueIds[l] == gemini_items.currentViewedIssueId) {
                                viewedDeleted = true;
                                break;
                            }
                        }
                    }
                    else if (issueIds == gemini_items.currentViewedIssueId) {
                        viewedDeleted = true;
                    }

                    if (viewedDeleted) {
                        $('#split-view-item').click();
                    }
                });
                gemini_items.subscribed = true;
            }
        }
        if (gemini_items.currentViewXHR != null) {
            gemini_items.currentViewXHR.abort();
        }
        gemini_items.currentViewXHR = gemini_ajax.call('project/all/' + project + '/item/' + gemini_items.currentViewedIssueId, 'grid', function (response) {
            gemini_items.currentViewXHR = null;
            $('#view-item-slider').html(response);
            var width = $('#items-grid').width() * 0.7;
            //if (width < 820) width = 820;
            var top = $('#items-grid').offset().top;
            $('#view-item-slider').css('top', top + 'px');
            $('#view-item-slider').css('width', width + 'px');
            var height = $(window).height();
            height = height - top - 24 - 3;
            $('#view-item-slider').css('height', height + 'px');
            $('#view-item-slider').show(/*'slide', { direction: 'right' }, 250*/);
            $("tr[id^='tr-issue-'] td", '#tabledata').destroyContextMenu();
            gemini_items.disableInlineEdit();
            gemini_ui.chosen('#view-item-slider select:not(.no-chosen)', null);
            gemini_item.switchTab(null, '.tab:first', '#view-item-content-pane');
        });
    },

    initInlineEdit: function () {
        $('#data').on('click', '#tabledata tr:not(.drop-zone) td:not(:first-child):not(.read-only):not(.edit-mode)', function (e) {
            //Making sure the edit doesn't get invoked when clicking on link
            if (!$(e.target).is('a')) {
                gemini_edit.initEditing($(this), true);
            }
        });
    },
    
    disableInlineEdit: function () {
        $('#data').off('click', '#tabledata tr:not(.drop-zone) td:not(:first-child):not(.read-only):not(.edit-mode)');
    },
    
    initPageSize:function(){
        gemini_commons.inputKeyHandler("#pageSize",
                        function () {
                            var n = $('#pageSize').val();

                            if (!isNaN(n) && parseInt(n) == n && n.indexOf('.') == -1 && n > 0) gemini_filter.executeFilter();
                        });
    },
    
    initShiftSelect: function()
    {
        var lastChecked = null;
        $('#tabledata tr td .checked-items').unbind('ifClicked').bind('ifClicked', function (e) {
         
            checkProperty = $(this).prop('checked') ? 'uncheck' : 'check';
        
            if (!lastChecked) {
                lastChecked = $(this);
                return;
            }

            if (gemini_commons.ShiftPressed) {
                var start = $('#tabledata .checked-items').index($(this));
                var end = $('#tabledata .checked-items').index(lastChecked);
            
                $('#tabledata .checked-items').slice(Math.min(start, end), Math.max(start, end)).iCheck(checkProperty);
                e.preventDefault();
            }

            lastChecked = $(this);
        });
    },
    
    initHoverContextMenu: function () {
        $('#data').on('click', '#tabledata tr .item-context-menu', function (e) {
            gemini_commons.stopClick(e);
            e.button = 2;
            $(this).parent().trigger("mousedown", e).trigger("mouseup", [e]);
        });
    },
    
    initCheckAllItems: function () {
        $('#check-all-items').unbind('ifChanged').bind('ifChanged', function (e) {
            e.stopPropagation();
            if ($(this).prop('checked')) {
                $('#items-grid #tabledata tbody tr .checked-items').iCheck('check');
                $('#items-grid #tabledata tbody tr .checked-items').prop('checked', true);
            }
            else {
                $('#items-grid #tabledata tbody tr .checked-items').iCheck('uncheck');
                $('#items-grid #tabledata tbody tr .checked-items').prop('checked', false);
            }
        });

    
    },
    
    initComments: function () {
        $('#comments').unbind('click').click(function (e) { $(this).hide(); $(this).empty(); });
        $('.comments','#tabledata').unbind('click').click(function (e) {
            if (!$(e.target).hasClass('item-context-menu')) {
                gemini_commons.stopClick(e);
                var parent = $(this).parent();
                var that = this;
                var pos = $(this).position();
                if ($('#comments').is(':visible')) {
                    $('#comments').hide();
                    $('#comments').empty();
                    return;
                }
                gemini_keyboard.bindEscape("#items-grid #comments", function (guid, selector) {
                    $(selector).hide();
                    gemini_keyboard.unbindEscape("#items-grid #comments");

                });
                $.ajax({
                    type: "GET",
                    url: csVars.Url + 'project/' + parent.data('project-code') + '/' + parent.data('project-id') + '/item/' + parent.data('issue-id') + '/comments',
                    success: function (response) {
                        if (!response.success) return;
                        if (pos.left < 400) {
                            $('#comments').html(response.Result.Data).show();
                            $("#comments").position({
                                "of": that,
                                "my": "left top",
                                "at": "center bottom",
                                "offset": "0 0",
                                "collision": "none"
                            });
                        }
                        else {
                            $('#comments').html(response.Result.Data).show();
                            $("#comments").position({
                                "of": that,
                                "my": "right top",
                                "at": "center bottom",
                                "offset": "0 0",
                                "collision": "none"
                            });
                        }
                        $("#comments #comments-content").removeClass('hide');
                    }
                });
            }
        });
    },
    
    resizeMainItemsGrid: function () {
    
            var totalWidth = $('#page-content-zone .layout').width();
            /*var filterWidth = 0;

            if ($('#page-content-zone .filter-container').is(':visible'))
                filterWidth = $('#page-content-zone .filter-container').width() + 10;

            var contentWidth = totalWidth - filterWidth;*/
            var contentWidth = totalWidth;
            $('#page-content-zone .layout .items-data-container').css('width', contentWidth + 'px');
        
    },
    
    refreshRow: function (response, issueId, overridePageType) {
        var oldTr = $('#tr-issue-' + issueId, '#tabledata');
        $('#tr-issue-' + issueId, '#tabledata').replaceWith(response.Result.Html);
        var newTr = $('#tr-issue-' + issueId, '#tabledata');

        gemini_items.bindContextMenu();
        gemini_filter.initTableDnD();
        if (gemini_edit.pageType == gemini_commons.PAGE_TYPE.Items || overridePageType) {
            gemini_ui.fancyInputs('#tabledata #tr-issue-' + issueId + ' .fancy');
            gemini_items.initShiftSelect();

            if (gemini_edit.pageType == gemini_commons.PAGE_TYPE.Items)
            {
                if (oldTr.hasClass('dependant')) { //If it's a dependent item do this                    
                    newTr.attr('class', 'dependant')
                    $('<span class="indented">L &nbsp;</span>').insertBefore($('.items-first-column', newTr).next().find('a'))
                }
                else if (oldTr.find('.parent.expander.fonticon-arrow-up').length > 0) //If it's a parent item do this
                {                   
 					newTr.find('.parent.expander').removeClass('fonticon-arrow-down').addClass('fonticon-arrow-up');                    
                }
            }
          
        }      
    },
    
   pageCard: "",
    
    pinItem: function (issueId, pinning)
    {
        var url = csVars.Url + "cards/issue";

        $.ajax({
            type: "POST",
            url: url,
            data: { mode: pinning, issueId: issueId },
            dataType: "json",
            success: function (response) {
                gemini_appnav.refresh();
            }
        });
    },
    bulkDeleteItems: function (items)
    {
        if (items && items.length > 0) {
            gemini_ui.startBusy('#modal-confirm #modal-button-yes');

            gemini_ajax.postCall(csVars.ProjectUrl + "bulk", "delete",
                            function () {
                                gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
                                $.subscribe('items-grid-page-loaded.itemsgriddelete', function (e) {
                                    $.publish('issue-delete', [items]);
                                    $.unsubscribe('items-grid-page-loaded.itemsgriddelete');
                                });
                                gemini_filter.getFilteredItemsCurrentPage();
                            },
                            function () {
                                gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
                            }, { items: items });
        }
    },
    postDelete: function (issueId) {
        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
        gemini_ajax.postCall(csVars.ProjectUrl + "item", "deleteissue/" + issueId.issueId, gemini_items.PostDeleteResponse, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); });
    },
    postDeleteProj: function (issueId, projectId) {
        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
        gemini_ajax.postCall(csVars.ProjectUrl + "item", "deleteissue/" + issueId + '/' + projectId, gemini_items.PostDeleteResponse, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); });
    },
    PostDeleteResponse: function (response)
    {
        if (response.Success)
        {
            var currentPage = $('#pager-next').data('page') - 1;
            $("#card-holder").html(response.Result.Data.navdata);
            gemini_filter.getFilteredItemsPage(currentPage);
            
        }
        gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
        gemini_appnav.initCardActions();
    },


    bindContextMenu: function () {      
        $("tr[id^='tr-issue-'] td", '#tabledata').destroyContextMenu();
        $("tr[id^='tr-issue-'] td", '#tabledata').contextMenu({ menu: 'item-grid-context-menu' },
                function (action, el, pos) {                    
                    /*var elem = planner.selectedContextCard = $(el);
                    var cardId = planner.selectedContextCard.attr("id");*/
                    var issueId = $(el).parent().data("issue-id");
                    var cardId = $(el).parent().data("data-issue-id");
                    var projectCode = $(el).parent().attr("data-project-code");
                    var projectId = $(el).parent().attr("data-project-id");
                    
                    if (action == "view" && !$('#item-grid-context-menu a[href="#view"]').parent().hasClass('disabled')) {
                        gemini_commons.openIssueUrlInTabProj(issueId, projectId);
                    }
                    else if (action == "new") {
                    }
                    else if (action == "edit" && !$('#item-grid-context-menu a[href="#edit"]').parent().hasClass('disabled')) {
                        gemini_edit.initEditing(el);
                    }
                    else if (action == "comment" && !$('#item-grid-context-menu a[href="#comment"]').parent().hasClass('disabled')) {
                        $("#cs-popup-center-content").css("width", "600px");
                        $("#cs-popup-center-content").css("height", "475px");
                        gemini_popup.centerPopup("project/All/" + projectId + "/item/" + issueId + "/editcommenteditor", "popup");
             
                    }
                    else if (action == "follow") {
                        gemini_ajax.call("project/All/" + projectId + "/item", "addwatcher/" + issueId + "/0");
                    }
                    else if (action == "pin") {
                        gemini_items.pinItem(issueId, false);
                    }
                    else if (action == "delete" && !$('#item-grid-context-menu a[href="#delete"]').parent().hasClass('disabled')) {
                        gemini_popup.modalConfirm("Delete Item "+ projectCode + "-" + issueId + "?", null,
                            function () {
                               // gemini_items.postDelete({ issueId: cardId });
                                gemini_items.postDeleteProj(issueId, projectId);
                            });
                    }
                },
                function (before) {
                    
                    gemini_ajax.call(csVars.ProjectUrl + 'projects', "getprojectpermissions/" + $(before).parent().data("issue-id"), function (response) {
                        if (response.success)
                        {
                            if (response.Result.Data.canview)
                                $('#item-grid-context-menu').enableContextMenuItems('#view');
                            else
                                $('#item-grid-context-menu').disableContextMenuItems('#view');

                            if (response.Result.Data.canedit)
                                $('#item-grid-context-menu').enableContextMenuItems('#edit');
                            else
                                $('#item-grid-context-menu').disableContextMenuItems('#edit');

                            if (response.Result.Data.candelete)
                                $('#item-grid-context-menu').enableContextMenuItems('#delete');
                            else
                                $('#item-grid-context-menu').disableContextMenuItems('#delete');

                            if (response.Result.Data.cancomment)
                                $('#item-grid-context-menu').enableContextMenuItems('#comment');
                            else
                                $('#item-grid-context-menu').disableContextMenuItems('#comment');
                            
                        }
                    }, null, null);

                }
            );
    }
};