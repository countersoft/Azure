gemini_master = {

    resizedProjectMenu: false,

    initBase: function (displayPageActions, status, projects) 
    {
        $("#pin-page").click(function () {
            gemini_appnav.pinPage();
        });

        gemini_appnav.init();

        gemini_sizing.appResizer();

        gemini_pdf.init();

        gemini_popup.init();

        gemini_add.init();

        $.validator.setDefaults({
            ignore: '.ignore'
        });

        // Project search
        var searchBox = $('#project-search');
        if (searchBox.length > 0) {
            searchBox.autocomplete({
                select: function (event, ui) {
                    window.location.href = ui.item.Url;
                    return false;
                },
                focus: function (event, ui) {
                    return false;
                },
                source: function (request, response) {
                    var matches = $.map(projects, function (code) {
                        if (code.label.toUpperCase().indexOf(request.term.toUpperCase()) != -1) {
                            return code;
                        }
                    });
                    response(matches);
                }
            });

            searchBox.autocomplete("widget").css('position', 'fixed');
        }
        // End Project search

        $("body").on('click', '.dropdown', (function (e) {
            if ($(".cs-menu-dropdown", $(this)).is(':visible') && $(e.target).closest('#project-search').length == 0) {
                //Fixes bug in IE8 where body and this click events are executed before the qq file uploader event which causes problem.                  
                if ((csVars.IEVersion == 8 || csVars.IsSafari) && $(e.target).closest('#attachmentupload-hit').length > 0) {
                    if (!csVars.IsSafari) {
                        var currentObject = $(this);
                        setTimeout(function () { $(".cs-menu-dropdown", currentObject).hide(); }, 500)
                    }
                }
                else {
                    $(".cs-menu-dropdown", $(this)).hide();
                }
            }
            else {
                if ($(this).attr('id') != 'all-projects-menu-box' || ($(this).attr('id') == 'all-projects-menu-box' && $(e.target).closest('#project-search').length == 0))
                {
                    $(".cs-menu-dropdown").hide();
                    $(".cs-menu-dropdown", $(this)).slideDown(100);
                }             

                gemini_keyboard.bindEscape(".cs-menu-dropdown", function () {
                    gemini_keyboard.unbindEscape(".cs-menu-dropdown");
                    $(".cs-menu-dropdown").hide();
                });

                if ($(this).attr("id") == "all-projects-menu-box" && gemini_master.resizedProjectMenu == false) {
                    gemini_sizing.padProjectsMenu();
                    gemini_master.resizedProjectMenu = true;
                }

                if ($(this).attr('id') == 'all-projects-menu-box') {
                    $(".cs-menu-dropdown", $(this)).position({
                        "of": $(this),
                        "my": "left top",
                        "at": "left bottom",
                        "offset": "19 7",
                        "collision": "none"
                    });
                    $("#project-search", $(this)).focus();
                }
                else if ($(this).attr('id') == 'user-menu') {
                    $(".cs-menu-dropdown", $(this)).position({
                        "of": $(this),
                        "my": "right top",
                        "at": "right top",
                        "offset": "0 " + ($(this).height() + 14),
                        "collision": "none"
                    });
                }
                else if ($(this).attr('id') == 'project-menu-dropdown') {
                    var height = $(this).height() + 7;
                    $(".cs-menu-dropdown", $(this)).position({
                        "of": $(this),
                        "my": "left top",
                        "at": "left top",
                        "offset": "-10 " + height,
                        "collision": "none"
                    });
                }
                else if ($(this).attr('id') == 'item-menu-dropdown')
                {
                    $(".cs-menu-dropdown", $(this)).position({
                        "of": $(this),
                        "my": "right top",
                        "at": "right top",
                        "offset": "4 " + ($(this).height() + -2),
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
            }
        }));

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

        gemini_master.initNotificationCenter();
        gemini_master.handleClickAway();
    },
    
    handleClickAway: function ()
    {
        $(".export-to-container").click(function (e) {
            if ($(e.target).is('a')) $(this).fadeOut('fast');
            e.stopPropagation();
        });

        $("#page-options-box .options").click(function (e) { e.stopPropagation(); });
        
        //$(".cs-menu-dropdown").click(function (e) { $('#card-context-menu').hide(); e.stopPropagation(); });

        $("body").click(function (e) {
            
            if ($("#card-data").is(":visible")) $("#card-data").fadeOut("fast");
            if ($(".export-to-container").is(":visible")) $(".export-to-container").fadeOut("fast");
            if ($("#column-picker").is(":visible") && $(e.target).closest('#column-picker').length == 0) $("#column-picker").fadeOut("fast");
            if ($("#subscribe-dialog").is(":visible")) $("#subscribe-dialog").fadeOut("fast");
            if ($("#share-dialog").is(":visible")) $("#share-dialog").fadeOut("fast");

            if ($("#items-grid #comments").is(":visible")) {
                $("#items-grid #comments").fadeOut("fast");
                $("#items-grid #comments").empty();
            }
  
            if ($("#planner-context-popup-new-card").is(":visible") && $(e.target).closest('.add-to-swimlane').length == 0 && $(e.target).closest('#planner-context-popup-new-card').length == 0) $("#planner-context-popup-new-card").fadeOut("fast");

            if ($(".cs-menu-dropdown").is(":visible")
                && $(e.target).closest('#user-menu').length == 0
                && $(e.target).closest('#all-projects-menu-box').length == 0
                && $(e.target).closest('#project-menu-dropdown').length == 0
                && $(e.target).closest('#item-menu-dropdown').length == 0)
            {
                if ((csVars.IEVersion == 8 || csVars.IsSafari) && $(e.target).closest('#attachmentupload-hit').length > 0) {
                    setTimeout(function () { $(".cs-menu-dropdown").fadeOut("fast"); }, 500)
                }
                else {
                    $(".cs-menu-dropdown").fadeOut("fast");
                }
               
            }

            //Need to check for this, because this event happens always after the dropdown is shown
            if (!$(e.target).hasClass('control-icon') && !$(e.target).hasClass('ordering')) {
                if ($("#page-options-box .options").is(":visible")) $("#page-options-box .options").fadeOut("fast");
            }

            //Can't use e.stopPropagation as this would disable the events from autocomplete and not remove the dropdown anymore
            if ($(e.target).parent().attr('id') != 'attribute-options-trigger' && $(e.target).closest('#attribute-options-picker').length == 0 && $(e.target).attr('class') != 'search-choice-close') {
                if ($("#attribute-options-picker").is(":visible")) $("#attribute-options-picker").fadeOut("fast");
            }

             if ($(e.target).attr('class') != 'search-choice-close') {
                $('.auto-popup:visible').each(function () {
                    if ($(e.target).hasClass('auto-popup-keep') || $(e.target).closest('.auto-popup-keep').length > 0 || $(e.target).closest('.auto-popup').length > 0) {
                        return true;
                    }

                    // Check if we have a special hide function
                    var func = $(this).attr('data-hide-func');
                    if (func != null && func != undefined && func.length > 0) {
                        eval(func);
                        return true;
                    }

                    // Check effect;
                    var effect = $(this).attr('data-effect');
                    var hideEffect = {};
                    if (effect != null && effect != undefined && effect.length > 0) {
                        hideEffect = JSON.parse(effect);
                    }
                    $(this).hide(hideEffect);
                });
            }

        });
    },
    
    initNotificationCenter: function ()
    {
        $("#notification-handle").unbind('click').bind('click', function ()
        {
           gemini_master.showHideNotificationCenter();

        });
    },
    showHideNotificationCenter: function ()
    {
        $("#notification-handle").toggleClass("handle-expanded");

        if ($("#notification-zone").is(":visible")) {
            $("#notification-handle .line").hide();
            $("#notification-handle").css("top", "0px");
            $("#notification-handle .line").show();

            $("#notification-zone").slideUp('fast', function () {


            });
        }
        else {
            $("#notification-center #notification-zone").css("left", "");
            $("#notification-center #notification-zone").css("top", "");
            var top = $(document).scrollTop();
            $("#notification-zone").position({
                "my": "middle top-" + top,
                "at": "middle bottom",
                "of": $("#notification-handle"),
                "offset": "0 -10",
                "collision": "none"
            });

            $("#notification-zone").slideDown('fast', function () {
                $("#notification-handle").position({
                    "my": "middle top",
                    "at": "middle bottom",
                    "of": $("#notification-zone"),
                    "offset": "0 0",
                    "collision": "none"
                });
            });
        }
    },
    showNotificationCenter: function () {
        setTimeout(function() {

            // limit to only latest item
            $("#notification-items li").each(function (n) {
                if (n > 0) $(this).addClass("hide");
            });
            
            // show it
            if (!$("#notification-zone").is(":visible")) {
                //$("#notification-handle").click();
                gemini_master.showHideNotificationCenter();


                // auto hide it
                setTimeout(function () {
                    //$("#notification-handle").click();
                    if ($("#notification-zone").is(":visible")) {
                        gemini_master.showHideNotificationCenter();
                    }
                    // bring back other items
                    $("#notification-items li").each(function (n) {
                        if (n > 0) $(this).removeClass("hide");
                    });

                }, 3000);
            }
            else {
                $("#notification-items li").each(function (n) {
                    if (n > 0) $(this).removeClass("hide");
                });
            }

        }, 1500);
    }
};

