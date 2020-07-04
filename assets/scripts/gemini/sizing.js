gemini_sizing = {
    padProjectsMenu: function () {
        var maxWidth = -1, elems = $('.cs-menu-dropdown .menu-project-code');
        elems.each(function () { if ($(this).width() > maxWidth) maxWidth = $(this).width(); });
        elems.each(function () { $(this).width(maxWidth + 10); });
    },
    
    sameHeight: function (selector) {
        var max = Math.max.apply(Math, $(selector).map(function () { return $(this).height(); }).get());

        if (max == 0) return;

        $(selector).each(function (index) {
            $(this).height(max);
        });
    },

    sameWidth: function (selector, filler) {

        var max = 0;

        max = Math.max.apply(Math, $(selector).map(function () { return $(this).width(); }).get());

        if (max == 0) return;

        if (filler != null && filler > 0) max = max + filler;

        $(selector).each(function (index) {
            $(this).width(max);
        });
    },
    
    appResizer: function () {
        if (csVars.IEVersion == 8) return;
        
        $(window).resize(function () {
            waitForFinalEvent(function () { gemini_sizing.stretchWindow(); }, 500, "stretch-window");
            waitForFinalEvent(function () { gemini_item.resizeWindow(); }, 500, "item-resize");
            waitForFinalEvent(function () { gemini_master.initTabs(); }, 200, "menu-tabs");
        });
    },

    stretchWindow: function () {
        var header = $("header").height();
        var footer = $("footer").height();

        $('#contents').css('min-height', '0');
        //$('#contents').css('min-height', $(window).height() - footer - header - 35);
        $('#contents').css('min-height', $(window).height() - footer - header - 10);
    },
    
    textWidth: function(selector) {
      var html_org = $(selector).html();
      var html_calc = '<span>' + html_org + '</span>';
      $(selector).html(html_calc);
      var width = $(selector).find('span:first').width();
      $(selector).html(html_org);
      return width;
    },
    
    availableHeight: function ()
    {
        // Fix the width and height of the plan area
        var screenHeight = $(window).height();
        var header = $("header").height();
        //var controls = $("#planner-control-box").height();
        //var filter = $("#filter").height();
        var footer = $("footer").height();

        var subtract = header + footer;

        return Math.floor(screenHeight - subtract - 100);   // 80 deals with padding that exists between elements
    },
    
    windowResized: function (callback, namespace) {
        $(window).resize(function () {
            waitForFinalEvent(function () { callback(); }, 500, namespace);
        });
    }
};


