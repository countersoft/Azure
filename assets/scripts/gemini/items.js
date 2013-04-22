gemini_items = {

    init: function (pageType, bulkUpdateText) {
        gemini_filter.init(pageType);
        gemini_edit.initEdit(0, pageType, '#cs-popup', '#cs-popup-content', '#data', gemini_items.refreshRow);
        gemini_items.bindContextMenu();

        $('#data').on('click', '#page-options-box #bulk-update', function () {
            gemini_popup.centerPopup(csVars.ProjectUrl + "bulk", "", {}, null, bulkUpdateText);
        });

        $('#data').on('click', '#tabledata tr:not(.drop-zone) td:not(:first-child)', function () {
            gemini_edit.initEditing($(this));
        });

        if ($('#page-content-zone .layout .items-data-container').length > 0) {
            gemini_items.resizeMainItemsGrid();
            $(window).resize(function () {
                gemini_items.resizeMainItemsGrid();
            });
        }
        
        gemini_commons.inputKeyHandler("#pageSize",
                        function () {
                            var n = $('#pageSize').val();
                           
                            if (!isNaN(n) && parseInt(n) == n && n.indexOf('.') == -1 && n > 0) gemini_filter.executeFilter();
                        });

    },
    initComments: function () {
        $('#comments').unbind('click').click(function (e) { $(this).hide(); });
        $('.comments').unbind('click').click(function (e) {

            gemini_commons.stopClick(e);
            var parent = $(this).parent();
            var that = this;
            var pos = $(this).position();
            if ($('#comments').is(':visible')) {
                $('#comments').hide();
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
                }
            });
        });
    },
    resizeMainItemsGrid: function () {
    
            var totalWidth = $('#page-content-zone .layout').width();
            var filterWidth = 0;

            if ($('#page-content-zone .filter-container').is(':visible'))
                filterWidth = $('#page-content-zone .filter-container').width() + 10;

            var contentWidth = totalWidth - filterWidth;
            $('#page-content-zone .layout .items-data-container').css('width', contentWidth + 'px');
        
    },
    refreshRow: function(response, issueId) {
            $('tr[data-issue-id="' + issueId + '"]').replaceWith(response.Result.Html);
            gemini_items.bindContextMenu();
            gemini_filter.initTableDnD();
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
                $("#card-holder").html(response.Result.Data);

                if (pinning) {
                    gemini_appnav.addCardAnimate();
                } else {
                    
                }

                gemini_appnav.resizer();
                gemini_appnav.initCardActions();
            }
        });
    },

    removeCardAnimate: function (cardId) {
        $('#card-' + cardId).effect("transfer", { to: $('#contents') }, 650);
    },

    addCardAnimate: function (cardId) {
        $('#card-' + gemini_appnav.pageCard.Id).effect("shake", { times: 1, distance: 5, direction: "up" }, 300);
        $('#contents').effect("transfer", { to: $('#card-' + gemini_appnav.pageCard.Id) }, 650);
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
                        $("#cs-popup-center-content").css("width", "725px");
                        $("#cs-popup-center-content").css("height", "475px");
                        gemini_popup.centerPopup("project/All/" + projectId + "/item/" + issueId + "/editcommenteditor", "popup");
             
                    }
                    else if (action == "share") {
                        gemini_share.showShare("left top", "left bottom", "0 0", el, issueId, "{}");
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