gemini_master =
{
    resizedProjectMenu: false,
    currentRefreshFunction: null,
    
    initBase: function (displayPageActions, status, projects, newWorkspace, admin) 
    {
        gemini_appnav.init(newWorkspace);

        gemini_sizing.appResizer();

        gemini_pdf.init();

        gemini_popup.init();

        gemini_add.init(admin);

        gemini_account.bindProfile();

        gemini_master.initSearch();

        gemini_import.init();

        gemini_notifications.init();

        gemini_master.initReports();
        if (admin)
        {
            gemini_logo.init();
        }

        gemini_master.initWorkspaceActions();

        $.validator.setDefaults({
            ignore: '.ignore'
        });

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
                        "offset": "0 0",
                        "collision": "none"
                    });
                   // $("#project-search", $(this)).focus();
                }
                else if ($(this).attr('id') == 'user-menu') {
                    $(".cs-menu-dropdown", $(this)).position({
                        "of": $(this),
                        "my": "right top",
                        "at": "right top",
                        "offset": "15 " + ($(this).height() + 10),
                        "collision": "none"
                    });
                }
                else if ($(this).attr('id') == 'add-menu')
                {
                    $(".cs-menu-dropdown", $(this)).position({
                        "of": $(this),
                        "my": "right top",
                        "at": "right top",
                        "offset": "5 " + ($(this).height() +3),
                        "collision": "none"
                    });
                }
                else if ($(this).attr('id') == 'project-menu-dropdown') {
                    var height = $(this).height() + 8;
                    $(".cs-menu-dropdown", $(this)).position({
                        "my": "right top",
                        "at": "right top",
                        "of": $(this),
                        "offset": "4 " + height,
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

        if (!footerOk || !footerText.length)
        {
            $("body").css("background-color", "red");
        }

        gemini_master.handleClickAway();
        gemini_master.initProjectSettings();
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
                && $(e.target).closest('#add-menu').length == 0
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
            if ($('#workspace-slider').is(":visible") && 
                $(e.target).closest('#workspace-slider').length == 0) {
                $('#workspace-slider').removeClass("show");
                gemini_appnav.toggleDropdownIcon();
            }

            if ($(e.target).attr('id') != 'filter-options-content') {

                if ($("#filter-form #instant-filter-options").hasClass("show")) {
                    $("#filter-form #instant-filter-options").removeClass("show");
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

    initTabs: function () {
        /*//Fixes hidden menu item bug if browser scrollbar is visible
        if ($('#tabs-wrapper').width() + 30 > $('#header').width() / 2) {
            $($('#tabs-wrapper')).css('width', $('#tabs-wrapper').width() - 30);
        }

        if (!$('#all-projects-menu-box').length) return;
        var left = $('#all-projects-menu-box').position().left + $('#all-projects-menu-box').width();

        $('.tab', '#tabs-wrapper').each(function () {
            var pos = $(this).position();
            if (pos.top > 10) {
                $('.cs-menu-dropdown li[data-id="' + $(this).attr('data-id') + '"]', '#project-menu-dropdown').show();
            }
            else {
                $('.cs-menu-dropdown li[data-id="' + $(this).attr('data-id') + '"]', '#project-menu-dropdown').hide();
                if (left < pos.left) {
                    left = pos.left + $(this).width();
                }
            }
        });

        if ($('#project-menu-dropdown').length) {
            var showDropdown = false;
            $('.cs-menu-dropdown li:not(.arrow)', '#project-menu-dropdown').each(function ()
            {
                if ($(this).css('display') !='none')
                {
                    showDropdown = true;
                    return false;
                }
            });

            if (!showDropdown)
            {
                $('#project-menu-dropdown').addClass('menu-hide');
            }
            else
            {
                $('#project-menu-dropdown').removeClass('menu-hide');
                $('#project-menu-dropdown').show();
            }

            left += 36;
            if ($('#project-menu-dropdown').position().top > 10) {

                $('#project-menu-dropdown').css({
                    'position': 'absolute',
                    'top': '0px',
                    'left': left + 'px'
                });
            }
            else if ($('#project-menu-dropdown').css('position') == 'absolute') {
                $('#project-menu-dropdown').css('left', left + 'px');
            }
        }
        if ($('#add-menu .cs-menu-dropdown li').length <= 1)
        {
            $('#add-zone .add-dropdown').hide();
        }*/
    },

    initProjectSettings: function ()
    {
        if (!$('#project-settings', '#main-menu').length) return;

        $('#project-settings', '#main-menu').click(function (e)
        {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "1000px");
            $("#cs-popup-center-content").css("height", "700px");
            gemini_popup.centerPopup("project", "settings", null, null, null, 'Close', true);
        });
    },

    initSearch: function()
    {
        $("#search-bar", '#header').hoverIntent({
            interval: 250,
            over: function () {
                if (!$('#search-box', '#header').is(':visible'))
                {
                    $('.auto-popup').hide();
                    $('#search-box', '#header').show();
                    $('input', '#search-box', '#header').focus();
                }
            },
            out: function () {
                var x = 1;
            }
        });
        $("#search-bar", '#header').click(function (e) 
        {
            if (!$('#search-box', '#header').is(':visible')) {
                //$('.auto-popup').hide();
                $('#search-box', '#header').show();
                $('input', '#search-box', '#header').focus();
            }
            else {
                $('#search-box', '#header').hide();
            }
        });
    },

    initReports: function() {
        $("#main-menu .reports").hoverIntent({
            interval: 150,
            over: function () {
                gemini_reports.init();
            }, out: function () {
                var x = 1;
            }
        });
    },

    initWorkspaceActions: function() {

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

        $("#workspace-panel #workspace-set-default").unbind("click").bind("click", function (e) {
            gemini_appnav.makeDefault(gemini_appnav.pageCard.Id);
        });

        $("#workspace-panel #workspace-create").click(function () {
            gemini_appnav.newWorkspace();
        });

        $('#workspace-badge-count .badge').unbind("click").bind("click", function (e) {
            gemini_appnav.clearCount();
        });
    }
};
