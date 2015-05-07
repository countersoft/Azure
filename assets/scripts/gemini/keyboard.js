gemini_keyboard =
{
    q_escape: [],
    q_yes: [],
    q_no: [],

    // auto unbind?
    initKeyboard: function ()
    {
        Mousetrap.bind('esc', function (e, ob) { gemini_keyboard.invoker(ob); });
        Mousetrap.bind(['y', 'Y'], function (e, ob) { gemini_keyboard.invoker(ob); });
        Mousetrap.bind(['n', 'N'], function (e, ob) { gemini_keyboard.invoker(ob); });
    },

    bindEscape: function (select, callback)
    {
        var id = gemini_keyboard.getSelectorId(select, gemini_keyboard.q_escape);

        if (id == false) {
            id = gemini_commons.guidGenerator();

            if (typeof callback == "undefined") callback = gemini_keyboard.EscFunction;  //If no callback function was provided use default one

            gemini_keyboard.q_escape.push({ guid: id, func: callback, selector: select });
        }

        return id;
    },
    unbindEscape: function (selector, isGuid)
    {
        if (isGuid)
            gemini_keyboard.q_escape = _.reject(gemini_keyboard.q_escape, function (obj) { return obj.guid == selector; });
        else
            gemini_keyboard.q_escape = _.reject(gemini_keyboard.q_escape, function (obj) { return obj.selector == selector; });
    },

    bindYes: function (select, callback) {
        var id = gemini_keyboard.getSelectorId(select, gemini_keyboard.q_yes);

        if (id == false) {
            id = gemini_commons.guidGenerator();

            if (typeof callback == "undefined") callback = gemini_keyboard.YesFunction;  //If no callback function was provided use default one

            gemini_keyboard.q_yes.push({ guid: id, func: callback, selector: select });            
        }

        return id;
    },
    unbindYes: function (selector, isGuid)
    {
        if (isGuid)
            gemini_keyboard.q_yes = _.reject(gemini_keyboard.q_yes, function (obj) { return obj.guid == selector; });
        else
            gemini_keyboard.q_yes = _.reject(gemini_keyboard.q_yes, function (obj) { return obj.selector == selector; });
    },

    bindNo: function (select, callback) {
        var id = gemini_keyboard.getSelectorId(select, gemini_keyboard.q_no);

        if (id == false) {
            id = gemini_commons.guidGenerator();

            if (typeof callback == "undefined") callback = gemini_keyboard.NoFunction; //If no callback function was provided use default one

            gemini_keyboard.q_no.push({ guid: id, func: callback, selector: select });
        }

        return id;
    },
    unbindNo: function (selector, isGuid) {
        if (isGuid)
            gemini_keyboard.q_no = _.reject(gemini_keyboard.q_no, function (obj) { return obj.guid == selector; });
        else
            gemini_keyboard.q_no = _.reject(gemini_keyboard.q_no, function (obj) { return obj.selector == selector; });
    },

    invoker: function (key, callback)
    {
        var obj = { guid: "", func: null };

        if (key.toLowerCase() == 'esc' && gemini_keyboard.q_escape.length > 0)
        {
            obj = gemini_keyboard.q_escape[gemini_keyboard.q_escape.length - 1];
        }
        else if (key.toLowerCase() == 'y' && gemini_keyboard.q_yes.length > 0) {
            obj = gemini_keyboard.q_yes[gemini_keyboard.q_yes.length - 1];
        }
        else if (key.toLowerCase() == 'n' && gemini_keyboard.q_no.length > 0) {
            obj = gemini_keyboard.q_no[gemini_keyboard.q_no.length - 1];
        }

        if (obj.func != null) obj.func(obj.guid, obj.selector);
    },
    getSelectorId: function (selector, object)
    {
        var result = false;

        _.each(object, function (obj) {
            if (obj.selector == selector) result = obj.guid;
        });

        return result;
    },
    //Diagnostic method
    diag: function ()
    {
        console.log('--------------------');
        _.each(gemini_keyboard.q_escape, function (obj) { console.log("Q escape: " + obj.guid, obj.selector); });
        _.each(gemini_keyboard.q_yes, function (obj) { console.log("Q yes: " + obj.guid, obj.selector); });
        _.each(gemini_keyboard.q_no, function (obj) { console.log("Q no: " + obj.guid, obj.selector); });
        console.log('--------------------');
    },
    EscFunction: function (id, selector) {
        if ($(selector).is(':visible')) {
            $(selector).click();       
            gemini_keyboard.unbindEscape(id, true);
        }
    },
    NoFunction: function (id, selector) {
        if ($(selector).is(':visible')) {
            $(selector).click();
            gemini_keyboard.unbindNo(id, true);
        }
    },
    YesFunction: function (id, selector) {
        if ($(selector).is(':visible')) {
            $(selector).click();
            //Only unbind it if the actual window was closed successfully (if validation is on and it would fail validation, don't unbind it as the window is still open)
            if (! $(selector).is(':visible')) gemini_keyboard.unbindYes(id, true);
        }
    },
    navigateTabs: function (e) {
        var selector;

        // Don't switch tabs if we are in an input.
        if((e.srcElement && ($(e.srcElement).is('input') || $(e.srcElement).is('textarea'))) || (e.target && ($(e.target).is('input') || $(e.target).is('textarea')))) return;
        if (e.keyCode == 37) {
            // left
            selector = $('.tab.selected', '#view-item-content-pane').prev().prev();
            if (!selector || selector.length == 0) selector = $('.tab:last', '#view-item-content-pane');
        }
        else if (e.keyCode == 39) {
            // right
            selector = $('.tab.selected', '#view-item-content-pane').next().next();
            if (!selector || selector.length == 0) selector = $('.tab:first', '#view-item-content-pane');
        }

        if (selector && selector.length) selector.click();
    },

    navigateItems: function (e)
    {
        var selector;

        if (e.keyCode == 188) {
            // left
            selector = $('.previous', '#filter-navigator');
        }
        else if (e.keyCode == 190) {
            // right
            selector = $('.next', '#filter-navigator');
        }
        if (selector && selector.length) window.location.href = selector.attr('href');
    },

    navigateGrid: function (e)
    {
        var selector;

        if (e.keyCode == 188)
        {
            // left
            selector = $('.view-issue-highlight', '#tabledata').prev();

            if (selector.hasClass("drop-zone")) selector = selector.prev();
        }
        else if (e.keyCode == 190)
        {
            // right
            selector = $('.view-issue-highlight', '#tabledata').next();

            if (selector.hasClass("drop-zone")) selector = selector.next();
        }

        if (selector && selector.length) $("td.read-only a:first", selector).click();
    }
};