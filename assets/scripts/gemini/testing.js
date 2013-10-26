testing = {

    boxTag: '#items-filter',
    scopeTag: '#cs-template',

    initialize: function ()
    {
        gemini_ui.expanders();  // set up all expanders

        testing.rowClicks();
        testing.filterClicks();

        // ensure history section collapses - always
        gemini_ui.expandCollapse('#section-history');

        return false;
    },

    waitCursor: function ()
    {
        $('#testing-box').css({ cursor: 'wait' });
    },

    normalCursor: function ()
    {
        $('#testing-box').css({ cursor: 'default' });
    },

    post: function (method, callback, args)
    {
        testing.waitCursor();

        var controller = csVars.ProjectUrl + 'testing';

        // function where any errors will get sent to
        var badcall = planner.updateError;

        // extend passed in args with some common defaults
        //args = $.extend(args, { height: screenHeight, width: screenWidth });
        gemini_ajax.postCall(controller, method, callback, badcall, args);

        return false;
    },

    postDefault: function (args)
    {
        testing.post('update', testing.filteringUpdate, args);
    },

    updateError: function ()
    {
        testing.normalCursor();
        return false;
    },

    filteringUpdate: function (markup)
    {
        testing.normalCursor();

        var insert = $('#cs-sections', testing.scopeTag);
        insert.html(markup);

        Gemini.Trigger(self.onTestEvent, { item: markup, column: testing.scopeTag });

        return false;
    },

    // Get selected data from generic filters
    saveData: function ()
    {
        var i, count, list;
        var items = 0;
        var filterModel = new Object();

        // find all the filter-attributes .attributes in filter
        filters = $('ul.filter-attribute li.attribute', testing.boxTag);

        // Prep the filter Model
        filterModel.viewType = $(testing.boxTag).data('view');
        filterModel.filterList = [];

        filters.each(function ()
        {
            var filter = new Object();

            filter.title = $(this).attr('id');
            filter.type = $(this).data('type');
            filter.list = [];

            // Now for each list get the input items in the list
            var items = $(this).find("ul.filter-data li input");
            items.each(function ()
            {
                // for each item in list
                item = $(this);

                var type = item.attr('type');

                var id = item.attr('id');

                var value;
                if (type == 'checkbox')
                {
                    // up to my parent then look for my id with :checked attached
                    var checked = $('#' + item.attr('id') + ':checked', $(this).parent()).length;
                    value = (checked != 0);
                }
                else
                {
                    value = item.text();
                }

                filter.list.push({ 'id': id, 'selected': value });
            });

            filterModel.filterList.push(filter);
        });

        testing.postDefault({ changes: JSON.stringify(filterModel) });
        return false;
    },

    resetFilterBoxes: function (current)
    {
        if ( /*$(current).is('input') &&*/$(current).attr('type') == 'checkbox')
        {
            if ($(current).parent().index() == 0 && !$(current).hasClass('options-filter'))
            {
                if ($(current).is(':checked'))
                {
                    $(current).parent().parent().find('input[type="checkbox"]:not(:first)').attr('checked', false);
                }
            }
            else
            {
                var any = $(current).parent().parent().find('input[type="checkbox"]:first');
                if (!$(any).hasClass('options-filter'))
                {
                    $(any).attr('checked', false);
                }
            }
        }
    },

    dismissFilterPopop: function (dataBox, parent)
    {
        var selected = "";
        $(dataBox).find("input:checked").each(function (index)
        {
            selected += $(this).parent().find("label").attr("title");
            selected += ", ";
        });

        if (selected.length > 0)
        {
            selected = selected.substring(0, selected.lastIndexOf(","));
        }
        else
        {
            $(dataBox).find("input[type=text]").each(function (index)
            {

                if ($(this).val().length)
                {
                    selected += $(this).val();
                    selected += ", ";
                }
            });

            if (selected.length > 0)
            {
                selected = selected.substring(0, selected.lastIndexOf(","));
            }
        }

        if (selected.length == 0)
        {
            parent.find(".label").attr("title", "");
            parent.find(".label").html("&nbsp;");
        }
        else
        {
            parent.find(".label").attr("title", selected);
            parent.find(".label").html(selected);
        }

        $(dataBox).fadeOut('fast');
        parent.removeClass("selected");
    },

    executeFilter: function ()
    {
        testing.saveData();
    },

    filterClicks: function ()
    {
        $(".header, .label, .icon", testing.boxTag).disableSelection();

        $('.filter-changer', testing.boxTag).on('change', function ()
        {
            testing.resetFilterBoxes(this);
            testing.executeFilter();
        });

        $(".header, .label, .icon", testing.boxTag).on("click", function (e)
        {
            if ($(this).hasClass(".filter-data")) return;

            var parent = $(this).parent();
            var dataBox = parent.find(".filter-data");

            if ($(dataBox).is(":visible"))
            {
                gemini_filter.dismissFilterPopop(dataBox, parent);
                if ($(this).hasClass('filter-changer-text'))
                {
                    testing.executeFilter();
                }
            }
            else
            {
                $(".filter-data:visible").each(function (index)
                {
                    testing.dismissFilterPopop(this, $(this).parent());
                });

                $(dataBox).jScrollPane({ autoReinitialise: true, autoReinitialiseDelay: 250 });
                $(dataBox).slideDown('fast');

                parent.addClass("selected");
            }

            parent.find(".icon").toggleClass("fonticon-tick");
            parent.find(".icon").toggleClass("fonticon-arrow-down");
        });

        $(".filter-data").each(function (index)
        {
            testing.dismissFilterPopop(this, $(this).parent());
        });
    },

    // allow clicking on any cell in the row, to select a row
    rowClicks: function ()
    {
        $("tbody td", testing.scopeTag).on("click", function (e)
        {
            var row = $(this).parent();

            var findLinks = $(this).find('a');

            // check if mouse was over over a no-click when it was clicked
            // and bubble the event up to next chained listener in the stack.
            if (findLinks.length == 0)
            {
                var link = row.find('td.cs-link a, td.cs-title-link a');
                link.each(function ()
                {
                    var href = $(this).attr('href');

                    // do some thing with this
                    window.location = href;
                    return false;
                });
                return false;
            }
        });
    }
};
