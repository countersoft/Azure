waitForFinalEvent = (function () {
    var timers = {};
    return function (callback, ms, uniqueId) {
        if (!uniqueId) {
            uniqueId = "Don't call this twice without a uniqueId";
        }
        if (timers[uniqueId]) {
            clearTimeout(timers[uniqueId]);
        }
        timers[uniqueId] = setTimeout(callback, ms);
    };
})();

gemini_commons = {
    
    ShiftPressed: false,
    shiftKeyHandler: function ()
    {
        $(document).bind('keyup keydown', function (e) {           
            gemini_commons.ShiftPressed = e.shiftKey
        });
    },
    visibleYes: function (jqueryObject) {
        jqueryObject.removeClass('visible-no').addClass('visible-yes');
    },

    visibleNo: function (jqueryObject) {
        jqueryObject.removeClass('visible-yes').addClass('visible-no');
    },

    isMobile: function () {
        if (navigator.userAgent.match(/Android/i) || navigator.userAgent.match(/webOS/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i) || navigator.userAgent.match(/iPad/i)) {
            return true;
        }
        return false;
    },

    isIe7or8: function ()
    {
        return csVars.IEVersion != -1 && (csVars.IEVersion == 7 || csVars.IEVersion == 8);
    },

    endsWith: function (str, suffix) {
        return str.indexOf(suffix, str.length - suffix.length) !== -1;
    },

    trim: function (s) {
        var l = 0; var r = s.length - 1;
        while (l < s.length && s[l] == ' ')
        { l++; }
        while (r > l && s[r] == ' ')
        { r -= 1; }
        return s.substring(l, r + 1);
    },
        
    stopClick: function (e) {
        e.preventDefault();
        e.stopPropagation();
    },

    isEmpty: function (s) {
        return s === "" || s == null || s == undefined || s.length == 0;
    },

    hasValue: function (s) {
        return !gemini_commons.isEmpty(s);
    },
    
    guidGenerator: function() {
        var S4 = function() {
            return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
        };
        return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
    },
    
    setCookie: function(cName, value, exdays) {
        var exdate = new Date();
        exdate.setDate(exdate.getDate() + exdays);
        var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
        //document.cookie = cName + "=" + c_value;
        document.cookie = cName + " = " + c_value + '; path=/';
    },

    url: function() {
        return $(document).data("root");
    },
    inputKeyHandler : function(element, returnKeyCallback, escapeKeyCallback, otherKeyCallback)
    {
        $(element).bind("keydown.inputKeyHandler", function (e) {
            switch (e.keyCode) {
                case 13: // enter
                    if (returnKeyCallback)
                    {
                        gemini_commons.stopClick(e);
                        returnKeyCallback();
                    }

                    break;
                case 27: // esc
                    if (escapeKeyCallback)
                    {
                        gemini_commons.stopClick(e);
                        escapeKeyCallback();
                    }
                    break;
                default:
                    if(otherKeyCallback) {
                        otherKeyCallback(e);
                    }
            }
        });
    },
    
    inputKeyHandlerUnbind: function (element) {
        $(element).unbind("keydown.inputKeyHandler");
    },
    
    openUrlInTab: function(url)
    {
        window.open(url, '_blank');
    },

    openUrl: function(url)
    {
        window.open(url);
    },
    
    openProjectUrlInTab: function(url)
    {
        window.open(csVars.Url + csVars.ProjectUrl + url, '_blank');
    },

    openProjectUrl: function(url)
    {
        window.open(csVars.Url + csVars.ProjectUrl + url);
    },

    openIssueUrlInTab: function (issueId) {
        window.open(csVars.Url + csVars.ProjectUrl + "item/" + issueId, '_blank');
    },
    openIssueUrlInTabProj: function (issueId, projectid) {
        window.open(csVars.Url + "workspace/" + gemini_appnav.pageCard.Id + "/item/" + issueId, '_blank');
    },
    openIssueUrl: function (issueId) {
        window.open(+ "workspace/" + gemini_appnav.pageCard.Id + "/item/" + issueId, '_self');
    },

    showAddItem: function () {
        $("#add-item").click();
    },

    refreshPage: function() {
        window.location.reload();
    },
    translateMessage: function (message, keys, callback, callbackData) {
        gemini_ajax.postCall("resources", "get",
            function (response)
            {
                $(response.Result.Data).each(function (i, e)
                {
                    message = message.replace("[[" + e.Key + "]]", e.Value);
                });
                callback(message, callbackData);
            }, null, { keys: JSON.stringify(keys) }, null, true);
    },
    htmlEncode: function (value) {
        return $('<div/>').text(value).html();
    },
    htmlDecode: function(value) {
        return $('<div/>').html(value).text();
    },
    PAGE_TYPE: {
        Custom: 0,
        Items: 1,
        Planner: 2,
        Roadmap: 3,
        Changelog: 4,
        Burndown: 5,
        Testing: 6,
        Reports: 7,
        Documents: 8,
        Activity: 9,
        None: 10,
        Item: 11,
        ActivityOverdue: 12,
        ActivityDueToday: 13,
        ActivityDueTomorrow: 14,
        ActivityOpenedRecently: 15,
        ActivityClosedRecently: 16,
        MyWork: 17,
        MyWatched: 18,
        Timeline: 19,
        Calendar: 20,
        Marketing: 99
    },
    isMobile: function () {
        if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
            return true;
        }
        else
        {
            return false;
        }
    },
    isEmail: function(email) {
        var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    }
};

