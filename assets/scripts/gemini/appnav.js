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
    init: function (newWorkspace) {
        // Card click handlers
        gemini_appnav.initCardActions();

        // Periodic card refresh
        gemini_appnav.refreshTimer();


        gemini_appnav.initCentralWorkspaceList();
        // Make sure that the selected AppNav is visible (scroll to it if not)

        gemini_appnav.bindShortcuts();

        if (newWorkspace) {
            $('#appnav-toolbar-configure').click();
        }
    },
    cardDetails: [],
    bindShortcuts: function () {
        var selectedItem = -1;

        Mousetrap.bindGlobal('ctrl+/',
            function (e) {
                gemini_appnav.resetFilterList();

                if (!$("#workspace-filter").is(":visible")) {
                    $("#workspace-title").click();
                }
                $("#workspace-filter").focus();
                $.each($("#workspace-slider li.card"), function (index, item) {
                    gemini_appnav.cardDetails.push({ index: index, item: item, visible: $(item).is(":visible") });
                });
            });



        $("#workspace-filter").keypress(function (e) {
            gemini_appnav.doWorkspaceFilter(e.key);
        });
        $("#workspace-filter").keyup(function (e) {

            var localSelectedItem = selectedItem;
            if (e.key === "ArrowDown") {
                if (localSelectedItem >= gemini_appnav.cardDetails.length) {
                    return;
                }
                do {
                    localSelectedItem++;
                } while (localSelectedItem < gemini_appnav.cardDetails.length && !gemini_appnav.cardDetails[localSelectedItem].visible)
                if (localSelectedItem < gemini_appnav.cardDetails.length && gemini_appnav.cardDetails[localSelectedItem].visible) {
                    selectedItem = localSelectedItem;
                }
            } else if (e.key === "ArrowUp" && selectedItem >= 0) {
                do {
                    selectedItem--;
                } while (!gemini_appnav.cardDetails[localSelectedItem].visible && selectedItem > 0)
            } else if (e.key === "Enter") {
                var navCard = _.find(gemini_appnav.cardDetails,
                    function (item) {
                        return item.index === selectedItem;
                    });
                if (navCard != null ) {
                    $(navCard.item).find("a")[0].click();
                }
                return;
            }
            else if (e.key === "Backspace") {
                gemini_appnav.doWorkspaceFilter("");
            }
            else if (e.key === "Escape") {
                $("#workspace-filter").val("");
                if ($("#workspace-slider").is(":visible")) {
                    $("#workspace-title").click();
                }
            }
            else {

            }
            $(".cards li.card").removeClass("selected-card").css("background-color", "");
            var selectedCard = _.find(gemini_appnav.cardDetails, function (item) {
                return item.index === selectedItem;
            });
            if (selectedCard) {
                $(selectedCard.item).css("background-color", "gray");
            }


        });
    },
    sortSequencing:'',
    initCentralWorkspaceList: function () {
        $("#workspace-title").click(function (e) {

            var container = $("#workspace-slider .scroll-wrapper");
            var api = container.data('jsp');
            if (api != undefined || api != null) {
                api.destroy();
            }

            gemini_commons.stopClick(e);
            gemini_appnav.toggleDropdownIcon();

            gemini_appnav.resetFilterList();

            $("#workspace-slider").toggleClass("show"); //.slideDown();
            $("#workspace-filter").val("");

            gemini_appnav.stopRefresh = $("#workspace-slider").hasClass("show");
            if ($("#workspace-slider ul").data("card-count") > 11) {
                window.setTimeout(function () {
                    $("#workspace-slider .scroll-wrapper").jScrollPane({});
                },
                    500);
            }
            $("#workspace-filter").focus();

        });

        if ($("#workspace-badge-count").data("count") === 0) {
            $("#workspace-badge-count").css("visibility", "hidden");
        }

        $("#workspace-slider .cards").sortable({
            scrollSpeed: 40,
            start: function (event, ui) {
                var sequence = "";
                $("#workspace-slider .cards .card").each(function (index, item) {
                    var id = $(item).data("card-id");
                    if (parseInt(id)>0) {
                        sequence += id + "|"
                    }
                });
                if (sequence.length > 2) {
                    sequence = sequence.substring(0, sequence.length - 1);
                }
                //generate the sequence on start to compare with drop
                gemini_appnav.sortSequencing = sequence;
            },
            stop: function (event, ui) {
                var sequence = "";
                $("#workspace-slider .cards .card").each(function (index, item) {
                    var id = $(item).data("card-id");
                    sequence += id + "|"
                });
                if (sequence.length > 2) {
                    sequence = sequence.substring(0, sequence.length - 1);
                }
                if (gemini_appnav.sortSequencing != sequence) { //if the sequence has changed, call the update. No point refreshing cache needlessly
                    gemini_ajax.postCall("action", "sort", function (response) {
                        if (response.Result.Data != undefined || response.Result.Data != '') {
                            gemini_popup.toast(response.Result.Data);
                        }
                    }, null, { sequence: sequence }, {}, false);
                }
            }
        });
    },
    resetFilterList: function() {
        $("#workspace-filter").val("");
        gemini_appnav.doWorkspaceFilter("");
    },
    doWorkspaceFilter: function (key) {
        if (key !== null && key !== undefined && key.length > 1) {
            return;
        }
        var value = $("#workspace-filter").val() + key;
        value = value.toLowerCase();
        if (value === "") {
            $('.cards li.card').show();
        } else {
            $('.cards li.card').hide();
            var visibleCards = $('.cards li[data-key*="' + value + '"], .cards li[data-title*="' + value + '"]');
            visibleCards.show();
        }
        gemini_appnav.cardDetails.length = 0;
        $.each($("#workspace-slider li.card"), function (index, item) {
            gemini_appnav.cardDetails.push({ index: index, item: item, visible: $(item).is(":visible") });
        });
        var container = $("#workspace-slider .scroll-wrapper");
        var api = container.data('jsp');
        if (api != undefined || api != null) {
            api.reinitialise();
        }


    },
    toggleDropdownIcon: function () {
        $("#workspace-title .drop-down-icon").toggleClass("fa-caret-square-down").toggleClass("fa-caret-square-up");
    },
    /* For every card bind click handlers AND highlight current card */
    initCardActions: function () {
        // Show the current AppNav's card toolbar in the footer
        //gemini_appnav.setAppNavToolbar();
    },

    /* Periodic card refresh setup */
    refreshTimer: function () {
        var interval = csVars.AjaxPollInterval;
        if (interval === undefined)
            interval = 10000; // Every 10 seconds
        if (interval > 0) { //0 setting disables
            setInterval(gemini_appnav.refresh, interval);
        }
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

        gemini_ajax.postCall('workspace/' + gemini_appnav.pageCard.Id + '/action', 'fetch', function (response) {
            if (response.Result == undefined || response.Result == null || response.Result.Data == undefined || response.Result.Data == null) return;
            var i = 0;

            if (gemini_appnav.pageCard.Id === 0)
                return; //no card to refresh

            // If our card has been deleted
            var pageCard = _.find(response.Result.Data,
                function (item) {
                    return item.Id === gemini_appnav.pageCard.Id;
                });
            if (gemini_appnav.pageCard.Id != 0 && pageCard === undefined) {
                gemini_appnav.pageCard.Id = 0;
            } else {
                //There is a page card
                //update count & colour on main page
                $("header #workspace-badge-count .badge span").html(pageCard.BadgeCountLabel);
                $("header #workspace-badge-count .badge").css("background-color", pageCard.Color);
                if (pageCard.BadgeCount > 0) {
                    $("#workspace-badge-count").css("visibility", "visible");
                } else {
                    $("#workspace-badge-count").css("visibility", "hidden");
                }
            }

            if (response.Result.Html !== undefined) {
                $("#workspace-slider").html(response.Result.Html);
                gemini_appnav.bindShortcuts();
            }

            if (gemini_appnav.pageCard.Id != 0) {
                gemini_appnav.pageCard.BadgeCount = pageCard.BadgeCount;
            }
            gemini_appnav.initCardActions();
            // Find and highlight new cards so user can see them
            var latestCards = _.pluck(response.Result.Data, 'Id');
            var newCards = _.difference(latestCards, gemini_appnav.previousCards);

            if (newCards.length) {
                setTimeout(function () {
                    $("#refresh-workspace-icon").removeClass("rotating");
                },
                    10000);

            }

            gemini_appnav.previousCards = latestCards;

            gemini_appnav.stopRefresh = false;
            gemini_appnav.inRefresh = false;

        },
            function () {
                gemini_appnav.stopRefresh = false;
                gemini_appnav.inRefresh = false;
            }, gemini_chat.getPostParameters(), null, true);
    },

    /* Delete card */
    removeCard: function (cardId) {
        $("#cs-popup-center-content").css("width", "400px");
        $("#cs-popup-center-content").css("height", "150px");

        var buttonDeleteText = "";
        var buttonTransferText = "";
        var transfered = 0;

        gemini_commons.translateMessage("[[Move]]", ['Move'], function (message) { buttonTransferText = message; });

        gemini_commons.translateMessage("[[Delete]]", ['Delete'], function (message) {
            buttonDeleteText = message;

            gemini_popup.centerPopup("action/delete", 'show', null, null, buttonDeleteText, null, null, null, function () {
                gemini_ui.chosen("#delete-workspace #Owner", null, true);

                $('#delete-workspace #Owner').change(function () {
                    if ($(this).val() > 0) {
                        transfered = $(this).val();
                        $("#popup-button-yes", "#cs-popup-center").val(buttonTransferText);
                    }
                    else {
                        transfered = 0;
                        $("#popup-button-yes", "#cs-popup-center").val(buttonDeleteText);
                    }
                });

                $("#popup-button-no", "#cs-popup-center").click(function (e) {
                    gemini_popup.popupClose(e);
                });

                $("#popup-button-yes", "#cs-popup-center").click(function (e) {
                    gemini_ui.startBusy('#cs-popup-center #popup-button-yes');
                    var payload = "";

                    if (transfered > 0) payload = "owner=" + transfered;

                    gemini_ajax.postCall('action', 'delete', function (response) {
                        gemini_popup.popupClose(e);
                        var firstCard = $("#workspace-slider .cards li:first").data("card-id");
                        window.location = csVars.Url + 'workspace/' + firstCard + '/items';
                        gemini_ui.stopBusy('#cs-popup-center #popup-button-yes');
                    },
                        function () { gemini_ui.stopBusy('#cs-popup-center #popup-button-yes'); }, payload);
                });

            }, null);
        });
    },

    /* If your card changes you can choose to create a clone with those changes (and leaving the original card intact */
    duplicate: function (cardData) {
        if (cardData == null) return;

        cardData = JSON.stringify(cardData);

        gemini_ajax.postCall('action', 'duplicate', function (response) {
            $("#card-holder").html(response.Result.Data);
            gemini_appnav.initCardActions();
            window.location.href = csVars.Url + 'workspace/' + response.Result.PageCard.Id + '/' + response.Result.PageCard.Url;
        }, null, cardData);
    },

    /* If your card changes you can choose to update the saved card */
    update: function (cardData) {
        if (cardData == null) return;
        cardData = JSON.stringify(cardData);
        gemini_ui.startBusyDiv("#workspace-save");
        gemini_ajax.postCall('action', 'update', function (response) {
            gemini_popup.toast(response.Result.Message);
            gemini_ui.stopBusyDiv("#workspace-save");

        }, null, cardData);
    },

    /* Set the footers card data if we have a card */
    setAppNavToolbar: function () {
        // We don't have an AppNav card for this page, so hide the toolbar
        if (gemini_appnav.pageCard.Id == 0 /*|| gemini_appnav.pageCard.CardType == gemini_commons.PAGE_TYPE.Custom*/ || gemini_appnav.pageCard.CardType == gemini_commons.PAGE_TYPE.Marketing) {
            $("#pin-page").css('color', "");
            $('#appnav-toolbar').hide();
            return;
        }

        // Set the toolbar data
        $('.code', '#appnav-toolbar').html(gemini_appnav.pageCard.Key);
        $('.title', '#appnav-toolbar').html(gemini_appnav.pageCard.Title);
        $('.title', '#appnav-toolbar').attr('title', gemini_appnav.pageCard.Title);
        $('#appnav-toolbar').css('background-color', gemini_appnav.pageCard.Color).css('display', 'inline-block');
        $('.save-small', '#appnav-toolbar').css('background-color', gemini_appnav.pageCard.Color);


        // Handle actions
        $("#workspace-panel #workspace-save").unbind('click').bind('click', function (e) {
            if (gemini_appnav.pageCard != null) {
                gemini_appnav.update(gemini_appnav.pageCard);
            }
        });

        $("#workspace-panel #workspace-copy").unbind('click').bind('click', function (e) {
            if (gemini_appnav.pageCard != null) {
                gemini_appnav.duplicate(gemini_appnav.pageCard);
            }
        });

        $("#workspace-panel #workspace-delete").unbind("click").bind("click", function (e) {
            gemini_appnav.removeCard(gemini_appnav.pageCard.Id);
        });

        $("#workspace-panel #workspace-configure").unbind("click").bind("click", function (e) {
            gemini_appnav.showAppNavBox();
        });

        $("#workspace-panel #workspace-create").click(function () {
            gemini_appnav.newWorkspace();
        });

        $('#appnav-toolbar-badge-changes').unbind("click").bind("click", function (e) {
            gemini_appnav.clearCount();
        });

        $('#workspace-badge-count .badge').unbind("click").bind("click", function (e) {
            gemini_appnav.clearCount();
        });

        $('#appnav-toolbar-badge-chat, #appnav-toolbar-badge-chat2').unbind("click").bind("click", function (e) {
            gemini_commons.stopClick(e);
            gemini_ajax.postCall('action', 'clearchatcount', function (response) {
                if (response.success) {
                    gemini_appnav.pageCard.CardData.Chat.BadgeCount = 0;
                    $('#appnav-toolbar-badge-chat').hide();
                    $('#appnav-toolbar-badge-chat2').hide();
                    $('.not-seen', '#workspace-chat-zone').each(function () {
                        $(this).removeClass('not-seen');
                    });

                    gemini_appnav.refresh();
                }
            }, null, { cardId: gemini_appnav.pageCard.Id });
        });

    },

    /* Edit screen */
    showAppNavBox: function (defaultTab) {
        gemini_ui.startBusyDiv("#workspace-configure");
        $("#cs-popup-center-content").css("width", "800px");
        $("#cs-popup-center-content").css("height", "380px");

        gemini_commons.translateMessage("[[Save]],[[Cancel]]", ['Save', 'Cancel'], function (message) {
            var translations = message.split(",");
            add = translations[0];
            cancel = translations[1];

            gemini_popup.centerPopup("action", 'edit', null, null, add, cancel, null, null,
                function () {
                    gemini_ui.stopBusyDiv("#workspace-configure");

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

    makeDefault: function (cardId) {
        gemini_ajax.postCall('action', 'default', function (response) {
            if (response.success) {
                gemini_commons.translateMessage("[[Updated]]", ['Updated'], function (message) {
                    gemini_popup.toast(message);
                    var li = $("li#card-" + cardId);
                    var system = $("li.card.system");
                    system.remove();
                    li.remove();
                    $("ul.cards").prepend(li).prepend(system);

                });
            }
        },
            null, {cardId : cardId});
    },

    clearCount: function () {
        gemini_ajax.postCall('action', 'clearcount', function (response) {
            if (response.success) {
                gemini_appnav.pageCard.BadgeCount = 0;
                $('#appnav-toolbar-badge-changes').css("visibility", "hidden");
                gemini_appnav.refresh();
                $('tr.issue-highlight', '#data').removeClass('issue-highlight');
                planner.removeHighlight(gemini_appnav.pageCard.CardData.Badges);

            }
        }, null, { cardId: gemini_appnav.pageCard.Id });
    },

    /* Edit screen handler */
    popup: function (cardColor) {
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
        }

        gemini_ui.chosen("#edit-appnav-card #Taxonomy", null, true);

        gemini_ui.chosen("#edit-appnav-card #InteractionGroupList", null, true);
        if ($("#edit-appnav-card #InteractionUserList").hasClass('no-chosen')) {
            gemini_ui.ajaxChosen('#edit-appnav-card #InteractionUserList', null, true, 'workspace/' + gemini_appnav.pageCard.Id + '/action/finduser');
        }
        else {
            gemini_ui.chosen("#edit-appnav-card #InteractionUserList", null, true);
        }

        gemini_ui.chosen("#edit-appnav-card #ReportsGroupList", null, true);
        if ($("#edit-appnav-card #ReportsUserList").hasClass('no-chosen')) {
            gemini_ui.ajaxChosen('#edit-appnav-card #ReportsUserList', null, true, 'workspace/' + gemini_appnav.pageCard.Id + '/action/finduser');
        }
        else {
            gemini_ui.chosen("#edit-appnav-card #ReportsUserList", null, true);
        }
        gemini_ui.chosen("#edit-appnav-card #ReportsExcelList", null, true);

        gemini_ui.chosen("#edit-appnav-card #EmailToListGroups", null, true);
        if ($("#edit-appnav-card #EmailToListUsers").hasClass('no-chosen')) {
            gemini_ui.ajaxChosen('#edit-appnav-card #EmailToListUsers', null, true, 'workspace/' + gemini_appnav.pageCard.Id + '/action/finduser');
        }
        else {
            gemini_ui.chosen("#edit-appnav-card #EmailToListUsers", null, true);
        }

        gemini_ui.chosen("#edit-appnav-card #SubscriptionGroupsList", null, true);
        if ($("#edit-appnav-card #SubscriptionUsersList").hasClass('no-chosen')) {
            gemini_ui.ajaxChosen('#edit-appnav-card #SubscriptionUsersList', null, true, 'workspace/' + gemini_appnav.pageCard.Id + '/action/finduser');
        }
        else {
            gemini_ui.chosen("#edit-appnav-card #SubscriptionUsersList", null, true);
        }

        gemini_appnav.ToggleUpdateButtons(true);



        // Save the AppNav details
        $("#popup-button-yes").click(function (e) {
            if ($("#edit-appnav-card #regular-form").valid()) {
                gemini_ui.startBusy('#colorbox #popup-button-yes');
                var showDashboard = $('div.selected', '#edit-appnav-card').attr('data-tab') == 'appnav-dashboard' && $("#edit-appnav-card #regular-form #dashboard-widgets input:checked").length > 0;
                gemini_ajax.postCall("action", "updatecard", function (response) {
                    if (response.Success) {
                        if (response.Result.Refresh) {
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
                        //gemini_appnav.setAppNavToolbar();
                        if (showDashboard) {
                            gemini_dashboard.fetch();
                        }
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

            if (selectedReports != null) {
                gemini_ui.startBusy2('#edit-appnav-card #send-report', "#progress-indicator");
                gemini_ajax.postCall("action", "sendreport", function (response) {

                    if (response.Success) {
                        gemini_popup.toast("Report sent");
                    }
                    gemini_ui.stopBusy2('#edit-appnav-card #send-report');
                }, function (e) {
                    gemini_ui.stopBusy2('#edit-appnav-card #send-report');
                    gemini_popup.toast("Report not sent", true);
                }, $("#edit-appnav-card #regular-form").serialize());
            }
            else {
                if (selectedReports == null) {
                    $("#edit-appnav-card #ReportsExcelList").addClass('error');
                }

            }
        });

        $('#edit-appnav-card #send-items').click(function () {
            $('#edit-appnav-card .send-items-container').removeClass('hide');
            $("#edit-appnav-card #jump-to-send-email").click();
        });

        $('#edit-appnav-card #clear-items').click(function () {
            if ($("#edit-appnav-card .updates tbody input:checkbox:checked").length > 0) {
                gemini_ui.startBusy2('#edit-appnav-card #clear-items', "#progress-indicator");
                gemini_ajax.postCall("action", "clearitems", function (response) {
                    if (response.Success) {
                        var itemNumber = $("#edit-appnav-card .updates tbody input.item-badge:checkbox:checked").length;

                        var newCount = response.Result.Count;

                        if (gemini_appnav.pageCard.BadgeCount >= itemNumber) gemini_appnav.pageCard.BadgeCount -= itemNumber;

                        $('#edit-appnav-card #appnav-changes-tab').attr('data-update-count', newCount);
                        $('#edit-appnav-card #appnav-changes-tab span').html('(' + newCount + ')');

                        $('#edit-appnav-card #appnav-changes #clear-all-items').prop('value', $('#edit-appnav-card #appnav-changes #clear-all-items').data('label') + ' (' + gemini_appnav.pageCard.BadgeCount + ')');

                        $("#edit-appnav-card .updates tbody input.item-badge:checkbox:checked").each(function (index, key) {
                            $('#tabledata #tr-issue-' + $(key).val()).removeClass('issue-highlight');
                            $(key).parents('tr:eq(0)').remove();
                        });
                        $("#edit-appnav-card .updates tbody").html(response.Result.BadgeList);

                        gemini_ui.fancyInputs('#edit-appnav-card .updates tbody .fancy');

                        gemini_appnav.attachItemsCheckboxEvents();

                        if (newCount == 0) {
                            var closeAppNav = false;
                            if ($('#edit-appnav-card #toggle-checkbox').is(':checked')) {
                                closeAppNav = true;
                            }

                            $('.updates', '#edit-appnav-card #appnav-changes').empty();
                            $('#ws-buttons', '#edit-appnav-card #appnav-changes').empty();

                            if (closeAppNav) {
                                $('#colorbox #cs-popup-center-buttons #popup-button-no').click();
                            }

                        }
                        else {
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

                    $("#edit-appnav-card .updates tbody input.item-badge:checkbox:checked").each(function (index, key) {
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
                gemini_ajax.postCall("action", "emailitems", function (response) {

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
                if (checkboxCount == 0) gemini_popup.toast("Select items", true);

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
                gemini_ajax.postCall("action", "followitems", function (response) {

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
                gemini_appnav.ToggleUpdateButtons();
            }
            else {
                $('#edit-appnav-card .updates .item-checkboxes').iCheck('uncheck');
                gemini_appnav.ToggleUpdateButtons(true);
            }
        });

        gemini_appnav.attachItemsCheckboxEvents();

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
                initial: ($('#email-interval').val() == '' ? "0 9 * * 2" : $('#email-interval').val()),
                onChange: function () {
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
                        gemini_ajax.postCall('action', 'delete', function (response) {
                            if (gemini_appnav.pageCard.Id != 0 && gemini_appnav.pageCard.Id == cardId) {
                                $("#pin-page").toggleClass("pinned");
                                gemini_appnav.pageCard = response.Result.PageCard;
                            }
                            gemini_appnav.refresh();
                            closePopup(thisObject);
                        }, function () {
                            closePopup(thisObject);
                        }
                        );
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

        gemini_ui.fancyInputs('#edit-appnav-card .fancy');
        $('.colorpicker').addClass('z-index-max');
        $("#dashboard-widgets tbody", "#edit-appnav-card").sortable({
            forcePlaceholderSize: true,
            placeholder: "drag-placeholder",
            containment: "#dashboard-widgets",
            delay: '150',
            start: function (event, ui) {
                $(ui.helper).addClass("drag-highlight");
            },
            stop: function (event, ui) {
                $(ui.item).removeClass("drag-highlight");
            }
        });

        $('#share-lock', '#edit-appnav-card').bind('ifChanged', function (e) {
            if (!$(this).prop('checked')) {
                $('#share-chat').prop('checked', false);
                $('#share-chat').attr('disabled', 'disabled');
            }
            else {
                $('#share-chat').prop('checked', true);
                $('#share-chat').removeAttr('disabled');
            }
            $('#share-chat').iCheck('update');
        });
    },

    /* New screen */
    newWorkspace: function () {
        $("#cs-popup-center-content").css("width", "615px");
        $("#cs-popup-center-content").css("height", "400px");

        var add = "Save";

        gemini_commons.translateMessage("[[Add]],[[Cancel]]", ['Add', 'Cancel'], function (message) {
            var translations = message.split(",");
            add = translations[0];
            cancel = translations[1];

            gemini_popup.centerPopup("action", 'new', null, null, add, cancel, null, null,
                function () {
                    gemini_ui.fancyInputs('#edit-appnav-card .fancy');
                    $("#popup-button-no", "#cs-popup-center").click(function (e) {
                        gemini_popup.popupClose(e);
                    });

                    $("#popup-button-yes", "#cs-popup-center").click(function (e) {
                        if ($("#edit-appnav-card #regular-form").valid()) {
                            gemini_appnav.pageCard.Key = $('#Key', '#edit-appnav-card #regular-form').val();
                            gemini_appnav.pageCard.Title = $('#Title', '#edit-appnav-card #regular-form').val();
                            gemini_appnav.pageCard.Color = $('#Color', '#edit-appnav-card #regular-form').val();
                            gemini_appnav.pageCard.CardData.Taxonomy = $('#Taxonomy', '#edit-appnav-card #regular-form').val();
                            gemini_appnav.pageCard.CardData.Menu.Menus = [];
                            if ($('#workspace-menu-grid', '#edit-appnav-card #regular-form').prop('checked')) {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Items });
                            }
                            if ($('#workspace-menu-board', '#edit-appnav-card #regular-form').prop('checked')) {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Planner });
                            }
                            if ($('#workspace-menu-calendar', '#edit-appnav-card #regular-form').prop('checked')) {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Calendar });
                            }
                            if ($('#workspace-menu-timeline', '#edit-appnav-card #regular-form').prop('checked')) {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Timeline });
                            }
                            if ($('#workspace-menu-progress', '#edit-appnav-card #regular-form').prop('checked')) {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Burndown });
                            }

                            $('input.custom-app:checked', '#edit-appnav-card').each(function () {
                                gemini_appnav.pageCard.CardData.Menu.Menus.push({ PageType: gemini_commons.PAGE_TYPE.Custom, AppId: $(this).attr('data-appid'), ControlId: $(this).attr('data-controlid') });
                            });
                            var cardData = JSON.stringify(gemini_appnav.pageCard);
                            gemini_ajax.postCall('action', 'add', function (response) {
                                $("#workspace-slider").html(response.Result.Data);
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
                    if (!Modernizr.input.placeholder) {
                        $("#edit-appnav-card input[type=text]").each(function () {
                            gemini_ui.legacyPlaceholder($(this));
                        });
                    }
                    $.validator.addMethod("ALPHANUM", function (value, element) {
                        return this.optional(element) || /^[a-zA-Z0-9]*$/.test(value);
                    }, "");

                    $(".swatch-color", "#appnav-description").click(function (e) {
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
        }
        else {
            $('#edit-appnav-card #send-items').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-secondary');
            $('#edit-appnav-card #email-badges').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-primary');
            $('#edit-appnav-card #clear-items').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-secondary');
            $('#edit-appnav-card #follow-items').removeAttr('disabled', 'disabled').removeClass('button-secondary-disabled').addClass('button-secondary');
        }
    }
};
