
(function ($, doc, win) {
    "use strict";

    var _options;
    var methods = {
        init: function (options) {
            var defaults = {
                classes: {
                    tabContainer: "tab",
                    tabItem: "tab-item",
                    tabActive: "tab-active",
                    tabUnactive: "tab-unactive"
                },
                tabContentSelectorAttribute: "data-tab-id",
                debug: false,
                events: {
                    onTabChange: function () { }
                }
            };
            _options = $.extend(defaults, options);

            $.csTabs.generate(this);

        },
        destroy: function () {

        },
        reset: function () {

        }
    };

    $.fn.csTabs = function (method) {

        // Method calling logic
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.tooltip');
        }
        return this;
    };

    $.csTabs = {
        generate: function (root) {
            var container = $("." + _options.classes.tabContainer);
            container.children("span")
                .disableSelection()
                .removeClass(_options.classes.tabActive)
                .addClass(_options.classes.tabUnactive)
                .bind('click', $.csTabs._tabClick)
                .first("span")
                    .addClass(_options.classes.tabActive)
                    .removeClass(_options.classes.tabUnactive);

            container.children("span").each(function () {
                var selector = $(this).attr(_options.tabContentSelectorAttribute);
                $(selector).hide();
            });

            var selector = container.children("span." + _options.classes.tabActive).attr(_options.tabContentSelectorAttribute);
            $(selector).show();
        },
        _tabClick: function (e) {
            var container = $("." + _options.classes.tabContainer);

            //hide panel
            var selector = container.children("span." + _options.classes.tabActive).attr(_options.tabContentSelectorAttribute);
            $(selector).hide();

            //change buttons
            container.children("span." + _options.classes.tabActive)
                .removeClass(_options.classes.tabActive)
                .addClass(_options.classes.tabUnactive);

            $(this).addClass(_options.classes.tabActive).removeClass(_options.classes.tabUnactive);

            //show new panel
            selector = $(this).attr(_options.tabContentSelectorAttribute);
            $(selector).show();
        }
    };

    //pass jQuery to the function, 
    //So that we will able to use any valid Javascript variable name 
    //to replace "$" SIGN. But, we'll stick to $ (I like dollar sign: ) )       
})(jQuery);