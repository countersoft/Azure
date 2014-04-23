gemini_session = {
    sessionTimeOut: 0,
    sessionHandler: false,
    init: function (sessionTimeOutMinutes)
    {
        gemini_session.sessionTimeOut = sessionTimeOutMinutes;
        gemini_session.clearSessionTimeOut();       

        if (gemini_session.sessionTimeOut == 0) return;
        
        gemini_session.setCookie("expireSessionIn");
        gemini_session.setSessionTimeOut();  
    },
    setSessionTimeOut: function()
    {
        if (gemini_session.sessionTimeOut == 0) return;

        gemini_session.sessionHandler = setInterval(function () {
            var timeout = gemini_session.getCookie("expireSessionIn");           
            var d = new Date();

            if (d.getTime() >= timeout) {
                window.location.href = csVars.Url + "account/logout";
            }
            else {
                gemini_session.setSessionTimeOut();
            }

        }, (gemini_session.sessionTimeOut * 60) * 1000);
    },
    resetSession: function () {
        gemini_session.clearSessionTimeOut();
        gemini_session.setCookie("expireSessionIn");
        gemini_session.setSessionTimeOut();
    },
    isResetSession: function (controller, method) {   
        if (gemini_session.sessionTimeOut > 0 && method != "fetch" || method == "fetch" && controller.indexOf('workspace') == -1) gemini_session.resetSession();
    },
    clearSessionTimeOut: function ()
    {
        if (gemini_session.sessionHandler) window.clearInterval(gemini_session.sessionHandler);
    },
    setCookie: function (c_name, exdays)
    {
        var d = new Date();
        value = d.getTime() + (gemini_session.sessionTimeOut * 60) * 1000;

        if (!exdays) exdays = 1;

        var exdate=new Date();
        exdate.setDate(exdate.getDate() + exdays);
        var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString()) + "; path=/";
        document.cookie = c_name + "=" + c_value;
    },
    getCookie: function (c_name)
    {
        var c_value = document.cookie;
        var c_start = c_value.indexOf(" " + c_name + "=");
        if (c_start == -1)
        {
            c_start = c_value.indexOf(c_name + "=");
        }
        if (c_start == -1)
        {
            c_value = null;
        }
        else
        {
            c_start = c_value.indexOf("=", c_start) + 1;
            var c_end = c_value.indexOf(";", c_start);
            if (c_end == -1)
            {
                c_end = c_value.length;
            }
            c_value = unescape(c_value.substring(c_start,c_end));
        }
        return c_value;
    }
};