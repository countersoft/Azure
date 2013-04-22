//var gemini_ajaxXHR;    // used as a Ajax Semaphore

var gemini_ajax = {

    // make calls to a MVC Application via AJAX/JSON        - add parameter for dataType ????
    getUrl: function (controller, method) {
        var url = csVars.Url + controller + "/" + method;
        if (url.indexOf('?') == -1) {
            url += '?card=' + gemini_appnav.pageCard.Id;
        }
        else {
            url += '&card=' + gemini_appnav.pageCard.Id;
        }
        return url;
    },
    call: function (controller, method, callback, badCall, params, extra) {
        /*if (gemini_ajaxXHR != undefined && gemini_ajaxXHR != null) {
            ajaxXHR.abort();
        }*/

        var url = gemini_ajax.getUrl(controller, method);

        return $.ajax({
                type: "GET",
                url: url,
                data: params,
                //dataType: "json",
                success: function (data) {
                    if (callback != null && callback != undefined && typeof callback == 'function') {
                        if (extra != null && extra != undefined) {
                            callback.call(this, data, extra);
                        }
                        else {
                            callback.call(this, data);
                        }
                    }
                    ajaxXHR = null;
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                    if (badCall != null && badCall != undefined && typeof badCall == 'function') {
                        badCall.call(this);
                    }
                    ajaxXHR = null;
                }
            });
    },
    jsonCall: function (controller, method, callback, badCall, params, extra) {
        /*if (gemini_ajaxXHR != undefined && gemini_ajaxXHR != null) {
            ajaxXHR.abort();
        }*/

        var url = csVars.Url + controller + "/" + method;
        if (url.indexOf('?') == -1) {
            url += '?card=' + gemini_appnav.pageCard.Id;
        }
        else {
            url += '&card=' + gemini_appnav.pageCard.Id;
        }

        gemini_ui.cursorWait();

        return $.ajax({
                type: "GET",
                url: url,
                data: params,
                dataType: "json",
                success: function (data) {
                    gemini_ui.cursorDefault();
                    
                    if (callback != null && callback != undefined && typeof callback == 'function') {
                        if (extra != null && extra != undefined) {
                            callback.call(this, data, extra);
                        }
                        else {
                            callback.call(this, data);
                        }
                    }
                    ajaxXHR = null;
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    gemini_ui.cursorDefault();
                    gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                    if (badCall != null && badCall != undefined && typeof badCall == 'function') {
                        badCall.call(this);
                    }
                    ajaxXHR = null;
                }
            });
    },

    postCall: function (controller, method, callback, badCall, params, extra) {
        /*if (gemini_ajaxXHR != undefined && gemini_ajaxXHR != null) {
            ajaxXHR.abort();
        }*/

        var url = csVars.Url + controller + "/" + method;
        if (url.indexOf('?') == -1) {
            url += '?card=' + gemini_appnav.pageCard.Id;
        }
        else {
            url += '&card=' + gemini_appnav.pageCard.Id;
        }

        return $.ajax({
                type: "POST",
                url: url,
                data: params,
                //dataType: "json",
                success: function (data) {
                    if (callback != null && callback != undefined && typeof callback == 'function') {
                        if (extra != null && extra != undefined) {
                            callback.call(this, data, extra);
                        }
                        else {
                            callback.call(this, data);
                        }
                    }
                    ajaxXHR = null;
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                    if (badCall != null && badCall != undefined && typeof badCall == 'function') {
                        badCall.call(this);
                    }
                    ajaxXHR = null;
                }
            });
    }
};


