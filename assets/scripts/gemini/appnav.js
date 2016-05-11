gemini_appnav =
{
    pageCard: "", 
    stopRefresh: false, 
    previousCards: [],
    cardCount: 0,
    cardOffScreenCount: 0,
    cardHeight: 56,
    pageSize: 0,
    originalTop: 0,
    inRefresh: false,

    /* Setup the appnav zone */
    init: function (newWorkspace)
    {
        // Card click handlers
        gemini_appnav.initCardActions();

        // Periodic card refresh
        gemini_appnav.refreshTimer();

        // Make sure that the selected AppNav is visible (scroll to it if not)
        gemini_appnav.makeAppNavVisible();

        if (newWorkspace)
        {
            $('#appnav-toolbar-configure').click();
        }
    },
    
    /* For every card bind click handlers AND highlight current card */
    initCardActions: function ()
    {
        // Work out where cards need to hide and require slider panel
        // 30 = footer height; 42 = size of single card
        var viewportEdge = $(window).height() - 30 - 42 - 42;

        gemini_appnav.cardCount = $(".card", "#zone-side-bar").length;
        gemini_appnav.cardOffScreenCount = 0;
        
        // Card clicks
        $(".card", "#zone-side-bar").each(function ()
        {
            var cardBottom = $(this).position().top + $(this).height();
        
            if (cardBottom > viewportEdge) gemini_appnav.cardOffScreenCount += 1;
        });

        gemini_appnav.pageSize = gemini_appnav.cardCount - gemini_appnav.cardOffScreenCount;

        // Highlight current card
        $("#card-" + gemini_appnav.pageCard.Id).addClass("selected");

        // If pin icon hidden then remove the space that it uses
        if (!$("#pin-page").length) $("#card-holder-container").css("top", "45px");

        // Card drag-drop
        $(".cards", "#card-holder").sortable({
            forcePlaceholderSize: true,
            forceHelperSize: true,
            connectWith: ".card",
            zIndex: 99999,
            containment: "parent",
            items: ".card:not(.system)",
            delay: csVars.IEVersion == -1 || csVars.IEVersion >= 9 ? 250 : 0,
            helper: "original",
            start: function (event, ui) {
                gemini_appnav.stopRefresh = true;
            },
            stop: function (event, ui) {
                gemini_appnav.stopRefresh = false;
            },
            update: function (event, ui) {
                var sequenceList = "";

                $(".cards", "#card-holder").children().each(function () {
                    sequenceList += $(this).data("card-id");
                    sequenceList += "|";
                });

                gemini_ajax.postCall('action','sort', function(response) {
                        gemini_appnav.stopRefresh = false;
                    }, function () {
                        gemini_appnav.stopRefresh = false;
                    }, { sequence: sequenceList });
            }
        });

        // Handle scrolling
        gemini_appnav.originalTop = parseInt($("#card-holder-container", "#zone-side-bar").css('top'));
        gemini_appnav.scroller();

        // Show the current AppNav's card toolbar in the footer
        gemini_appnav.setAppNavToolbar();
    },

    makeAppNavVisible:function() {
        // Scroll to active card if it is not visible on the page
        if ($('#card-holder .card.selected').length && !gemini_appnav.isOnScreen($('#card-holder .card.selected'))) {
            gemini_appnav.stopRefresh = true;
            var top = $('#card-holder .card.selected').position().top + $('#card-holder .card.selected').height();
            var screenHeight = $(window).height();
            top = top - screenHeight + gemini_appnav.cardHeight + parseInt($('#card-scroller').css('height'));
            $("#card-holder-container", "#zone-side-bar").css("top", (gemini_appnav.originalTop - top) + 'px');
        }
    },
    
    /* Periodic card refresh setup */
    refreshTimer: function ()
    {
        var interval = 10000; // Every 10 seconds

        setInterval(gemini_appnav.refresh, interval);
    },
    
    /* Periodic card refresh */
    refresh: function () {
        // Ensure we are not already refreshing!
        if (gemini_appnav.stopRefresh) return;

        gemini_appnav.inRefresh = true;
        gemini_appnav.stopRefresh = true;

        if ($('#card-holder-container .card .info').is(':visible')) {
            gemini_appnav.stopRefresh = false;
            gemini_appnav.inRefresh = false;
            return;
        }
                
        gemini_ajax.postCall('workspace/' + gemini_appnav.pageCard.Id + '/action','fetch', function (response) {
            if (response.Result == undefined || response.Result == null || response.Result.Data == undefined || response.Result.Data == null) return;
            var i = 0;
                
            // We update the whole sidebar appnav zone
            $("#card-holder").empty();
            $("#card-holder").html(response.Result.Html);

            // If our card has been deleted
            if (gemini_appnav.pageCard.Id != 0 && $('#card-' + gemini_appnav.pageCard.Id, '#card-holder').length == 0) {
                gemini_appnav.pageCard.Id = 0;
            }

            if (gemini_appnav.pageCard.Id != 0)
            {
                gemini_appnav.pageCard.BadgeCount = $('#card-' + gemini_appnav.pageCard.Id, '#card-holder').attr('data-counter');
                gemini_appnav.pageCard.CardData.Chat.BadgeCount = $('#card-' + gemini_appnav.pageCard.Id, '#card-holder').attr('data-chat-count');
            }
            gemini_appnav.initCardActions();
            // Find and highlight new cards so user can see them
            var latestCards = _.pluck(response.Result.Data, 'Id');
            var newCards = _.difference(latestCards, gemini_appnav.previousCards);
                
            _.each(newCards, function (e) {
                $('#card-' + e).css("visibility", "hidden").css("left", "30px").css("visibility", "visible").animate({ left: '0' }, { easing: 'easeOutBounce', duration: 1500 });
            });

            gemini_appnav.previousCards = latestCards;
                
            gemini_appnav.stopRefresh = false;
            gemini_appnav.inRefresh = false;
             
            if (response.Result.ChatHtml)
            {
                gemini_chat.renderChatMessage(response.Result.ChatHtml);
            }
        },
            function () {
                gemini_appnav.stopRefresh = false;
                gemini_appnav.inRefresh = false;
            }, gemini_chat.getPostParameters(), null, true);
    },
        
    /* Delete card */
    removeCard: function(cardId)
    {
        $("#cs-popup-center-content").css("width", "400px");
        $("#cs-popup-center-content").css("height", "150px");

        var buttonDeleteText = "";
        var buttonTransferText = "";
        var transfered = 0;

        gemini_commons.translateMessage("[[Move]]", ['Move'], function (message) { buttonTransferText = message; });

        gemini_commons.translateMessage("[[Delete]]", ['Delete'], function (message)
        {
            buttonDeleteText = message;

            gemini_popup.centerPopup("action/delete", 'show', null, null, buttonDeleteText, null, null, null, function ()
            {
                gemini_ui.chosen("#delete-workspace #Owner", null, true);

                $('#delete-workspace #Owner').change(function ()
                {
                    if ($(this).val() > 0)
                    {
                        transfered = $(this).val();
                        $("#popup-button-yes", "#cs-popup-center").val(buttonTransferText);
                    }
                    else
                    {
                        transfered = 0;
                        $("#popup-button-yes", "#cs-popup-center").val(buttonDeleteText);
                    }
                });

                $("#popup-button-no", "#cs-popup-center").click(function (e)
                {
                    gemini_popup.popupClose(e);
                });

                $("#popup-button-yes", "#cs-popup-center").click(function (e)
                {
                    gemini_ui.startBusy('#cs-popup-center #popup-button-yes');
                    var payload = "";

                    if (transfered > 0) payload = "owner=" + transfered;

                    gemini_ajax.postCall('action', 'delete', function (response)
                    {
                        gemini_popup.popupClose(e);
                        $("#card-holder").html(response.Result.Data);
                        gemini_appnav.pageCard.Id = 0;
                        gemini_appnav.initCardActions();
                        gemini_ui.stopBusy('#cs-popup-center #popup-button-yes');
                    },
                    function () { gemini_ui.stopBusy('#cs-popup-center #popup-button-yes'); }, payload);
                });

            }, null);
        });
    },

    /* If your card changes you can choose to create a clone with those changes (and leaving the original card intact */
    duplicate: function(cardData) {
        if (cardData == null) return;
                
        cardData = JSON.stringify(cardData);

        gemini_ajax.postCall('action', 'duplicate', function(response) {
                $("#card-holder").html(response.Result.Data);
                gemini_appnav.initCardActions();
                window.location.href = csVars.Url + 'workspace/' + response.Result.PageCard.Id + '/' + response.Result.PageCard.Url;
            }, null, cardData);
    },

    /* If your card changes you can choose to update the saved card */
    update: function (cardData)
    {
        if (cardData == null) return;
        cardData = JSON.stringify(cardData);

        gemini_ajax.postCall('action', 'update', function (response) {
                gemini_popup.toast(response.Result.Message);
            },null, cardData);
    },   
    
    /* Setup to handle card scrolling */
    scroller: function ()
    {
        if (gemini_appnav.cardOffScreenCount == 0)
        {
            $("#card-scroller", "#zone-side-bar").hide();
            return;
        }
                
        $("#card-scroller", "#zone-side-bar").show();

        $("#card-scroller-down", "#card-scroller").off("click");
        $("#card-scroller-up", "#card-scroller").off("click");

        $("#card-scroller-down", "#card-scroller").on("click", function (e)
        {
            gemini_appnav.stopRefresh = true;
            var x = $(".card:last-child", "#zone-side-bar").offset().top + gemini_appnav.cardHeight;

            if (x > $("#card-scroller", "#zone-side-bar").offset().top)
            {
                var pageSize = (gemini_appnav.pageSize - 3);
                if (pageSize <= 0) pageSize = 2;

                var top = parseInt($("#card-holder-container", "#zone-side-bar").css('top'));
                top = top - pageSize * gemini_appnav.cardHeight;

                $("#card-holder-container", "#zone-side-bar").css("top", top+'px');
            }
        });

        $("#card-scroller-up", "#card-scroller").on("click", function (e)
        {
            var pageSize = (gemini_appnav.pageSize - 3);
            if (pageSize <= 0) pageSize = 2;

            var top = parseInt($("#card-holder-container", "#zone-side-bar").css('top'));
            top = top + pageSize * gemini_appnav.cardHeight;

            if (top >= gemini_appnav.originalTop)
            {
                top = gemini_appnav.originalTop;
                gemini_appnav.stopRefresh = false;
            }

            $("#card-holder-container", "#zone-side-bar").css("top", top);
        });
    },

    /* Callback when browser window size changes */
    resizeWindow: function ()
    {
        gemini_appnav.initCardActions();
    },

    /* Check if the card is visible on the window  */
    isOnScreen: function (element) {
        var curBottom = (element.position().top) + (parseInt($(element).css('height'))) + (parseInt($('#card-scroller').css('height')) + $(element).height());
        var screenHeight = $(window).height();
        return (curBottom > screenHeight) ? false : true;
    },

    /* Set the footers card data if we have a card */
    setAppNavToolbar: function ()
    {
        // We don't have an AppNav card for this page, so hide the toolbar
        if (gemini_appnav.pageCard.Id == 0 /*|| gemini_appnav.pageCard.CardType == gemini_commons.PAGE_TYPE.Custom*/ || gemini_appnav.pageCard.CardType == gemini_commons.PAGE_TYPE.Marketing)
        {
            $("#pin-page").css('color', "");
            $('#appnav-toolbar').hide();
            return;
        }

        // Set the toolbar data
        $('.code','#appnav-toolbar').html(gemini_appnav.pageCard.Key);
        $('.title', '#appnav-toolbar').html(gemini_appnav.pageCard.Title);
        $('.title', '#appnav-toolbar').attr('title', gemini_appnav.pageCard.Title);
        $('#appnav-toolbar').css('background-color', gemini_appnav.pageCard.Color).css('display', 'inline-block');
        $('.save-small', '#appnav-toolbar').css('background-color', gemini_appnav.pageCard.Color);

        // Show / hide badge count
        if (gemini_appnav.pageCard.BadgeCount == 0) {
            $('#appnav-toolbar-badge-changes').hide();
        }
        else {
            $('span', '#appnav-toolbar-badge-changes').html(gemini_appnav.pageCard.BadgeCount < 6 ? gemini_appnav.pageCard.BadgeCount : '5+');
            $('#appnav-toolbar-badge-changes').show();
        }

        if (gemini_appnav.pageCard.CardData.Chat.BadgeCount == 0)
        {
            $('#appnav-toolbar-badge-chat').hide();
            $('#appnav-toolbar-badge-chat2').hide();
        }
        else
        {
            $('span', '#appnav-toolbar-badge-chat').html(gemini_appnav.pageCard.CardData.Chat.BadgeCount < 6 ? gemini_appnav.pageCard.CardData.Chat.BadgeCount : '5+');
            $('span', '#appnav-toolbar-badge-chat2').html(gemini_appnav.pageCard.CardData.Chat.BadgeCount < 6 ? gemini_appnav.pageCard.CardData.Chat.BadgeCount : '5+');
            $('#appnav-toolbar-badge-chat').show();
            $('#appnav-toolbar-badge-chat2').show();
        }
        
        // Handle actions
        $("#appnav-toolbar-save, #appnav-toolbar .save-small").unbind('click').bind('click', function (e) {
            if (gemini_appnav.pageCard != null) {
                gemini_appnav.update(gemini_appnav.pageCard);
            }
        });

        $("#appnav-toolbar-copy").unbind('click').bind('click', function (e) {
            if (gemini_appnav.pageCard != null) {
                gemini_appnav.duplicate(gemini_appnav.pageCard);
            }
        });

        $("#appnav-toolbar-delete").unbind("click").bind("click", function (e) {
            gemini_appnav.removeCard(gemini_appnav.pageCard.Id);
        });

        $("#appnav-toolbar-configure").unbind("click").bind("click", function (e) {
            gemini_appnav.showAppNavBox();
        });
        
        $('#appnav-toolbar-badge-changes').unbind("click").bind("click", function (e) {
            gemini_ajax.postCall('action', 'clearcount', function (response) {
                if (response.success) {
                    gemini_appnav.pageCard.BadgeCount = 0;
                    $('#appnav-toolbar-badge-changes').hide();
                    gemini_appnav.refresh();
                    $('tr.issue-highlight', '#data').removeClass('issue-highlight');
                    planner.removeHighlight(gemini_appnav.pageCard.CardData.Badges);
                }
            }, null, { cardId: gemini_appnav.pageCard.Id });
        });
        
        $('#appnav-toolbar-badge-chat, #appnav-toolbar-badge-chat2').unbind("click").bind("click", function (e) {
            gemini_commons.stopClick(e);
            gemini_ajax.postCall('action', 'clearchatcount', function (response) {
                if (response.success) {
                    gemini_appnav.pageCard.CardData.Chat.BadgeCount = 0;
                    $('#appnav-toolbar-badge-chat').hide();
                    $('#appnav-toolbar-badge-chat2').hide();
                    $('.not-seen', '#workspace-chat-zone').each(function ()
                    {
                        $(this).removeClass('not-seen');
                    });
                    
                    gemini_appnav.refresh();
                }
            }, null, { cardId: gemini_appnav.pageCard.Id });
        }); 

    },

    /* Edit screen */
    showAppNavBox: function (defaultTab)
    {
        $("#cs-popup-center-content").css("width", "800px");
        $("#cs-popup-center-content").css("height", "380px");

        gemini_commons.translateMessage("[[Save]],[[Cancel]]", ['Save', 'Cancel'], function (message) {
            var translations = message.split(",");
            add = translations[0];
            cancel = translations[1];

            gemini_popup.centerPopup("action", 'edit', null, null, add, cancel, null, null,
                 function () {
                     if (defaultTab == 'dashboard') {
                         $('#colorbox #edit-appnav-card div[data-tab="appnav-dashboard"]').click();
                     }
                     else if ($('#colorbox #edit-appnav-card div[data-tab="appnav-changes"]').length > 0 && gemini_appnav.pageCard.BadgeCount > 0) {
                         $('#colorbox #edit-appnav-card div[data-tab="appnav-changes"]').click();
                     }
                     else {
                         $('#colorbox #edit-appnav-card #tabs-left-content > div:first').click();
                         $('#edit-appnav-card #Key').focus();
                     }

                     setTimeout(function () {
                         $('#colorbox #edit-appnav-card #tabs-content').focus().click();
                     }, 200);
                 }
            );
        });
    },

    /* Edit screen handler */
    popup: function (cardColor)
    {
        $("#cs-popup-center").css("display", "block"); //ensure the div stays this width if content inside is changed

        // Fix for browsers (i.e IE9) which don't support placeholder attribute
        if (!Modernizr.input.placeholder)
        {
            $("#edit-appnav-card input[type=text]").each(function ()
            {
                if ($(this).attr("placeholder") != "")
                {

                    $(this).addClass("search_box_placeholder");

                    if ($(this).val() == '') $(this).val($(this).attr("placeholder"));
                    $(this).focus(function ()
                    {
                        if ($(this).val() == $(this).attr("placeholder")) $(this).val("");
                        $(this).removeClass("search_box_placeholder");
                    });

                    $(this).blur(function ()
                    {
                        if ($(this).val() == "")
                        {
                            $(this).val($(this).attr("placeholder"));
                            $(this).addClass("search_box_placeholder");
                        }
                    });
                }
            });

            $("#edit-appnav-card textarea").each(function ()
            {
                if ($(this).attr("placeholder") != "")
                {

                    $(this).addClass("search_box_placeholder");

                    if ($(this).val() == '') $(this).val($(this).attr("placeholder"));
                    $(this).focus(function ()
                    {
                        if ($(this).val() == $(this).attr("placeholder")) $(this).val("");
                        $(this).removeClass("search_box_placeholder");
                    });

                    $(this).blur(function ()
                    {
                        if ($(this).val() == "")
                        {
                            $(this).val($(this).attr("placeholder"));
                            $(this).addClass("search_box_placeholder");
                        }
                    });
                }
            });
        }

        gemini_ui.chosen("#edit-appnav-card #Taxonomy", null, true);

        gemini_ui.chosen("#edit-appnav-card #InteractionGroupList", null, true);
        if($("#edit-appnav-card #InteractionUserList").hasClass('no-chosen'))
        {
            gemini_ui.ajaxChosen('#edit-appnav-card #InteractionUserList', null, true, 'workspace/' + gemini_appnav.pageCard.Id + '/action/finduser');
        }
        else
        {
            gemini_ui.chosen("#edit-appnav-card #InteractionUserList", null, true);
        }

        gemini_ui.chosen("#edit-appnav-card #ReportsGroupList", null, true);
        if($("#edit-appnav-card #ReportsUserList").hasClass('no-chosen'))
        {
            gemini_ui.ajaxChosen('#edit-appnav-card #ReportsUserList', null, true, 'workspace/' + gemini_appnav.pageCard.Id + '/action/finduser');
        }
        else
        {
            gemini_ui.chosen("#edit-appnav-card #ReportsUserList", null, true);
        }
        gemini_ui.chosen("#edit-appnav-card #ReportsExcelList", null, true);

        gemini_ui.chosen("#edit-appnav-card #EmailToListGroups", null, true);
        if($("#edit-appnav-card #EmailToListUsers").hasClass('no-chosen'))
        {
            gemini_ui.ajaxChosen('#edit-appnav-card #EmailToListUsers', null, true, 'workspace/' + gemini_appnav.pageCard.Id + '/action/finduser');
        }
        else
        {
            gemini_ui.chosen("#edit-appnav-card #EmailToListUsers", null, true);
        }

        gemini_ui.chosen("#edit-appnav-card #SubscriptionGroupsList", null, true);
        if($("#edit-appnav-card #SubscriptionUsersList").hasClass('no-chosen'))
        {
            gemini_ui.ajaxChosen('#edit-appnav-card #SubscriptionUsersList', null, true, 'workspace/' + gemini_appnav.pageCard.Id + '/action/finduser');
        }
        else
        {
            gemini_ui.chosen("#edit-appnav-card #SubscriptionUsersList", null, true);
        }

        gemini_appnav.ToggleUpdateButtons(true);



        // Save the AppNav details
        $("#popup-button-yes").click(function (e)
        {
            if ($("#edit-appnav-card #regular-form").valid())
            {
                gemini_ui.startBusy('#colorbox #popup-button-yes');
                var showDashboard = $('div.selected', '#edit-appnav-card').attr('data-tab') == 'appnav-dashboard' && $("#edit-appnav-card #regular-form #dashboard-widgets input:checked").length > 0;
                gemini_ajax.postCall("action", "updatecard", function (response)
                {
                    if (response.Success)
                    {
                        if (response.Result.Refresh)
                        {
                            gemini_ui.stopBusy('#colorbox #popup-button-yes');
                            
                            gemini_commons.refreshPage();
                            return;
                        }
                        gemini_popup.toast(response.Message);
                        var id = $('#edit-appnav-card #id').val();
                        $('.key', $('#card-' + id)).html($('#edit-appnav-card #Key').val());
                        $('#card-' + id).attr('title', $('#edit-appnav-card #Title').val());
                        closePopup(e);
                        gemini_appnav.refresh();
                        gemini_appnav.pageCard = response.Result.PageCard;
                        gemini_appnav.setAppNavToolbar();
                        if (showDashboard)
                        {
                            gemini_dashboard.fetch();
                        }
                    }
                    gemini_ui.stopBusy('#colorbox #popup-button-yes');
                }, function ()
                {
                    gemini_ui.stopBusy('#colorbox #popup-button-yes');
                    closePopup(e);
                }, $("#edit-appnav-card #regular-form").serialize());
            }
        });

        $('#edit-appnav-card #send-report').click(function ()
        {
            var selectedReports = $("#edit-appnav-card #ReportsExcelList").val();
            var selectedGroups = $('#edit-appnav-card #ReportsGroupList').val();
            var selectedUsers = $('#edit-appnav-card #ReportsUserList').val();

            $("#edit-appnav-card #ReportsExcelList").removeClass('error');
            //$("#edit-appnav-card #ReportsGroupList").removeClass('error');
            //$("#edit-appnav-card #ReportsUserList").removeClass('error');

            if (selectedReports != null)
            {
                gemini_ui.startBusy2('#edit-appnav-card #send-report', "#progress-indicator");
                gemini_ajax.postCall("action", "sendreport", function (response)
                {

                    if (response.Success)
                    {
                        gemini_popup.toast("Report sent");
                    }
                    gemini_ui.stopBusy2('#edit-appnav-card #send-report');
                }, function (e)
                {
                    gemini_ui.stopBusy2('#edit-appnav-card #send-report');
                    gemini_popup.toast("Report not sent", true);
                }, $("#edit-appnav-card #regular-form").serialize());
            }
            else
            {
                if (selectedReports == null)
                {
                    $("#edit-appnav-card #ReportsExcelList").addClass('error');
                }

                /* if (selectedGroups == null && selectedUsers == null) {
                     $("#edit-appnav-card #ReportsGroupList").addClass('error');
                     $("#edit-appnav-card #ReportsUserList").addClass('error');
                 }*/
            }
        });

        $('#edit-appnav-card #send-items').click(function ()
        {
            $('#edit-appnav-card .send-items-container').removeClass('hide');
            $("#edit-appnav-card #jump-to-send-email").click();
        });

        $('#edit-appnav-card #clear-items').click(function ()
        {
            if ($("#edit-appnav-card .updates tbody input:checkbox:checked").length > 0)
            {
                gemini_ui.startBusy2('#edit-appnav-card #clear-items', "#progress-indicator");
                gemini_ajax.postCall("action", "clearitems", function (response)
                {
                    if (response.Success)
                    {
                        var itemNumber = $("#edit-appnav-card .updates tbody input.item-badge:checkbox:checked").length;
                      
                        var newCount = response.Result.Count;

                        if (gemini_appnav.pageCard.BadgeCount >= itemNumber) gemini_appnav.pageCard.BadgeCount -= itemNumber;
                        
                        $('#edit-appnav-card #appnav-changes-tab').attr('data-update-count', newCount);
                        $('#edit-appnav-card #appnav-changes-tab span').html('(' + newCount + ')');

                        $('#edit-appnav-card #appnav-changes #clear-all-items').prop('value', $('#edit-appnav-card #appnav-changes #clear-all-items').data('label') + ' (' + gemini_appnav.pageCard.BadgeCount + ')');

                        $("#edit-appnav-card .updates tbody input.item-badge:checkbox:checked").each(function (index, key)
                        {
                            $('#tabledata #tr-issue-' + $(key).val()).removeClass('issue-highlight');
                            $(key).parents('tr:eq(0)').remove();
                        });
                        $("#edit-appnav-card .updates tbody").html(response.Result.BadgeList);

                        gemini_ui.fancyInputs('#edit-appnav-card .updates tbody .fancy');

                        gemini_appnav.attachItemsCheckboxEvents();

                        if (newCount == 0)
                        {
                            var closeAppNav = false;
                            if ($('#edit-appnav-card #toggle-checkbox').is(':checked'))
                            {
                                closeAppNav = true;
                            }

                            $('.updates','#edit-appnav-card #appnav-changes').empty();
                            $('#ws-buttons','#edit-appnav-card #appnav-changes').empty();

                            if (closeAppNav)
                            {
                                $('#colorbox #cs-popup-center-buttons #popup-button-no').click();
                            }

                        }
                        else
                        {
                            $('#toggle-checkbox').iCheck('uncheck');
                        }

                        gemini_appnav.ToggleUpdateButtons(true);

                        gemini_appnav.refresh();
                    }
                    gemini_ui.stopBusy2('#edit-appnav-card #clear-items');
                }, function () { gemini_ui.stopBusy2('#edit-appnav-card #clear-items'); }, $("#edit-appnav-card #regular-form").serialize());
            }
        });

        $('#edit-appnav-card #clear-all-items').click(function () {
            
                gemini_ui.startBusy2('#edit-appnav-card #clear-all-items', "#progress-indicator");
                gemini_ajax.postCall("action", "clearcount", function (response) {

                    if (response.Success) {
                        gemini_appnav.pageCard.BadgeCount = 0;
                        var newCount = 0


                        $('#edit-appnav-card #appnav-changes-tab').attr('data-update-count', newCount);
                        $('#edit-appnav-card #appnav-changes-tab span').html('(' + newCount + ')');

                        $("#edit-appnav-card .updates tbody input.item-badge:checkbox:checked").each(function (index, key)
                        {
                            $('#tabledata #tr-issue-' + $(key).val()).removeClass('issue-highlight');
                            $(key).parents('tr:eq(0)').remove();
                        });

                        $("#edit-appnav-card #appnav-changes .updates").remove();
                        
                        $('#colorbox #cs-popup-center-buttons #popup-button-no').click();                        

                        gemini_appnav.refresh();
                    }
                    gemini_ui.stopBusy2('#edit-appnav-card #clear-all-items');
                }, function () { gemini_ui.stopBusy2('#edit-appnav-card #clear-all-items'); }, { cardId: gemini_appnav.pageCard.Id });
            
        });

        $('#cancel-email-badges').click(function ()
        {
            $("#edit-appnav-card .send-items-container").addClass('hide');
        });

        $('#edit-appnav-card #email-badges').click(function ()
        {
            var checkboxCount = $("#edit-appnav-card .updates tbody input:checkbox:checked").length;
            var selectedGroups = $('#edit-appnav-card #EmailToListGroups').val();
            var selectedUsers = $('#edit-appnav-card #EmailToListUsers').val();

            $("#edit-appnav-card #EmailToListGroups").removeClass('error');
            $("#edit-appnav-card #EmailToListUsers").removeClass('error');
            $("#edit-appnav-card #email-subject").removeClass('error');
            $("#edit-appnav-card #email-message").removeClass('error');

            if (checkboxCount > 0 && (selectedGroups != null || selectedUsers != null) && $("#edit-appnav-card #email-subject").val() != '' && $("#edit-appnav-card #email-message").val() != '')
            {
                gemini_ui.startBusy('#edit-appnav-card #email-badges');
                gemini_ajax.postCall("action", "emailitems", function (response)
                {

                    if (response.Success)
                    {
                        gemini_popup.toast(response.Message);
                        $("#edit-appnav-card .send-items-container").addClass('hide');
                    }
                    else
                    {
                        gemini_popup.toast(response.Message, true);
                    }

                    gemini_ui.stopBusy('#edit-appnav-card #email-badges');
                }, function () { gemini_ui.stopBusy('#edit-appnav-card #email-badges'); }, $("#edit-appnav-card #regular-form").serialize());
            }
            else
            {
                if (checkboxCount == 0) gemini_popup.toast("Select items", true);

                if (selectedGroups == null && selectedUsers == null)
                {
                    $("#edit-appnav-card #EmailToListGroups").addClass('error');
                    $("#edit-appnav-card #EmailToListUsers").addClass('error');
                }

                if ($("#edit-appnav-card #email-subject").val() == '') $("#edit-appnav-card #email-subject").addClass('error');
                if ($("#edit-appnav-card #email-message").val() == '') $("#edit-appnav-card #email-message").addClass('error');

            }

        });

        $('#edit-appnav-card #follow-items').click(function ()
        {
            if ($("#edit-appnav-card .updates tbody input:checkbox:checked").length > 0)
            {
                gemini_ui.startBusy2('#edit-appnav-card #follow-items', "#progress-indicator");
                gemini_ajax.postCall("action", "followitems", function (response)
                {

                    if (response.Success)
                    {
                        gemini_popup.toast(response.Message);
                    }
                    else
                    {
                        gemini_popup.toast(response.Message, true);
                    }

                    gemini_ui.stopBusy2('#edit-appnav-card #follow-items');
                }, function () { gemini_ui.stopBusy2('#edit-appnav-card #follow-items'); }, $("#edit-appnav-card #regular-form").serialize());
            }

        });

        $('#edit-appnav-card #toggle-checkbox').bind('ifChanged', function ()
        {
            if ($(this).is(':checked'))
            {
                gemini_ui.scrollTo('#edit-appnav-card #tabs-content', '#edit-appnav-card #clear-items');
                $('#edit-appnav-card .updates .item-checkboxes').iCheck('check');
                gemini_appnav.ToggleUpdateButtons();
            }
            else
            {
                $('#edit-appnav-card .updates .item-checkboxes').iCheck('uncheck');
                gemini_appnav.ToggleUpdateButtons(true);
            }
        });

        gemini_appnav.attachItemsCheckboxEvents();

        $('#edit-appnav-card #tabs-left div').click(function ()
        {
            //Select tab
            $('#edit-appnav-card #tabs-left div').attr('class', 'normal');
            $(this).attr('class', 'selected');

            //Display selected content
            $('#edit-appnav-card #tabs-content > div').hide();
            $('#edit-appnav-card #tabs-content > #' + $(this).attr('data-tab')).show();
        });

        function closePopup(e)
        {
            gemini_popup.popupClose(e);
            $('#edit-appnav-card').remove();
            $('#cs-popup-center-buttons #delete-card').parent().remove();
        }

        if ($('#edit-appnav-card #schedule-appnav-emails').length > 0)
        {
            $('#edit-appnav-card #schedule-appnav-emails').cron({
                initial: ($('#email-interval').val() == '' ? "0 9 * * 2" : $('#email-interval').val()),
                onChange: function ()
                {
                    $('#edit-appnav-card #email-interval').val(($(this).cron("value")));
                },
                minuteOpts: {
                    minWidth: 100, // only applies if columns and itemWidth not set
                    itemWidth: 20,
                    columns: 4,
                    rows: undefined,
                    title: "Minutes Past the Hour"
                },
                timeMinuteOpts: {
                    minWidth: 100, // only applies if columns and itemWidth not set
                    itemWidth: 20,
                    columns: 4,
                    rows: undefined,
                    title: "Time: Minute"
                }
            });
        }
        $("#popup-button-no").click(function (e)
        {
            closePopup(e);
        });

        $(document).off('click', "#colorbox #delete-card").on('click', "#colorbox #delete-card", function (e)
        {
            var cardId = $('#edit-appnav-card #id').val();
            var title = $('#edit-appnav-card #Title').val();
            var thisObject = e;
            gemini_commons.translateMessage("[[Delete]] " + title + ' ?', ['Delete'], function (message)
            {
                gemini_popup.modalConfirm(message, null,
                    function ()
                    {
                        gemini_ajax.postCall('action', 'delete', function (response)
                        {
                            if (gemini_appnav.pageCard.Id != 0 && gemini_appnav.pageCard.Id == cardId)
                            {
                                $("#pin-page").toggleClass("pinned");
                                gemini_appnav.pageCard = response.Result.PageCard;
                            }
                            gemini_appnav.refresh();
                            closePopup(thisObject);
                        }, function ()
                        {
                            closePopup(thisObject);
                        }
                        );
                    }, function (e) { closePopup(e); }, null);
            }
                );
        });

        /* card color picker */

        $(".swatch-color", "#appnav-description").click(function (e)
        {
            var color = $(this).css("background-color");
            $("#color-picker-color", "#appnav-description").css("background-color", color);
            $("#Color", "#appnav-description").val(color);
            $('#colorSelector', "#appnav-description").ColorPickerSetColor(color);
        });

        $('#colorSelector', "#appnav-description").ColorPicker({
            onChange: function (hsb, hex, rgb)
            {
                $('#colorSelector div', "#appnav-description").css('backgroundColor', '#' + hex);
                $('#ColorCode', "#appnav-description").val('#' + hex);
            },
            onSubmit: function (hsb, hex, rgb, el)
            {
                $(el).val(hex);
                $(el).ColorPickerHide();
                $('#Color', "#appnav-description").val('#' + hex);
                $('#Color', "#appnav-description").change();
            },
            color: cardColor
        });

        gemini_ui.fancyInputs('#edit-appnav-card .fancy');
        $('.colorpicker').addClass('z-index-max');
        $("#dashboard-widgets tbody", "#edit-appnav-card").sortable({
            forcePlaceholderSize: true,
            placeholder: "drag-placeholder",
            containment: "#dashboard-widgets",
            delay: '150',
            start: function (event, ui)
            {
                $(ui.helper).addClass("drag-highlight");
            },
            stop: function (event, ui)
            {
                $(ui.item).removeClass("drag-highlight");
            }
        });

        $('#share-lock', '#edit-appnav-card').bind('ifChanged', function (e)
        {
            if (!$(this).prop('checked'))
            {
                $('#share-chat').prop('checked', false);
                $('#share-chat').attr('disabled', 'disabled');
            }
            else
            {
                $('#share-chat').prop('checked', true);
                $('#share-chat').removeAttr('disabled');
            }
            $('#share-chat').iCheck('update');
        });
    },

    /* New screen */
    newWorkspace: function ()
    {
        $("#cs-popup-center-content").css("width", "615px");
        $("#cs-popup-center-content").css("height", "400px");

        var add = "Save";

        gemini_commons.translateMessage("[[Add]],[[Cancel]]", ['Add', 'Cancel'], function (message)
        {
            var translations = message.split(",");
            add = translations[0];
            cancel = translations[1];
          
            gemini_popup.centerPopup("action", 'new', null, null, add, cancel, null, null,
                function ()
                {
                    gemini_ui.fancyInputs('#edit-appnav-card .fancy');
                    $("#popup-button-no", "#cs-popup-center").click(function (e)
                    {
                        gemini_popup.popupClose(e);
                    });

                    $("#popup-button-yes", "#cs-popup-center").click(function (e)
                    {
                        if ($("#edit-appnav-card #regular-form").valid())
                        {
                            gemini_appnav.pageCard.Key = $('#Key', '#edit-appnav-card #regular-form').val();
                            gemini_appnav.pageCard.Title = $('#Title', '#edit-appnav-card #regular-form').val();
                            gemini_appnav.pageCard.Color = $('#Color', '#edit-appnav-card #regular-form').val();
                            gemini_appnav.pageCard.CardData.Taxonomy = $('#Taxonomy', '#edit-appnav-card #regular-form').val();
                            gemini_appnav.pageCard.CardData.Menu.Menus = [];
                            if ($('#workspace-menu-grid', '#edit-appnav-card #regular-form').prop('checked'))
                            {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Items });
                            }
                            if ($('#workspace-menu-board', '#edit-appnav-card #regular-form').prop('checked'))
                            {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Planner });
                            }
                            if ($('#workspace-menu-calendar', '#edit-appnav-card #regular-form').prop('checked'))
                            {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Calendar });
                            }
                            if ($('#workspace-menu-timeline', '#edit-appnav-card #regular-form').prop('checked'))
                            {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Timeline });
                            }
                            if ($('#workspace-menu-progress', '#edit-appnav-card #regular-form').prop('checked'))
                            {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Burndown });
                            }
                            
                            $('input.custom-app:checked', '#edit-appnav-card').each(function ()
                            {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Custom, AppId: $(this).attr('data-appid'), ControlId: $(this).attr('data-controlid') });
                            });
                            var cardData = JSON.stringify(gemini_appnav.pageCard);
                            gemini_ajax.postCall('action', 'add', function (response) {
                                $("#card-holder").html(response.Result.Data);
                                var currentCard = gemini_appnav.pageCard.Id > 0;
                                gemini_appnav.pageCard = response.Result.PageCard;
                                window.location.href = $('a', '#card-' + gemini_appnav.pageCard.Id).attr('href');
                                gemini_appnav.initCardActions();
                            }, null, cardData);

                            gemini_popup.popupClose(e);
                        }
                    });

                    gemini_ui.chosen("#edit-appnav-card #Taxonomy", null, true);
                    $("#Key", "#cs-popup-center").focus();
                    $("#edit-appnav-card #regular-form").validate();

                    // Fix for browsers (i.e IE9) which don't support placeholder attribute
                    if (!Modernizr.input.placeholder)
                    {
                        $("#edit-appnav-card input[type=text]").each(function ()
                        {
                            gemini_ui.legacyPlaceholder($(this));
                        });
                    }

                    $(".swatch-color", "#appnav-description").click(function (e)
                    {
                        var color = $(this).css("background-color");
                        $("#color-picker-color", "#appnav-description").css("background-color", color);
                        $("#Color", "#appnav-description").val(color);

                        $("#popup-button-yes", "#cs-popup-center").css("background-color", color);
                        $("#Key", "#cs-popup-center").css("border-color", color);
                    });
                }, null
            );
        });
    },
    attachItemsCheckboxEvents: function () {
        $('#edit-appnav-card .item-checkboxes').unbind('ifChanged').bind('ifChanged', function () {
            if ($("#edit-appnav-card .updates tbody input:checkbox:checked").length > 0 || $(this).is(':checked')) {
                gemini_appnav.ToggleUpdateButtons();
            }
            else {
                gemini_appnav.ToggleUpdateButtons(true);
            }
        });
    },
    ToggleUpdateButtons: function (disabled) {
        if (disabled) {
            $('#edit-appnav-card #send-items').attr('disabled', 'disabled').removeClass('button-secondary').addClass('button-secondary-disabled');
            $('#edit-appnav-card #email-badges').attr('disabled', 'disabled').removeClass('button-primary').addClass('button-secondary-disabled');
            $('#edit-appnav-card #clear-items').attr('disabled', 'disabled').removeClass('button-secondary').addClass('button-secondary-disabled');
            $('#edit-appnav-card #follow-items').attr('disabled', 'disabled').removeClass('button-secondary').addClass('button-secondary-disabled');
            //$('#edit-appnav-card #clear-all-items').attr('disabled', 'disabled').removeClass('button-secondary').addClass('button-secondary-disabled');
        }
        else {
            $('#edit-appnav-card #send-items').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-secondary');
            $('#edit-appnav-card #email-badges').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-primary');
            $('#edit-appnav-card #clear-items').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-secondary');
            $('#edit-appnav-card #follow-items').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-secondary');
            //$('#edit-appnav-card #clear-all-items').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-secondary');
        }
    }
};
