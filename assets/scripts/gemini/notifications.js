gemini_notifications =
{
    backgroundImage: '',
    stopEffect: false,
    currentXHR: null,

    init: function ()
    {
        $("#appnav-toolbar-notifications").hoverIntent({
            interval: 250,
            over: function () 
            {
                if (!$('#workspace-notifications-zone').is(':visible')) 
                {
                    $('.auto-popup').hide();
                    gemini_notifications.fetch();
                }
            }, out: function () { var x = 1; }
        });

        $("#appnav-toolbar-notifications").click(function () 
        {
            if (!$('#workspace-notifications-zone').is(':visible')) 
            {
                gemini_notifications.fetch();
            }
            else 
            {
                gemini_notifications.hide();
            }
        });
    },

    fetchLastItem: function (mode)
    {
        gemini_notifications.fetch('last-item');

        setTimeout(function () { gemini_notifications.hide(); }, 3000);
    },

    fetch: function (mode)
    {
        if (gemini_notifications.currentXHR != null)
        {
            gemini_notifications.currentXHR.abort();
        }
        else
        {
            gemini_notifications.backgroundImage = $('.notification', '#appnav-toolbar-notifications').css('background-image');
        }
        
        gemini_ui.runSpinner('notification', '#appnav-toolbar-notifications .notification', 20, 16);
        $('.notification', '#appnav-toolbar-notifications').css('background-image', 'none');

        if (mode == null || mode.length == 0) mode = "created";

        gemini_notifications.currentXHR = gemini_ajax.postCall('notifications', '', gemini_notifications.render, null, { mode: mode });
    },
    
    render: function (response)
    {
        if (response.success)
        {
            if ($('#workspace-notifications-zone').length > 0)
            {
                $('#workspace-notifications-zone').replaceWith(response.Result.Data.Html);
            }
            else
            {
                $("body").append(response.Result.Data.Html);
            }

            if (gemini_notifications.stopEffect)
            {
                gemini_notifications.show();
            }
            else
            {
                setTimeout(function () { gemini_notifications.show(); }, 200);
            }
        }
    },
    
    show: function ()
    {
        if (gemini_notifications.stopEffect)
        {
            gemini_notifications.stopEffect = false;

            $("#workspace-notifications-zone").show();

            gemini_notifications.afterShow();
        }
        else
        {
            $('#workspace-notifications-zone').show('slide', { direction: 'up' }, 250, function ()
            {
                gemini_notifications.afterShow();
            });
        }
    },
    
    afterShow: function ()
    {
        gemini_ui.removeSpinner('notification', '#appnav-toolbar-notifications .notification');

        $('.notification', '#appnav-toolbar-notifications').css('background-image', gemini_notifications.backgroundImage);
    },
    
    hide: function ()
    {
        $('#workspace-notifications-zone').hide('slide', { direction: 'up' }, 250);
    }
};