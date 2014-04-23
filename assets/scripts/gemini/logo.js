gemini_logo =
{
    saveCallback: null,

    init: function()
    {
        $('#product-logo, #logo-settings', '#zone-header-bar').click(gemini_logo.showPopup);
    },

    showPopup: function(e)
    {
        gemini_commons.stopClick(e);
        $('.cs-menu-dropdown', '#project-menu-dropdown').hide();
        $("#cs-popup-center-content").css("width", "500px");
        $("#cs-popup-center-content").css("height", "300px");
        var add = "Save";

        gemini_commons.translateMessage("[[Save]]", ['Save'], function (message) {
            add = message;

            gemini_popup.centerPopup("configure", 'logo', null, null, add, null, null, null,
                function () {
                    gemini_logo.afterShow();
                }, true);
        });
    },

    afterShow: function()
    {
        gemini_ui.fancyInputs('#edit-logo .fancy');

        if ($('#custom', '#edit-logo').is(":checked")) {
            $('.file', '#edit-logo').removeAttr('disabled');
        }

        $('input[type=radio]', '#edit-logo').unbind('ifClicked').bind('ifClicked', function (e)
        {
            if ($(this).attr('id') == 'custom')
            {
                $('.file', '#edit-logo').removeAttr('disabled');

                if (csVars.IEVersion == -1) $('.file', '#edit-logo').click();
            }
            else
            {
                $('.file', '#edit-logo').attr('disabled', 'disabled');
            }
        });

        $("#popup-button-no", "#cs-popup-center").click(function (e) 
        {
            gemini_popup.popupClose(e);
        });

        $("#popup-button-yes", "#cs-popup-center").click(function (e) 
        {
            var options = 
            {
                url: gemini_ajax.getUrl('configure/logo', 'save', true),
                dataType: "json",
                success: function (responseText, statusText, xhr, $form) 
                {
                    if (responseText.success)
                    {
                        if (responseText.Result.Logo)
                        {
                            $('img', '#product-logo').attr('src', csVars.AssetsPath + '/images/logo/' + responseText.Result.Logo);
                            $('#product-logo').show();
                        }
                        else
                        {
                            $('#product-logo').hide();
                        }
                        gemini_popup.popupClose(e);

                        if(gemini_logo.saveCallback)
                        {
                            gemini_logo.saveCallback();
                            gemini_logo.saveCallback = null;
                        }
                        
                        setTimeout(gemini_master.initTabs, 200);
                    }
                } 
            };
            $("#edit-logo #regular-form").ajaxForm(options);
            $("#edit-logo #regular-form").submit();

            gemini_popup.popupClose(e);
        });
    }

}