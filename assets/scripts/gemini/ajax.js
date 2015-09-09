gemini_ajax =
{
    getUrl: function (controller, method, ignoreContainer) {
        var url = '';
        var slash = '/';
        if (ignoreContainer) {
            url = csVars.Url;
            slash = '';
        }
        else //if (gemini_appnav.pageCard.Id != 0) 
        {
            url = csVars.Url + 'workspace/' + gemini_appnav.pageCard.Id 
        }
        /*else {
            url = csVars.Url + 'project/' + csVars.ProjectId 
        }*/

        if (controller != null && controller.length) {
            url = url + slash + controller
            if (!gemini_commons.endsWith(url, '/'))
            {
                slash = '/';
            }
            else
            {
                slash = '';
            }
        }
        if (method != null && method.length) url = url + slash + method;
        
        return url;
    },

    call: function (controller, method, callback, badCall, params, extra, ignoreContainer, isAsync) {
        /*if (gemini_ajaxXHR != undefined && gemini_ajaxXHR != null) {
            ajaxXHR.abort();
        }*/

        if (typeof isAsync == "undefined" || isAsync == null)
        {
            isAsync = true;
        }
        else
        {
            isAsync = isAsync
        }
        
        var url = gemini_ajax.getUrl(controller, method, ignoreContainer);
        gemini_session.isResetSession(controller, method);

        return $.ajax({
                type: "GET",
                url: url,
                data: params,
                async: isAsync,
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
                        badCall.call(this, xhr, ajaxOptions, thrownError);
                    }
                    ajaxXHR = null;
                }
            });
    },

    jsonCall: function (controller, method, callback, badCall, params, extra, ignoreContainer) {
        /*if (gemini_ajaxXHR != undefined && gemini_ajaxXHR != null) {
            ajaxXHR.abort();
        }*/

        var url = gemini_ajax.getUrl(controller, method, ignoreContainer);
        gemini_session.isResetSession(controller, method);

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
                        badCall.call(this, xhr, ajaxOptions, thrownError);
                    }
                    ajaxXHR = null;
                }
            });
    },

    postCall: function (controller, method, callback, badCall, params, extra, ignoreContainer) {
        /*if (gemini_ajaxXHR != undefined && gemini_ajaxXHR != null) {
            ajaxXHR.abort();
        }*/
        
        gemini_session.isResetSession(controller, method);

        var url = gemini_ajax.getUrl(controller, method, ignoreContainer);

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
                        badCall.call(this, xhr, ajaxOptions, thrownError);
                    }
                    ajaxXHR = null;
                }
            });
    }
};
