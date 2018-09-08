gemini_popup = {

    buttonModalResized: false,

    init: function () {
        $(document).bind('cbox_complete', function ()
        {                
            $("#cboxLoadedContent .button-modal").each(function () {
                $(this).css('width', '');
            });

            gemini_sizing.sameWidth("#cboxLoadedContent .button-modal", 3 + 30);
                // ...3 for border width, 30 for extra padding
        });

        $(document).bind('cbox2_complete', function ()
        {
            $("#cbox2LoadedContent .button-modal").each(function ()
            {
                $(this).css('width', '');
            });
            gemini_sizing.sameWidth("#cbox2LoadedContent .button-modal", 3 + 30);
                // ...3 for border width, 30 for extra padding
        });

    },

    close: function (e) {
        gemini_commons.stopClick(e);
        $.colorbox2.close();

        $("#modal-button-yes", "#modal-confirm").unbind('click');
        $("#modal-button-no", "#modal-confirm").unbind('click');
        gemini_keyboard.unbindEscape("#colorbox2 #modal-button-no");
        gemini_keyboard.unbindNo("#colorbox2 #modal-button-no");
        gemini_keyboard.unbindYes("#colorbox2 #modal-button-yes");
    },

    modalTranslatedConfirm: function (message, options, yesCallback, noCallback, keys) {
        gemini_ajax.postCall("resources", "get",
            function (response)
            {
                $(response.Result.Data).each(function (i, e)
                {
                    message = message.replace("[[" + e.Key + "]]", e.Value);
                });
                gemini_popup.modalConfirm(message, options, yesCallback, noCallback);
            }, null, { keys: JSON.stringify(keys) }, null, true);
    },

    modalConfirm: function (message, options, yesCallback, noCallback)
    {
        var optionsString = "{}";

        if (options != null) optionsString = options;

        $(".message", "#modal-confirm").html(message);

        $("#modal-button-yes", "#modal-confirm").click(function (e) {
            gemini_popup.close(e);

            if (yesCallback) yesCallback();
        });

        $("#modal-button-no", "#modal-confirm").click(function (e) {
            gemini_popup.close(e);

            if (noCallback) noCallback();
        });

        var params = $.extend({},
            { inline: true,
                href: "#modal-confirm",
                overlayClose: false,
                escKey: false,
                initialWidth: "400px",
                width: "400px",
                initialHeight: "150px",
                height: "150px"
            },
            optionsString);

        $.colorbox2(params);

        gemini_keyboard.bindEscape("#colorbox2 #modal-button-no");
        gemini_keyboard.bindNo("#colorbox2 #modal-button-no");
        gemini_keyboard.bindYes("#colorbox2 #modal-button-yes");
        $('#colorbox2 #modal-button-yes').focus(); 
    },

    centerPendingChanges: false,
    origActionText: null,
    origCancelText: null,

    popupsPopup: function (controller, method, params, extra, successCallback, error) {
        var html = '<div id="cs-popup-popup-center" style="max-width: 1000px">' +
                        '<div id= "cs-popup-center-zone" >' +
                            '<div id="cs-popup-center-content" class="pad-10">' +
                            '</div>' +
                        '<div id= "cs-popup-center-buttons" class="margin-top-20" > ' +
                            '<div id= "server-validation-error" class="hide left margin-top-15 margin-left-15" ></div > ' +
                            '<div class="buttons right" > ' +
                                '<input id= "popup-button-yes" type= "button" class="button-primary button-small button-modal" value= "Save" />' +
                                '<input id= "popup-button-no" type= "button" class="button-secondary button-small button-modal" value= "Cancel" />' +
                            '</div > ' +
                        '</div > ' +
                    '</div > ' +
                '</div >';

        gemini_ajax.call(controller, method, function (response) {
            $("#cs-popup-popup-center").remove(); //clear out any previous popup and all events.
            var popup = $(html);
            if (response.Success) {
                popup.css("display", "inline-block");
                $("body").append(popup);
                var responseHtml;
                if (response.Result == undefined)
                    responseHtml = response;
                else
                    responseHtml = response.Result.Html;

                var content = popup.find("#cs-popup-center-content");
                var buttons = popup.find("#cs-popup-center-buttons");

                content.html(responseHtml);
                buttons.css("top", "auto");

                var height = content.height() + buttons.height() + 50;
                var width = content.width() + 20;

                buttons.css("top", buttons.position().top + "px");
                popup.css("display", "block"); //ensure the div stays this width if content inside is changed


                var params = {
                    inline: true,
                    href: "#cs-popup-popup-center",
                    transition: "none",
                    width: Math.max(width, 300) + "px",
                    height: Math.max(height, 80) + "px",
                    overlayClose: false,
                    escKey: false,
                    opacity: '0.8'
                };
                
                $.colorbox2(params);
                gemini_keyboard.bindEscape("#colorbox2 #popup-button-no");
                
                content.find("input[type='text']:first").focus();
                content.find("input[type='text']:first").click();
                if (successCallback != null && successCallback != undefined) successCallback(response);
            }
        }, null, params, extra, true);

    },

    centerPopup: function (controller, method, params, extra, actionButtonText, cancelButtonText, hideActionButton, hideCancelButton, successCallback, ignoreContainer) {
        if (!actionButtonText)
        {
            actionButtonText = "Save";
        }
        else
        {
            gemini_popup.origActionText = $("#popup-button-yes", "#cs-popup-center").attr("value");
        }
        if (!cancelButtonText)
        {
            cancelButtonText = "Cancel";
        }
        else
        {
            gemini_popup.origCancelText = $("#popup-button-no", "#cs-popup-center").attr("value");
        }

        $("#popup-button-yes", "#cs-popup-center").show();
        $("#popup-button-no", "#cs-popup-center").show();

        //ensure that all events are unbound before showing the new popup.
        $("#popup-button-yes", "#cs-popup-center").unbind();
        $("#popup-button-no", "#cs-popup-center").unbind();
        
        $("#popup-button-yes", "#cs-popup-center").attr("value", actionButtonText);
        $("#popup-button-no", "#cs-popup-center").attr("value", cancelButtonText);

        if (hideActionButton) $("#popup-button-yes", "#cs-popup-center").hide();
        if (hideCancelButton) $("#popup-button-no", "#cs-popup-center").hide();
        gemini_ajax.call(controller, method, function (response) {
            if (response.Success) {
                gemini_popup.showCenterPopup(response);
                
                if (successCallback != null && successCallback != undefined) successCallback(response);
            }
        }, null, params, extra, ignoreContainer);
        
        
    },

    showCenterPopup: function (response) {
        if (response.success) {
            $("#cs-popup-center").css("display", "inline-block"); //get width correctly and needs to be BEFORE we insert the data

            var div = $("#cs-popup-center-content");
            if (response.Result == undefined)
                div.html(response);
            else
                div.html(response.Result.Html);
            $("#cs-popup-center-buttons").css("top", "auto");
                        
            var height = $("#cs-popup-center-content").height() + $("#cs-popup-center-buttons").height() + 50;
            var width = $("#cs-popup-center-content").width() + 20;
            $("#cs-popup-center-buttons").css("top", $("#cs-popup-center-buttons").position().top + "px");
            $("#cs-popup-center").css("display", "block"); //ensure the div stays this width if content inside is changed
            var params = {
                inline: true,
                href: "#cs-popup-center",
                transition: "none",
                width: Math.max(width, 300) + "px",
                height: Math.max(height, 80) + "px",
                overlayClose: false,
                escKey: false,
                opacity: '0.8'
            };
            $.colorbox(params);

            $("#cs-popup-center-content input[type='text']:first").focus();
            $("#cs-popup-center-content input[type='text']:first").click(); //If first item is a calender then it will pop out the calender as well

            gemini_keyboard.bindEscape("#colorbox #popup-button-no");
        }
    },

    popupCallback: function (response, extra)
    {
        $("#popup-button-yes", "#cs-popup-center").click(function (e) {
            gemini_popup.centerSave(e, extra);
        });

        $("#popup-button-no", "#cs-popup-center").click(function (e) {
            if (extra && extra.noCallback)
                extra.noCallback();
            e.preventDefault();
            gemini_popup.popupClose(e, extra);
        });
    },
    
    centerSave: function (e, extra) {
        if (extra && extra.yesCallback)
                extra.yesCallback();
            e.preventDefault();
            //gemini_popup.popupClose(e, extra);
            gemini_popup.centerPendingChanges = false;
    },

    popup2Close: function (e, extra) {
        if (e) {
            gemini_commons.stopClick(e);
        }

       
        $.colorbox2.close();
        
        gemini_keyboard.unbindEscape("#colorbox2 #popup-button-no");

        $('#cs-popup-popup-center').remove();
        //Unbind all events to the buttons

    },
    popupClose: function (e, extra) {
        if (e) {
            gemini_commons.stopClick(e);
        }
        
        /*if (gemini_popup.centerPendingChanges) {
            // warn of lost changes
            //TODO - Saar - Hard coded string:
            gemini_popup.modalConfirm("Save changes?", null,
            function () {
                gemini_popup.centerSave(e, extra);
            },
            function () {
                gemini_popup.pendingChanges = false;
                gemini_popup.popupClose(e, extra);
            });
        }
        else {*/
        // nothing to save, so dismiss
        
        $.colorbox.close();
        gemini_popup.centerPendingChanges = false;
        //    }
        gemini_keyboard.unbindEscape("#colorbox #popup-button-no");

        //Unbind all events to the buttons
        $("#popup-button-yes", "#cs-popup-center").unbind();
        $("#popup-button-no", "#cs-popup-center").unbind();
        $("#cs-popup-center").css("display", "none");

        if (gemini_popup.origActionText != null) {
            $("#popup-button-yes", "#cs-popup-center").attr("value", gemini_popup.origActionText);
            gemini_popup.origActionText = null;
        }
        if (gemini_popup.origCancelText != null) {
            $("#popup-button-no", "#cs-popup-center").attr("value", gemini_popup.origCancelText);
            gemini_popup.origCancelText = null;
        }
    },

    toast: function (text, error)
    {
        if ($("#toast-popup").is(":visible")) return;
        
        if (error != null && error != undefined && error == true)
        {
            $('#toast-popup').addClass("toast-bad").removeClass("toast-good");
        }
        else
        {
            $('#toast-popup').addClass("toast-good").removeClass("toast-bad");
        }

        $("#toast-popup .toast-message").html(text);

        $('#toast-popup').show('slide', { direction: 'right' }, 700, function ()
        {
            $("body").off("click", "#toast-popup");
            $("body").on("click", "#toast-popup", function (e) { $(this).fadeOut('fast'); });

            setTimeout(function ()
            {
                $('#toast-popup').hide('slide', { direction: 'right' }, 700);
            }, 3000);
        });
    }
};
