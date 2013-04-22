var gemini_popup = {

    buttonModalResized: false,
    init: function () {
        $(document).bind('cbox_complete', function () {
            if (!gemini_popup.buttonModalResized) {

                gemini_sizing.sameWidth(".button-modal", 3 + 30);
                // ...3 for border width, 30 for extra padding

                gemini_popup.buttonModalResized = true;
            }
        });

    },

    close: function (e) {
        gemini_commons.stopClick(e);
        $.colorbox.close();

        $("#modal-button-yes", "#modal-confirm").unbind('click');
        $("#modal-button-no", "#modal-confirm").unbind('click');
        gemini_keyboard.unbindEscape("#colorbox #modal-button-no");
        gemini_keyboard.unbindNo("#colorbox #modal-button-no");
        gemini_keyboard.unbindYes("#colorbox #modal-button-yes");
    },
    modalTranslatedConfirm: function (message, options, yesCallback, noCallback, keys) {
        $.ajax({
            type: "POST",
            url: csVars.Url + 'resources/get',
            data: {keys : JSON.stringify(keys)},
            success: function (response) {
                $(response.Result.Data).each(function (i, e) {
                    message = message.replace("[[" + e.Key + "]]", e.Value);
                });
                gemini_popup.modalConfirm(message, options, yesCallback, noCallback);
            }
        });
    },
    modalConfirm: function (message, options, yesCallback, noCallback) {
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

        $.colorbox(params);

        gemini_keyboard.bindEscape("#colorbox #modal-button-no");
        gemini_keyboard.bindNo("#colorbox #modal-button-no");
        gemini_keyboard.bindYes("#colorbox #modal-button-yes");
    },


    centerPendingChanges: false,

    centerPopup: function (controller, method, params, extra, actionButtonText, cancelButtonText, hideActionButton, hideCancelButton) {

        if (!actionButtonText) actionButtonText = "Save";
        if (!cancelButtonText) cancelButtonText = "Cancel";
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
                    /*initialWidth: "850px",
                    initialHeight: "530px",*/
                    width: Math.max(width, 300) + "px",
                    height: Math.max(height, 80) + "px",
                    overlayClose: false,
                    escKey: false,
                    opacity: '0.8'/*, TODO SAAR ADD ONCOMPLETE CALLBACK!
                        onComplete: function () { fdebugger; gemini_ui.htmlEditor('#saar'); }*/
                };
                $.colorbox(params);

                $("#cs-popup-center-content input[type='text']:first").focus();
                $("#cs-popup-center-content input[type='text']:first").click(); //If first item is a calender then it will pop out the calender as well

                gemini_keyboard.bindEscape("#colorbox #popup-button-no");
            }
        }, null, params, extra);
        
        
    },
    popupCallback: function (response, extra) {
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
    },
    
    toast: function(text, error)
    {
        if ($(".toast").is(":visible")) return;
        
        $(".toast").css({ top: $(window).scrollTop() + 50, 'z-index': 10000 });

        if (error != null && error != undefined && error == true) {
            $('.toast').addClass('error');
            $('.fonticon-tick', '.toast').addClass('fonticon-cross').removeClass('fonticon-tick');
        }

        $(".toast-message").html(text);
        $(".toast").fadeIn("fast");

        $("body").off("click", ".toast");
        $("body").on("click", ".toast", function (e) {$(this).hide();});

        setTimeout(function () {
            $(".toast").fadeOut("slow", function () {
                if (error != null && error != undefined && error == true) {
                    $('.toast').removeClass('error');
                    $('.fonticon-cross', '.toast').addClass('fonticon-tick').removeClass('fonticon-cross');
                }
            });
        }, 2500);
    }
};
