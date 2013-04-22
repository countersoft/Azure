gemini_keyboard =
{
    q_escape: [],
    q_yes: [],
    q_no: [],

    // auto unbind?
    initKeyboard: function ()
    {
        Mousetrap.bind('esc', function (e, ob) { gemini_keyboard.invoker(ob) });
        Mousetrap.bind(['y','Y'], function (e, ob) { gemini_keyboard.invoker(ob) });
        Mousetrap.bind(['n','N'], function (e, ob) { gemini_keyboard.invoker(ob) });
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
    }
};