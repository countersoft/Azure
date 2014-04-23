gemini_reports =
{
    backgroundImage: '',
    stopEffect: false,
    currentXHR: null,

    init: function ()
    {
        setTimeout(function () { gemini_reports.fetch(); }, 1000);
    },

    fetch: function ()
    {
        if (gemini_reports.currentXHR != null)
        {
            gemini_reports.currentXHR.abort();
        }
        else
        {
            gemini_reports.backgroundImage = $('.reports', '#appnav-toolbar-reports').css('background-image');
        }
        
        gemini_ui.runSpinner('reports', '#appnav-toolbar-reports .reports', 20, 16);
        $('.reports', '#appnav-toolbar-reports').css('background-image', 'none');

        gemini_reports.currentXHR = gemini_ajax.postCall('reports', '', gemini_reports.render, null, gemini_reports.getPostParams());
    },

    getPostParams: function ()
    {
        return { cardId: gemini_appnav.pageCard.Id, filter: $('#filter-form').serialize() };
    },
    
    render: function (response)
    {
        if (response.success)
        {
            $('#workspace-reports-zone').replaceWith(response.Result.Data.Html);
            $('.content', '#workspace-reports-zone').css('height', ($('#workspace-reports-zone').height()) + 'px')
            $(".content", "#workspace-reports-zone").jScrollPane('reinitialise');
        }
    },
    
    hide: function ()
    {
        $('#workspace-reports-zone').hide('slide', { direction: 'down' }, 250);
    },
};