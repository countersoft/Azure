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
    
    /* Setup the appnav zone */
    init: function ()
    {
        // Card click handlers
        gemini_appnav.initCardActions();

        // Periodic card refresh
        gemini_appnav.refreshTimer();

        if ($('#card-holder .card.selected').length && !gemini_appnav.isOnScreen($('#card-holder .card.selected'))) {
            gemini_appnav.stopRefresh = true;
            var top = $('#card-holder .card.selected').offset().top;
            var screenHeight = $(window).height();
            top = top - screenHeight + gemini_appnav.cardHeight + parseInt($('#card-scroller').css('height'));
            $("#card-holder-container", "#zone-side-bar").css("top", (gemini_appnav.originalTop - top) + 'px');
        }
    },

    isOnScreen : function(element)
    {
        var curBottom = (element.offset().top) + (parseInt($(element).css('height'))) + (parseInt($('#card-scroller').css('height')));
        var screenHeight = $(window).height();
        return (curBottom > screenHeight) ? false : true;
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

            if (!$(this).hasClass("system")) gemini_appnav.click(this);
        });

        gemini_appnav.pageSize = gemini_appnav.cardCount - gemini_appnav.cardOffScreenCount;

        // Highlight current card
        $("#card-" + gemini_appnav.pageCard.Id).addClass("selected");

        // If we have current card sort out card actions
        if ($("#pin-page").hasClass("pinned"))
        {
            gemini_appnav.showPinnedPageActions();
        }
        else
        {
            gemini_appnav.hidePinnedPageActions();
        }

        // If pin icon hidden then remove the space that it uses
        if (!$("#pin-page").length) $("#card-holder-container").css("top", "35px");

        // Card drag-drop
        $(".cards", "#card-holder").sortable({
            forcePlaceholderSize: true,
            forceHelperSize: true,
            placeholder: "drag-placeholder",
            connectWith: ".card",
            items: ".card:not(.system)",
            delay: csVars.IEVersion == -1 || csVars.IEVersion >= 9 ? 250 : 0,
            helper: function (event, ui) {
                $(ui).addClass('hovered');
                return ui;
            },
            start: function (event, ui) {
                gemini_appnav.stopRefresh = true;
                $(ui.item).addClass("dragging");
            },
            stop: function (event, ui) {
                gemini_appnav.stopRefresh = false;
                $(ui.item).removeClass("dragging");
                $(ui.item).removeClass("hovered");
            },
            update: function (event, ui) {
                var sequenceList = "";

                $(".cards", "#card-holder").children().each(function () {
                    sequenceList += $(this).data("card-id");
                    sequenceList += "|";
                });

                $.ajax({
                    type: "POST",
                    url: csVars.Url + "cards/sort",
                    data: { sequence: sequenceList },
                    dataType: "json",
                    success: function(response) {
                        gemini_appnav.stopRefresh = false;
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        gemini_appnav.stopRefresh = false;
                        gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                    }
                });
            }
        });

        // Handle scrolling
        gemini_appnav.originalTop = parseInt($("#card-holder-container", "#zone-side-bar").css('top'));
        gemini_appnav.scroller();
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

        gemini_appnav.stopRefresh = true;

        if ($('#card-holder-container .card .info').is(':visible')) {
            gemini_appnav.stopRefresh = false;
            return;
        }

        $.ajax({
            type: "GET",
            url: csVars.Url + 'cards/fetch',
            success: function (response) {
                if (response.Result == undefined || response.Result == null || response.Result.Data == undefined || response.Result.Data == null) return;
                var i = 0;
                
                // We update the whole sidebar appnav zone
                $("#card-holder").empty();
                $("#card-holder").html(response.Result.Html);
                gemini_appnav.initCardActions();
                // Find and highlight new cards so user can see them
                var latestCards = _.pluck(response.Result.Data, 'Id');
                var newCards = _.difference(latestCards, gemini_appnav.previousCards);
                
                _.each(newCards, function (e) {
                    $('#card-' + e).css("visibility", "hidden").css("left", "30px").css("visibility", "visible").animate({ left: '0' }, { easing: 'easeOutBounce', duration: 1500 });
                });

                gemini_appnav.previousCards = latestCards;

                gemini_appnav.stopRefresh = false;
              
            },
            error: function (xhr, ajaxOptions, thrownError) {
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                gemini_appnav.stopRefresh = false;
            }
        });
    },

    /* Per card actions: remove card, show card options */
    click: function (card)
    {
        // handle card remove [x]
        $('.remove-card', $(card)).unbind("click").bind("click", function (e)
        {
            e.preventDefault();
            gemini_appnav.removeCard($(this).attr("card-id"));
        });

        // handle card options edit [x]
        $('.show-card-options', $(card)).unbind("click").bind("click", function (e)
        {
            e.preventDefault();

            $("#cs-popup-center-content").css("width", "800px");
            $("#cs-popup-center-content").css("height", "380px");
            
            gemini_popup.centerPopup("cards/popup", $(card).attr('data-card-id'), null, null, null, null, null, null,
                 function () {
                     if ($('#colorbox #edit-appnav-card div[data-tab="appnav-changes"]').length > 0 && $(card).attr("data-counter") > 0) {
                         $('#colorbox #edit-appnav-card div[data-tab="appnav-changes"]').click();
                     } else {
                         $('#colorbox #edit-appnav-card #tabs-left-content > div:first').click();
                         $('#edit-appnav-card #Key').focus();
                     }

                     setTimeout(function () {
                         $('#colorbox #edit-appnav-card #tabs-content').focus().click();
                     }, 200);

                     if ($('#colorbox #cs-popup-center-buttons #delete-card').length == 0) {
                         gemini_commons.translateMessage("[[Delete]]", ['Delete'], function (message) {
                             $('#colorbox #cs-popup-center-buttons').append('<div class="buttons left"><input id="delete-card" class="button-small button-primary margin-left-10" type="button" value="' + message + '"></input></div>');
                         });

                     }
                 }
            );
        });
    },

    /* Handles pinning and unpinning of cards */
    pinPage: function ()
    {
        var url = csVars.Url;
        var removing = false;

        if ($("#pin-page").hasClass("pinned")) {
            url = url + "cards/remove";
            removing = true;
        } else {
            url = url + "cards/add";
        }

        var cardData = JSON.stringify(gemini_appnav.pageCard);

        $.ajax({
            type: "POST",
            url: url,
            data: cardData,
            dataType: "json",
            success: function (response)
            {
                $("#pin-page").toggleClass("pinned");
                $("#card-holder").html(response.Result.Data);

                gemini_appnav.pageCard = response.Result.PageCard;

                if (removing)
                {
                    gemini_appnav.hidePinnedPageActions();
                    $("#header-bar-current-card-title").empty();
                }
                else
                {
                    $('#card-' + gemini_appnav.pageCard.Id).effect("shake", { times: 2, distance: 3, direction: "up" }, 500);
                    gemini_appnav.showPinnedPageActions();

                    // Only update page title for non item pages
                    if (gemini_appnav.pageCard.CardType != 11) {
                        $("#header-bar-current-card-title").html("<a href='" + csVars.Url + gemini_appnav.pageCard.Url + "?card=" + gemini_appnav.pageCard.Id + "'>" + gemini_appnav.pageCard.Title + "</a>");
                    }
                }
                
                gemini_appnav.initCardActions();
                $('.show-card-options', $("#card-" + gemini_appnav.pageCard.Id)).click();
            },
            error: function(xhr, ajaxOptions, thrownError) {
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
            }
        });
    },
    
    /* Handles the [x] button press on every card */
    removeCard: function(cardId)
    {
        $.ajax({
            type: "POST",
            url: csVars.Url + "cards/delete/" + cardId,
            data: JSON.stringify(gemini_appnav.pageCard),
            dataType: "json",
            success: function (response)
            {
                $("#card-holder").html(response.Result.Data);

                gemini_appnav.initCardActions();
            },
            error: function (xhr, ajaxOptions, thrownError) {
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
            }
        });
    },

    /* If your card changes you can choose to create a clone with those changes (and leaving the original card intact */
    duplicate: function(cardData) {
        if (cardData == null) return;

        var url = csVars.Url + "cards/duplicate/";

        cardData = JSON.stringify(cardData);

        $.ajax({
            type: "POST",
            url: url,
            data: cardData,
            dataType: "json",
            success: function(response) {
                $("#card-holder").html(response.Result.Data);
                gemini_appnav.initCardActions();
                window.location.href = csVars.Url + response.Result.PageCard.Url + "?card=" + response.Result.PageCard.Id;
            },
            error: function(xhr, ajaxOptions, thrownError) {
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
            }
        });
    },

    /* If your card changes you can choose to update the saved card */
    update: function (cardData)
    {
        if (cardData == null) return;
        cardData = JSON.stringify(cardData);

        $.ajax({
            type: "POST",
            url: csVars.Url + "cards/update/",
            data: cardData,
            dataType: "json",
            success: function (response) {
                gemini_popup.toast(response.Result.Message);
            },
            error: function (xhr, ajaxOptions, thrownError)
            {
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
            }
        });
    },

    /* If an existing card has been changed then we have to show actions (update, clone) */
    showPinnedPageActions: function ()
    {
        $("#repin-pin").show();
        $("#save-pin").show();
        
        $("#repin-pin").unbind('click').bind('click', function (e) {
            if (gemini_appnav.pageCard != null) {
                gemini_appnav.duplicate(gemini_appnav.pageCard);
            }
        });

        $("#save-pin").unbind('click').bind('click', function (e) {
            if (gemini_appnav.pageCard != null) {
                gemini_appnav.update(gemini_appnav.pageCard);
            }
        });

        // make space to show card COPY/SAVE icons
        $("#card-holder-container").css("top", "98px");
        gemini_appnav.originalTop = 98;
    },

    /* If an existing card has been changed we show actions -- we then have to hide them at some point */
    hidePinnedPageActions: function ()
    {
        $("#repin-pin").hide();
        $("#save-pin").hide();
        
        $("#repin-pin").unbind('click');
        $("#save-pin").unbind('click');
        
        // eat space from card COPY/SAVE icons
        $("#card-holder-container").css("top", "75px");
        gemini_appnav.originalTop = 75;
    },

    /* Card popup actions handler */
    popup: function (cardColor)
    {
        $("#cs-popup-center").css("display", "block"); //ensure the div stays this width if content inside is changed

        // Fix for browsers (i.e IE9) which don't support placeholder attribute
        if (!Modernizr.input.placeholder) {
            $("#edit-appnav-card input[type=text]").each(function () {
                if ($(this).attr("placeholder") != "") {

                    $(this).addClass("search_box_placeholder");

                    if ($(this).val() == '') $(this).val($(this).attr("placeholder"));
                    $(this).focus(function () {
                        if ($(this).val() == $(this).attr("placeholder")) $(this).val("");
                        $(this).removeClass("search_box_placeholder");
                    });

                    $(this).blur(function () {
                        if ($(this).val() == "") {
                            $(this).val($(this).attr("placeholder"));
                            $(this).addClass("search_box_placeholder");
                        }
                    });
                }
            });

            $("#edit-appnav-card textarea").each(function () {
                if ($(this).attr("placeholder") != "") {

                    $(this).addClass("search_box_placeholder");

                    if ($(this).val() == '')  $(this).val($(this).attr("placeholder"));
                    $(this).focus(function () {
                        if ($(this).val() == $(this).attr("placeholder")) $(this).val("");
                        $(this).removeClass("search_box_placeholder");
                    });

                    $(this).blur(function () {
                        if ($(this).val() == "") {
                            $(this).val($(this).attr("placeholder"));
                            $(this).addClass("search_box_placeholder");
                        }
                    });
                }
            });
        }

        gemini_ui.chosen("#edit-appnav-card #InteractionGroupList", null, true);
        gemini_ui.chosen("#edit-appnav-card #InteractionUserList", null, true);

        gemini_ui.chosen("#edit-appnav-card #ReportsGroupList", null, true);
        gemini_ui.chosen("#edit-appnav-card #ReportsUserList", null, true);
        gemini_ui.chosen("#edit-appnav-card #ReportsExcelList", null, true);

        gemini_ui.chosen("#edit-appnav-card #EmailToListGroups", null, true);
        gemini_ui.chosen("#edit-appnav-card #EmailToListUsers", null, true);

        gemini_ui.chosen("#edit-appnav-card #SubscriptionGroupsList", null, true);
        gemini_ui.chosen("#edit-appnav-card #SubscriptionUsersList", null, true);

        ToggleUpdateButtons(true);
        
        function ToggleUpdateButtons(disabled) {
            if (disabled) {
                $('#edit-appnav-card #send-items').attr('disabled', 'disabled').removeClass('button-secondary').addClass('button-secondary-disabled');
                $('#edit-appnav-card #email-badges').attr('disabled', 'disabled').removeClass('button-primary').addClass('button-secondary-disabled');
                $('#edit-appnav-card #clear-items').attr('disabled', 'disabled').removeClass('button-secondary').addClass('button-secondary-disabled');
                $('#edit-appnav-card #follow-items').attr('disabled', 'disabled').removeClass('button-secondary').addClass('button-secondary-disabled');
            }
            else {
                $('#edit-appnav-card #send-items').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-secondary');
                $('#edit-appnav-card #email-badges').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-primary');
                $('#edit-appnav-card #clear-items').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-secondary');
                $('#edit-appnav-card #follow-items').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-secondary');
            }
        }

        $("#popup-button-yes").click(function (e) {
            if ($("#edit-appnav-card #regular-form").valid()) {
                gemini_ui.startBusy('#colorbox #popup-button-yes');
                gemini_ajax.postCall("cards", "updatecard", function (response) {
                    if (response.Success) {
                        gemini_popup.toast(response.Message);
                        var id = $('#edit-appnav-card #id').val();                       
                        $('.key', $('#card-' + id)).html($('#edit-appnav-card #Key').val());
                        $('.title', $('#card-' + id)).html($('#edit-appnav-card #Title').val());
                        $('.card-box', $('#card-' + id)).attr('title', $('#edit-appnav-card #appnav-comment').val());
                        closePopup(e);
                        gemini_appnav.refresh();
                        gemini_appnav.pageCard = response.Result.PageCard;
                    }
                    gemini_ui.stopBusy('#colorbox #popup-button-yes');
                }, function () {
                    gemini_ui.stopBusy('#colorbox #popup-button-yes');
                    closePopup(e);
                }, $("#edit-appnav-card #regular-form").serialize());
            }
        });

        $('#edit-appnav-card #send-report').click(function () {
            var selectedReports = $("#edit-appnav-card #ReportsExcelList").val();
            var selectedGroups = $('#edit-appnav-card #ReportsGroupList').val();
            var selectedUsers = $('#edit-appnav-card #ReportsUserList').val();

            $("#edit-appnav-card #ReportsExcelList").removeClass('error');
            //$("#edit-appnav-card #ReportsGroupList").removeClass('error');
            //$("#edit-appnav-card #ReportsUserList").removeClass('error');

            if (selectedReports != null) {
                gemini_ui.startBusy2('#edit-appnav-card #send-report', "#progress-indicator");
                gemini_ajax.postCall("cards", "sendreport", function (response) {

                    if (response.Success) {
                        gemini_popup.toast("Report sent");
                    }
                    gemini_ui.stopBusy2('#edit-appnav-card #send-report');
                }, function (e) {
                    gemini_ui.stopBusy2('#edit-appnav-card #send-report');
                    gemini_popup.toast("Report not sent",true);
                }, $("#edit-appnav-card #regular-form").serialize());
            }
            else {
                if (selectedReports == null) {
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

        $('#edit-appnav-card #clear-items').click(function () {
            if ($("#edit-appnav-card .updates tbody input:checkbox:checked").length > 0) {
                gemini_ui.startBusy2('#edit-appnav-card #clear-items', "#progress-indicator");
                gemini_ajax.postCall("cards", "clearitems", function (response) {

                    if (response.Success) {
                        var itemNumber = $("#edit-appnav-card .updates tbody input:checkbox:checked").length;
                        var currentCount = $('#edit-appnav-card #appnav-changes-tab').attr('data-update-count');
                        var newCount = currentCount - itemNumber;

                        $('#edit-appnav-card #appnav-changes-tab').attr('data-update-count', newCount);
                        $('#edit-appnav-card #appnav-changes-tab span').html('(' + newCount + ')');
                        $("#edit-appnav-card .updates tbody input:checkbox:checked").each(function (index, key) {
                            $('#tabledata #tr-issue-'+$(key).val()).removeClass('issue-highlight');
                            $(key).parents('tr:eq(0)').remove();
                        });

                        if (newCount == 0) {
                            var closeAppNav = false;
                            if ($('#edit-appnav-card #toggle-checkbox').is(':checked')) {
                                closeAppNav = true;
                            }

                            $('#edit-appnav-card #appnav-changes').empty();

                            if (closeAppNav) {
                                $('#colorbox #cs-popup-center-buttons #popup-button-no').click();
                            }
                           
                        }
                        else {
                            $('#toggle-checkbox').iCheck('uncheck');
                        }
                        
                        ToggleUpdateButtons(true);

                        gemini_appnav.refresh();
                    }
                    gemini_ui.stopBusy2('#edit-appnav-card #clear-items');
                }, function () { gemini_ui.stopBusy2('#edit-appnav-card #clear-items'); }, $("#edit-appnav-card #regular-form").serialize());
            }
        });

        $('#cancel-email-badges').click(function () {
            $("#edit-appnav-card .send-items-container").addClass('hide');
        });

        $('#edit-appnav-card #email-badges').click(function () {
            var checkboxCount = $("#edit-appnav-card .updates tbody input:checkbox:checked").length;
            var selectedGroups = $('#edit-appnav-card #EmailToListGroups').val();
            var selectedUsers = $('#edit-appnav-card #EmailToListUsers').val();

            $("#edit-appnav-card #EmailToListGroups").removeClass('error');
            $("#edit-appnav-card #EmailToListUsers").removeClass('error');
            $("#edit-appnav-card #email-subject").removeClass('error');
            $("#edit-appnav-card #email-message").removeClass('error');

            if (checkboxCount > 0 && (selectedGroups != null || selectedUsers != null) && $("#edit-appnav-card #email-subject").val() != '' && $("#edit-appnav-card #email-message").val() != '') {
                gemini_ui.startBusy('#edit-appnav-card #email-badges');
                gemini_ajax.postCall("cards", "emailitems", function (response) {

                    if (response.Success) {
                        gemini_popup.toast(response.Message);
                        $("#edit-appnav-card .send-items-container").addClass('hide');
                    }
                    else {
                        gemini_popup.toast(response.Message, true);
                    }

                    gemini_ui.stopBusy('#edit-appnav-card #email-badges');
                }, function () { gemini_ui.stopBusy('#edit-appnav-card #email-badges'); }, $("#edit-appnav-card #regular-form").serialize());
            }
            else {
                if (checkboxCount == 0)  gemini_popup.toast("Select items", true);                

                if (selectedGroups == null && selectedUsers == null) {
                    $("#edit-appnav-card #EmailToListGroups").addClass('error');
                    $("#edit-appnav-card #EmailToListUsers").addClass('error');
                }

                if ($("#edit-appnav-card #email-subject").val() == '') $("#edit-appnav-card #email-subject").addClass('error');
                if ($("#edit-appnav-card #email-message").val() == '') $("#edit-appnav-card #email-message").addClass('error');
                   
            }

        });

        $('#edit-appnav-card #follow-items').click(function () {
            if ($("#edit-appnav-card .updates tbody input:checkbox:checked").length > 0) {
                gemini_ui.startBusy2('#edit-appnav-card #follow-items', "#progress-indicator");
                gemini_ajax.postCall("cards", "followitems", function (response) {

                    if (response.Success) {
                        gemini_popup.toast(response.Message);
                    }
                    else {
                        gemini_popup.toast(response.Message, true);
                    }

                    gemini_ui.stopBusy2('#edit-appnav-card #follow-items');
                }, function () { gemini_ui.stopBusy2('#edit-appnav-card #follow-items'); }, $("#edit-appnav-card #regular-form").serialize());
            }

        });

        $('#edit-appnav-card #toggle-checkbox').bind('ifChanged', function () {
            if ($(this).is(':checked')) {
                gemini_ui.scrollTo('#edit-appnav-card #tabs-content', '#edit-appnav-card #clear-items');
                $('#edit-appnav-card .updates .item-checkboxes').iCheck('check');
                ToggleUpdateButtons();
            }
            else {
                $('#edit-appnav-card .updates .item-checkboxes').iCheck('uncheck');
                ToggleUpdateButtons(true);
            }
        });

        $('#edit-appnav-card .item-checkboxes').bind('ifChanged', function () {            
            if ($("#edit-appnav-card .updates tbody input:checkbox:checked").length > 0 || $(this).is(':checked') ) {
                ToggleUpdateButtons();
            }
            else {
                ToggleUpdateButtons(true);
            }
        });

        $('#edit-appnav-card #tabs-left div').click(function () {
            //Select tab
            $('#edit-appnav-card #tabs-left div').attr('class', 'normal');
            $(this).attr('class', 'selected');

            //Display selected content
            $('#edit-appnav-card #tabs-content > div').hide();
            $('#edit-appnav-card #tabs-content > #' + $(this).attr('data-tab')).show();
        });

        function closePopup(e) {
            gemini_popup.popupClose(e);
            $('#edit-appnav-card').remove();
            $('#cs-popup-center-buttons #delete-card').parent().remove();
        }

        if ($('#edit-appnav-card #schedule-appnav-emails').length > 0) {
            $('#edit-appnav-card #schedule-appnav-emails').cron({
                initial: ($('#email-interval').val() == '' ? "0 7 * * 1" : $('#email-interval').val()),
                onChange: function () {
                    $('#edit-appnav-card #email-interval').val(($(this).cron("value")));
                }
            });
        }
        $("#popup-button-no").click(function (e) {
            closePopup(e);
        });

        $(document).off('click', "#colorbox #delete-card").on('click', "#colorbox #delete-card", function (e) {
            var cardId = $('#edit-appnav-card #id').val();
            var title = $('#edit-appnav-card #Title').val();
            var thisObject = e;
            gemini_commons.translateMessage("[[Delete]] " + title + ' ?', ['Delete'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {                    
                        $.ajax({
                            type: "POST",
                            url: csVars.Url + "cards/delete/" + cardId,
                            data: "{}",
                            dataType: "json",
                            success: function (response) {
                                if (gemini_appnav.pageCard.Id != 0 && gemini_appnav.pageCard.Id == cardId) {
                                    $("#pin-page").toggleClass("pinned");
                                    gemini_appnav.pageCard = response.Result.PageCard;
                                }
                                gemini_appnav.refresh();
                                closePopup(thisObject);
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                                closePopup(thisObject);
                            }
                        });
                    }, function (e) { closePopup(e); }, null);
                    }
                );
        });

        /* card color picker */

        $(".swatch-color", "#appnav-description").click(function (e) {
            var color = $(this).css("background-color");
            $("#color-picker-color", "#appnav-description").css("background-color", color);
            $("#Color", "#appnav-description").val(color);
            $('#colorSelector', "#appnav-description").ColorPickerSetColor(color);
        });

        $('#colorSelector', "#appnav-description").ColorPicker({
            onChange: function (hsb, hex, rgb) {
                $('#colorSelector div', "#appnav-description").css('backgroundColor', '#' + hex);
                $('#ColorCode', "#appnav-description").val('#' + hex);
            },
            onSubmit: function (hsb, hex, rgb, el) {
                $(el).val(hex);
                $(el).ColorPickerHide();
                $('#Color', "#appnav-description").val('#' + hex);
                $('#Color', "#appnav-description").change();
            },
            color: cardColor
        });
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
    }
};
