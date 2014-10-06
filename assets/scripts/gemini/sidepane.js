gemini_sidepane =
{
    destroyFunc: null,
    intervalHandle: null,
    isfading: false,
    expandSelector: null,
    initializing: true,
    currentXHR: null,

    init: function()
    {
        var height = ($('#footer').position().top - 42 - 5);
        //$('#side-pane').css('height',  height + 'px');
        $('#side-pane .contents').css('height', (height - 40 - 7 - 40) + 'px');
        $('.tab', '#side-pane .side-pane-tabs').click(gemini_sidepane.switchTab);
        $('#expand-collapse', '#side-pane').click(gemini_sidepane.expandCollapse);
        $('.side-collapsed', '#side-pane').click(gemini_sidepane.openTab);
        if (gemini_appnav.pageCard.IsNew)
        {
            $('.tab[data-action=chat]', '#side-pane .side-pane-tabs').hide();
            gemini_sidepane.expandSelector = $('.tab.selected', '#side-pane .side-pane-tabs');
        }
        else
        {
            if (!gemini_appnav.pageCard.CardData.EnableChat && (gemini_appnav.pageCard.CardData.IsShared || gemini_appnav.pageCard.Locked))
            {
                $('.tab[data-action=chat]', '#side-pane .side-pane-tabs').hide();
            }

            if(gemini_appnav.pageCard.CardData.State.ActiveView != '')
            {
                if(gemini_appnav.pageCard.CardData.State.AlwaysShow)
                {
                    $('.tab[data-action=' + gemini_appnav.pageCard.CardData.State.ActiveView + ']', '#side-pane .side-pane-tabs').click();
                }
                else
                {
                    gemini_sidepane.expandSelector = $('.tab[data-action=' + gemini_appnav.pageCard.CardData.State.ActiveView + ']', '#side-pane .side-pane-tabs');
                }
            }
        }
    },

    switchTab: function(e, elem)
    {
        if (e && e.target && $(e.target).hasClass('badge'))
        {
            return;
        }

        var _that = elem ? elem : $(this);

        if (gemini_sidepane.destroyFunc)
        {
            gemini_sidepane.destroyFunc();
        }

        $('.tab', '#side-pane .side-pane-tabs').removeClass('selected');
        _that.addClass('selected');
        var params = _that.attr('data-params');
        var postParams = null;
        if (params)
        {
            postParams = eval(params);
        }

        var width = _that.attr('data-width');
        if (!width)
        {
            width = '400px';
        }
        $('#side-pane').css('width', width);

        //var text = _that.html();
        gemini_ui.startBusyDiv(_that, true);
        //_that.empty();
        if(gemini_sidepane.currentXHR)
        {
            gemini_sidepane.currentXHR.abort();
            gemini_sidepane.currentXHR = null;
        }

        gemini_sidepane.currentXHR = gemini_ajax.postCall('', _that.attr('data-action'), function (response)
        {
            gemini_sidepane.currentXHR = null;
            gemini_ui.stopBusyDiv(_that);
           // _that.html(text);
            gemini_sidepane.renderTab(response);
        }, function ()
        {
            gemini_sidepane.currentXHR = null;
            gemini_ui.stopBusyDiv(_that);
            //_that.html(text);
        }, postParams);

        gemini_sidepane.saveState();
    },

    renderTab: function(response)
    {
        if (response.Result.Data.Toolbar)
        {
            $('.side-pane-toolbar #toolbar-contents', '#side-pane').html(response.Result.Data.Toolbar);
        }
        else
        {
            $('.side-pane-toolbar #toolbar-contents', '#side-pane').empty();
        }

        $('.contents', '#side-pane').html(response.Result.Data.Html);
        $('div:first', '#side-pane .contents').css('height', ($('#side-pane .contents').height() - 40) + 'px')
        var func = eval(response.Result.Data.JSInit);
        if (func) {
            response.Result.Data.Html = $('.contents', '#side-pane').html();
            func(response);
        }

        gemini_sidepane.destroyFunc = eval(response.Result.Data.JSDestroy);
    },

    saveState: function()
    {
        if (gemini_sidepane.initializing)
        {
            gemini_sidepane.initializing = false;
            return;
        }

        if (gemini_appnav.pageCard.IsNew)
        {
            return;
        }

        var show = $('#expand-collapse', '#side-pane').attr('data-collapsed') != '1';
        gemini_appnav.pageCard.CardData.State.ActiveView = $('.tab.selected', '#side-pane .side-pane-tabs').attr('data-action');
        gemini_ajax.postCall('action', 'updatestate', null, null, { alwaysShow: show, activeView: gemini_appnav.pageCard.CardData.State.ActiveView });
    },

    expandCollapse: function(e, finishedCallback)
    {
        $('.side-collapsed', '#side-pane').hide();
        $('.workspace-actions', '#side-pane').fadeOut('fast');
        $('.contents, .side-pane-tabs, #toolbar-contents', '#side-pane').fadeOut('fast');
        gemini_sidepane.isfading = false;
        var width = $('#side-pane').width();

        if ($('#expand-collapse', '#side-pane').attr('data-collapsed') == '1')
        {
            if (gemini_appnav.pageCard.IsNew || (!gemini_appnav.pageCard.CardData.EnableChat && (gemini_appnav.pageCard.CardData.IsShared || gemini_appnav.pageCard.Locked)))
            {
                $('.tab[data-action=chat]', '#side-pane .side-pane-tabs').hide();
            }
            else
            {
                $('.tab[data-action=chat]', '#side-pane .side-pane-tabs').show();
            }

            // Expand
            $('.contents, .side-pane-tabs, #toolbar-contents', '#side-pane').fadeIn('slow');
            width = 400;
            $('#page-content-zone').css('margin-right', '410px');
            $('#side-pane').width(width);
            $('#expand-collapse', '#side-pane').attr('data-collapsed', '0');
            $('#expand-collapse div', '#side-pane').css('background-position', '-540px -16px');
            
            if (gemini_sidepane.expandSelector)
            {
                gemini_sidepane.expandSelector.click();
                gemini_sidepane.expandSelector = null;
            }
            if (gemini_master.currentRefreshFunction)
            {
                gemini_master.currentRefreshFunction();
            }
            /*** WIZARD ***/
            if (gemini_wizard.active)
            {
                $.publish('wizard-position', ['expand']);
            }
            /*** WIZARD ***/
            if(finishedCallback)
            {
                finishedCallback();
            }
            gemini_sidepane.saveState();

            if (e) $.publish('side-pane', ['open']);
        }
        else
        {
            // Collapse
            width = 60;
            
            $('#page-content-zone').css('margin-right', '70px');
            $('#side-pane').width(width);
            $('#expand-collapse', '#side-pane').attr('data-collapsed', '1');
            $('#expand-collapse div', '#side-pane').css('background-position', '-520px -16px');
            $('.side-collapsed', '#side-pane').fadeIn('fast');
            if (gemini_appnav.pageCard.IsNew || (!gemini_appnav.pageCard.CardData.EnableChat && (gemini_appnav.pageCard.CardData.IsShared || gemini_appnav.pageCard.Locked)))
            {
                $('.side-collapsed[data-action=chat]', '#side-pane').hide();
            }
            $('.workspace-actions', '#side-pane').fadeIn('fast');
            if (gemini_master.currentRefreshFunction)
            {
                gemini_master.currentRefreshFunction();
            }
            /*** WIZARD ***/
            if (gemini_wizard.active)
            {
                $.publish('wizard-position', ['collapse']);
            }
            /*** WIZARD ***/
            if (finishedCallback)
            {
                finishedCallback();
            }
            if (gemini_sidepane.destroyFunc)
            {
                gemini_sidepane.destroyFunc();
            }
            gemini_sidepane.saveState();
        }
    },

    openTab: function(e)
    {
        if (e && e.target && $(e.target).hasClass('badge')) {
            return;
        }
        var _that = $(this);
        gemini_sidepane.expandSelector = null;
        gemini_sidepane.expandCollapse(null, function ()
        {
            $('.side-pane-toolbar #toolbar-contents', '#side-pane').empty();
            $('.contents', '#side-pane').empty();
            $('.tab[data-action=' + _that.attr('data-action') + ']', '#side-pane .side-pane-tabs').click();
        });
    }
}