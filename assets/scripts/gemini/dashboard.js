gemini_dashboard =
{
    subscribedFilter: false,
    stopEffect: false,
    currentXHR: null,

    init: function ()
    {
        setTimeout(function () { gemini_dashboard.fetch(); }, 1000);
    },

    fetch: function ()
    {
        if (gemini_dashboard.currentXHR != null)
        {
            gemini_dashboard.currentXHR.abort();
        }       
                        
        gemini_dashboard.currentXHR = gemini_ajax.postCall('metrics', '', gemini_dashboard.render, null, gemini_dashboard.getPostParams());
    },

    getPostParams: function ()
    {
        return { cardId: gemini_appnav.pageCard.Id, filter: $('#filter-form').serialize() };
    },
        
    render: function (response)
    {
        if (response.success)
        {
            if (gemini_dashboard.currentXHR != null)
            {
                $('#dashboard-zone').replaceWith(response.Result.Data.Html);
                $('#dashboard-zone', '#side-pane .contents').css('height', ($('#side-pane .contents').height() - 40) + 'px')
                gemini_dashboard.currentXHR = null;
            }
            
            $('.configure', '#side-pane .side-pane-toolbar').unbind('click').click(function ()
            {
                gemini_appnav.showAppNavBox('dashboard');
            });

            if (!gemini_dashboard.subscribedFilter) {
                $.subscribe('items-grid-filter-executed.dashboard', function () {
                    gemini_dashboard.stopEffect = true;
                    gemini_sidepane.switchTab(null, $('.tab[data-action=metrics]', '#side-pane .side-pane-tabs'));
                });

                gemini_dashboard.subscribedFilter = true;
            }

            gemini_dashboard.afterShow();
        }
    },
    
    afterShow: function ()
    {           
        if (!gemini_dashboard.subscribedFilter)
        {
            $.subscribe('items-grid-filter-executed.dashboard', function ()
            {
                gemini_dashboard.stopEffect = true;
                gemini_sidepane.switchTab(null, $('.tab[data-action=metrics]', '#side-pane .side-pane-tabs'));
            });
            
            gemini_dashboard.subscribedFilter = true;
        }
        $("#dashboard-wrapper", "#dashboard-zone").css('height', ($('#dashboard-zone').height()) + 'px')
        $("#dashboard-wrapper", "#dashboard-zone").jScrollPane('reinitialise');
    },
    
    hide: function ()
    {
        $.unsubscribe('items-grid-filter-executed.dashboard');
        
        gemini_dashboard.subscribedFilter = false;
    }

};