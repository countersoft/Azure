var gemini_master = {

    resizedProjectMenu: false,

    initBase: function (displayPageActions, status) 
    {
        $(document).on('click', '#playlist .card', function () {
            var whereTo = $(this).attr("href");
            window.location.href = whereTo;
        });

        $("#pin-page").click(function () {
            gemini_appnav.pinPage();
        });

        $("#reset-help").click(function () {
            gemini_ajax.postCall("account/tour", "reset", function () {
                gemini_commons.refreshPage();
            });
        });

        gemini_appnav.manager(displayPageActions);

        gemini_sizing.appResizer();

        gemini_pdf.init();

        gemini_share.init();

        gemini_popup.init();

        gemini_add.init();

        $.validator.setDefaults({
            ignore: '.ignore'
        });

        //$("#help-link").colorbox({ href: csVars.Url + "tour", transition: "none", initialWidth: "870px", initialHeight: "538px", width: "870px", height: "538px", close: "close", overlayClose: true, escKey: true, opacity: '0.8' });

        //gemini_signalr.init();

        $(".dropdown").click(function (e) {
            if ($(".cs-menu-dropdown", $(this)).is(':visible')) {
                $(".cs-menu-dropdown", $(this)).hide();
            }
            else {               
                $(".cs-menu-dropdown").hide();
                $(".cs-menu-dropdown", $(this)).slideDown(100);
                gemini_keyboard.bindEscape(".cs-menu-dropdown", function () {
                    gemini_keyboard.unbindEscape(".cs-menu-dropdown");
                    $(".cs-menu-dropdown").hide();
                });

                if ($(this).attr("id") == "all-projects-menu-box" && gemini_master.resizedProjectMenu == false) {
                    gemini_sizing.padProjectsMenu();
                    gemini_master.resizedProjectMenu = true;
                }

                if ($(this).attr('id') == 'user-menu') {
                    $(".cs-menu-dropdown", $(this)).position({
                        "of": $(this),
                        "my": "right top",
                        "at": "right top",
                        "offset": "0 " + ($(this).height() + 4),
                        "collision": "none"
                    });
                }
                else if ($(this).attr('id') == 'project-menu-dropdown') {
                    var height = $(this).height() + 8;
                    $(".cs-menu-dropdown", $(this)).position({
                        "of": $(this),
                        "my": "left top",
                        "at": "left top",
                        "offset": "0 " + height,
                        "collision": "none"
                    });
                }
                else {
                    $(".cs-menu-dropdown", $(this)).position({
                        "of": $(this),
                        "my": "left top",
                        "at": "left top",
                        "offset": "0 " + $(this).height(),
                        "collision": "none"
                    });
                }

                if (csVars.IsOpera) {
                    $(".cs-menu-dropdown", $(this)).css('left', 'auto');
                    $(".cs-menu-dropdown", $(this)).css('top', 'auto');
                }
            }
        });

        window.onbeforeunload = null;

        gemini_ui.chosen('select:not(.no-chosen)', null);

        // Fix for browsers (i.e IE9) which don't support placeholder attribute
        if (!Modernizr.input.placeholder) {
            $("input[type=text]").each(function () {
                if ($(this).val() == "" && $(this).attr("placeholder") != "") {

                    $(this).addClass("search_box_placeholder");

                    $(this).val($(this).attr("placeholder"));
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

        var footerOk = $("#footer-messaging").is(":visible");
        var footerText = $('*:contains("Countersoft Gemini")', "#footer-messaging");
        var freeCardOk = status == 254 || $("#card--1").is(":visible") || window.location.href.indexOf('/account') >= 0;
        if (!footerOk || !footerText.length || !freeCardOk)
        {
            $("body").css("background-color", "red");
        }

        gemini_master.handleClickAway();
    },
    
    tour: function (licensed, tourStatus, area)
    {
        // Home page
        if (area == "home") {
            if (!_.contains(tourStatus, "home")) {
                $("#tour-joyride-home").joyride({
                    postRideCallback: function () {
                        gemini_ajax.postCall("account/tour/update", "home");
                    }
                });
            }
        }

        // Planner page
        else if (area == "planner") {
            if (!_.contains(tourStatus, "planner")) {
                $("#tour-joyride-planner").joyride({
                    postRideCallback: function () {
                        gemini_ajax.postCall("account/tour/update", "planner");
                    }
                });
            }
        }

        // Timeline page
        else if (area == "timeline") {
            if (!_.contains(tourStatus, "timeline")) {
                $("#tour-joyride-timeline").joyride({
                    postRideCallback: function () {
                        gemini_ajax.postCall("account/tour/update", "timeline");
                    }
                });
            }
        }

        // Roadmap page
        else if (area == "roadmap") {
            if (!_.contains(tourStatus, "roadmap")) {
                $("#tour-joyride-roadmap").joyride({
                    postRideCallback: function () {
                        gemini_ajax.postCall("account/tour/update", "roadmap");
                    }
                });
            }
        }

        // Items page
        else if (area == "items") {
            if (!_.contains(tourStatus, "items-1")) {
                $("#tour-joyride-items-1").joyride({
                    postRideCallback: function () {
                        gemini_ajax.postCall("account/tour/update", "items-1");
                    }
                });
            }

            if (_.contains(tourStatus, "items-1") && !_.contains(tourStatus, "items-2")) {
                $("#tour-joyride-items-2").joyride({
                    postRideCallback: function () {
                        gemini_ajax.postCall("account/tour/update", "items-2");
                    }
                });
            }
        }
    },
    
    handleClickAway: function ()
    {
        $("#card-data").click(function (e) {    
            $(".cs-menu-dropdown").hide();
            $('#card-context-menu').hide();
            if ($(e.target).attr('id') != 'card-data-clear') e.stopPropagation();
        });
        $(".export-to-container").click(function (e) {
            if ($(e.target).is('a')) $(this).fadeOut('fast');
            e.stopPropagation();
        });

        $("#page-options-box .options").click(function (e) { e.stopPropagation(); });
        $("#subscribe-dialog").click(function (e) {
            $(".cs-menu-dropdown").hide();
            $('#card-context-menu').hide();
            e.stopPropagation();
        });
        $("#share-dialog").click(function (e) {
            $(".cs-menu-dropdown").hide();
            $('#card-context-menu').hide();
            e.stopPropagation();
        });
        $(".cs-menu-dropdown").click(function (e) { $('#card-context-menu').hide(); e.stopPropagation(); });

        $("body").click(function (e) {
            if ($("#card-data").is(":visible")) $("#card-data").fadeOut("fast");
            if ($(".export-to-container").is(":visible")) $(".export-to-container").fadeOut("fast");
            if ($("#column-picker").is(":visible") && $(e.target).closest('#column-picker').length == 0) $("#column-picker").fadeOut("fast");
            if ($("#subscribe-dialog").is(":visible")) $("#subscribe-dialog").fadeOut("fast");
            if ($("#share-dialog").is(":visible")) $("#share-dialog").fadeOut("fast");

            if ($("#items-grid #comments").is(":visible")) $("#items-grid #comments").fadeOut("fast");
  
            if ($("#planner-context-popup-new-card").is(":visible") && $(e.target).closest('.add-to-swimlane').length == 0 && $(e.target).closest('#planner-context-popup-new-card').length == 0) $("#planner-context-popup-new-card").fadeOut("fast");

            if ($(".cs-menu-dropdown").is(":visible")
                && $(e.target).closest('#user-menu').length == 0
                && $(e.target).closest('#all-projects-menu-box').length == 0
                && $(e.target).closest('#project-menu-dropdown').length == 0) {
                $(".cs-menu-dropdown").fadeOut("fast");
            }


            //Need to check for this, because this event happens always after the dropdown is shown
            if (!$(e.target).hasClass('control-icon') && !$(e.target).hasClass('ordering')) {
                if ($("#page-options-box .options").is(":visible")) $("#page-options-box .options").fadeOut("fast");
            }

            //Can't use e.stopPropagation as this would disable the events from autocomplete and not remove the dropdown anymore
            if ($(e.target).parent().attr('id') != 'attribute-options-trigger' && $(e.target).closest('#attribute-options-picker').length == 0 && $(e.target).attr('class') != 'search-choice-close') {
                if ($("#attribute-options-picker").is(":visible")) $("#attribute-options-picker").fadeOut("fast");
            }
        });
    }
};

