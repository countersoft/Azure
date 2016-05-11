gemini_items = {
    currentViewedIssueId: 0,
    subscribed: false,
    currentViewXHR: null,
    pageType: 0,
    gridDeleteIssueRowCallback: null,
    init: function (pageType, bulkUpdateText, filterFields) {
        gemini_master.currentRefreshFunction = gemini_items.resizeMainItemsGrid;
        gemini_items.pageType = pageType;
        gemini_filter.init(pageType, filterFields);
        gemini_edit.initEdit(0, pageType, '#cs-popup', '#cs-popup-content', '#data', gemini_items.refreshRow);
        gemini_ui.fancyInputs('#tabledata .fancy');
        gemini_items.bindContextMenu();
        
        $('#data').on('click', '#page-options-box #bulk-update', function () {
            if ($('.checked-items:checked', $('#items-grid')).length > 0) {
                $("#cs-popup-center-content").css("width", "800px");
                $("#cs-popup-center-content").css("height", "600px");
                gemini_popup.centerPopup("bulk", "", {}, null, bulkUpdateText);
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
                
        /// View item
        $('#data').on('click', '#split-view-item', function () {
            gemini_items.splitView(this);
            gemini_items.setCardDisplayMode(1);
        });
        $('#data').on('click', '#split-view-grid', function () {
            $('#items-grid tr').removeClass('view-issue-highlight');
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
            gemini_items.setCardDisplayMode(0);
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

    setCardDisplayMode: function(mode)
    {
        if (gemini_appnav.pageCard.IsExisting)
        {
            gemini_ajax.postCall('items', 'splitviewchange', null, null, { displayMode: mode});
        }
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
                    var url = 'items';
                    gemini_ajax.call(url, 'refreshrow?issueid=' + issueId +'&viewtype=' + gemini_items.pageType, function (response) {
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
        gemini_items.currentViewXHR = gemini_ajax.call('item', 'grid?issueid=' + gemini_items.currentViewedIssueId, function (response) {
            gemini_items.currentViewXHR = null;
            if (tinymce.editors["comments-wysiwyg-content"])
            {
                gemini_ui.destroyHtmlEditor("#comments-wysiwyg-content");
            }
            if (tinymce.editors["comments-wysiwyg-content2"]) {
                gemini_ui.destroyHtmlEditor("#comments-wysiwyg-content2");
            }
            if (tinymce.editors["breeze-comments-wysiwyg-content"])
            {
                gemini_ui.destroyHtmlEditor("#breeze-comments-wysiwyg-content");
            }
            $('#view-item-slider').html(response);
            var width = $('#items-grid').width() * 0.7;
            //if (width < 820) width = 820;
            var top = $('#items-grid').offset().top;
            $('#view-item-slider').css('top', top + 'px');
            $('#view-item-slider').attr('data-top', top);
            $('#view-item-slider').css('width', width + 'px');
            var height = $(window).height();
            height = height - top - 24 - 3 - 24 - 20; // footer take away six
            $('#view-item-slider').css('height', height + 'px');
            $('#view-item-slider').show(/*'slide', { direction: 'right' }, 250*/);
            $("tr[id^='tr-issue-'] td", '#tabledata').destroyContextMenu();
            gemini_items.disableInlineEdit();
            gemini_ui.chosen('#view-item-slider select:not(.no-chosen)', null);
            gemini_item.switchTab(null, $('.tab:first', '#view-item-content-pane'));
            gemini_items.adjustViewPane();
        });
        $(window).scroll(gemini_items.adjustViewPane);
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
        $('.comments', '#tabledata').unbind('click').click(function (e)
        {
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
            gemini_ajax.call('item', "comments?issueid=" + parent.data('issue-id'),
                function (response) {
                    if (!response.success) return;
                    if (pos.left < 400) {
                        $('#comments').html(response.Result.Data).show();
                        $("#comments").position({
                            "of": that,
                            "my": "left top",
                            "at": "left bottom",
                            "offset": "0 -1",
                            "collision": "none"
                        });
                    }
                    else {
                        $('#comments').html(response.Result.Data).show();
                        $("#comments").position({
                            "of": that,
                            "my": "right top",
                            "at": "right bottom",
                            "offset": "0 -1",
                            "collision": "none"
                        });
                    }
                    $("#comments #comments-content").removeClass('hide');
                });
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

        if ($('#tabledata', '#data').length != 0)
        {
            if ($('#tabledata', '#data').position().left + $('#tabledata', '#data').width() >= $('#side-pane').position().left)
            {
                $('#tabledata', '#data').css('padding-right', ($('#side-pane').width() + 20) + 'px');
            }
            else
            {
                $('#tabledata', '#data').css('padding-right', '');
            }
        }
        
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
        
    bulkDeleteItems: function (items)
    {
        if (items && items.length > 0) {
            gemini_ui.startBusy('#modal-confirm #modal-button-yes');

            gemini_ajax.postCall("bulk", "delete",
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
    postDeleteProj: function (issueId, projectId) {
        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
        gemini_ajax.postCall("item", "deleteissue?issueid=" + issueId + '&issueprojectid=' + projectId, gemini_items.PostDeleteResponse, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); });
    },
    PostDeleteResponse: function (response)
    {
        if (gemini_items.gridDeleteIssueRowCallback) {
            gemini_items.gridDeleteIssueRowCallback(response);
        }
        else {
            if (response.Success) {
                var currentPage = $('#pager-next').data('page') - 1;
                $("#card-holder").html(response.Result.Data.navdata);
                gemini_filter.getFilteredItemsPage(currentPage);

            }
            gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
            gemini_appnav.initCardActions();
        }
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
                        gemini_popup.centerPopup("item/editcommenteditor", "popup?issueid=" + issueId);
             
                    }
                    else if (action == "follow") {
                        if ($('.checked-items:checked', $('#items-grid')).length > 0) {
                            var checked_items = new Array();
                            var index = 0;
                            $('.checked-items:checked', $('#items-grid')).each(function (index, value) {
                                checked_items[index++] = $(value).val();
                            });
                            gemini_ajax.postCall("item", "addwatchers", function(response) { gemini_popup.toast(response.Result.Data); }, null, { items: checked_items });
                           
                        }
                        else {
                            gemini_ajax.call("item", "addwatcher/" + issueId + "/0");
                        }
                    }
                    else if (action == "time" && !$('#item-grid-context-menu a[href="#time"]').parent().hasClass('disabled')) {
                        $("#cs-popup-center-content").css("width", "500px");
                        $("#cs-popup-center-content").css("height", "350px");
                        gemini_popup.centerPopup("item/edittimeentry", "popup?issueid=" + issueId, { timeid: 0 });
                    }
                    else if (action == "sequencemenu" && !$('#item-grid-context-menu a[href="#sequencemenu"]').parent().hasClass('disabled')) {
                        gemini_ajax.postCall("items", "resequence", function ()
                        {
                            gemini_filter.getFilteredItemsCurrentPage();                    
                        },
                        function (xhr, ajaxOptions, thrownError) {
                        gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                        },
                        {
                            issueId: issueId, afterIssueId: 0, newIndex: -2,  oldIndex: 0
                        });
                    }
                    else if (action == "delete" && !$('#item-grid-context-menu a[href="#delete"]').parent().hasClass('disabled')) {
                        gemini_popup.modalConfirm("Delete Item "+ projectCode + "-" + issueId + "?", null,
                            function () {
                                gemini_items.postDeleteProj(issueId, projectId);
                            });
                    }
                },
                function (before) {
                    
                    gemini_ajax.call('', "projectpermissions?issueid=" + $(before).parent().data("issue-id"), function (response) {
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

                            if (response.Result.Data.canaddtime) {
                                $('#item-grid-context-menu').enableContextMenuItems('#time');
                            }
                            else
                                $('#item-grid-context-menu').disableContextMenuItems('#time');

                            if ($('#ShowSequenced', '#filter-form').is(':checked') && !$(before).parent().hasClass('sequenced-issue') && response.Result.Data.cansequence) {
                                $('#item-grid-context-menu').enableContextMenuItems('#sequencemenu');
                            }
                            else {
                                $('#item-grid-context-menu').disableContextMenuItems('#sequencemenu');
                            }
                            
                        }
                    }, null, null, null, null, false);

                }
            );
    },

    getCurrentItem: function()
    {
        if (gemini_items.currentViewedIssueId == 0)
        {
            gemini_items.currentViewedIssueId = $('#data #items-grid td a:first').parents('tr:eq(0)').attr('data-issue-id');
        }
        return { issueid: gemini_items.currentViewedIssueId };
    },

    adjustViewPane: function()
    {
        var top = $('#view-item-slider').attr('data-top');
        var height = $(window).height();

        if ($(window).scrollTop() + $('#zone-header-bar').height() > top)
        {
            top = $('#zone-header-bar').height();    
            height = height - top - 24 - 3 - 24 - 20; // footer take away six
            $('#view-item-slider').css({ 'position': 'fixed', top: top + 'px', height: height + 'px' });
            
        }
        else
        {
            height = height - top - 24 - 3 - 24 - 20 + $(window).scrollTop(); // footer take away six
            $('#view-item-slider').css('height', height + 'px');
            $('#view-item-slider').css({ 'position': 'absolute', top: top + 'px' });
        }
    }
};