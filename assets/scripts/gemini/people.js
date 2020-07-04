gemini_people =
{
    backgroundImage: '',
    subscribedFilter: false,
    ignoreFilter: false,
    stopEffect: false,
    currentXHR: null,

    init: function ()
    {
        setTimeout(function () { gemini_people.fetch(); }, 1000);
    },

    fetch: function ()
    {
        if (gemini_people.currentXHR != null)
        {
            gemini_people.currentXHR.abort();
        }
        else
        {
            gemini_people.backgroundImage = $('.people', '#appnav-toolbar-people').css('background-image');
        }
        
        gemini_ui.runSpinner('people', '#appnav-toolbar-people .people', 20, 16);
        $('.people', '#appnav-toolbar-people').css('background-image', 'none');

        gemini_people.currentXHR = gemini_ajax.postCall('people', '', gemini_people.render, null, gemini_people.getPostParams());
    },

    getPostParams: function()
    {
        return { cardId: gemini_appnav.pageCard.Id, filter: $('#filter-form').serialize() };
    },
    
    render: function (response)
    {
        if (response.success)
        {
            var height = $('#workspace-people-zone').height();
            $('#workspace-people-zone').replaceWith(response.Result.Data.Html);
            $('.the-people', '#workspace-people-zone').css('height', height + 'px')
            

            if (gemini_people.stopEffect)
            {
                gemini_people.show();
            }
            else
            {
                setTimeout(function () { gemini_people.show(); }, 200);
            }
        }
    },
    
    show: function ()
    {
        if (gemini_people.stopEffect)
        {
            gemini_people.stopEffect = false;

            $("#workspace-people-zone").show();

            gemini_people.afterShow();
        }
        else
        {
            $('#workspace-people-zone').show('slide', { direction: 'down' }, 250, function ()
            {
                gemini_people.afterShow();
            });
        }

        $(".the-people", "#workspace-people-zone").jScrollPane('reinitialise');
    },
    
    afterShow: function ()
    {
        gemini_ui.removeSpinner('people', '#appnav-toolbar-people .people');

        $('.people', '#appnav-toolbar-people').css('background-image', gemini_people.backgroundImage);
        
        if (!gemini_people.subscribedFilter)
        {
            $.subscribe('items-grid-filter-executed.people', function ()
            {
                gemini_people.stopEffect = true;
                gemini_sidepane.switchTab(null, $('.tab[data-action=people]', '#side-pane .side-pane-tabs'));
            });
            
            gemini_people.subscribedFilter = true;
        }

        $.unsubscribe('issue-update');
        $.subscribe('issue-update', function (data) { gemini_people.refreshPeopleTabIfVisible(data); });

        $.unsubscribe('issue-delete');
        $.subscribe('issue-delete', function (data) { gemini_people.refreshPeopleTabIfVisible(data); });

        $.unsubscribe('issue-create');
        $.subscribe('issue-create', function (data) {
            if (gemini_items.pageType == gemini_commons.PAGE_TYPE.Items) return; //On items page we already refresh sidebar tab when adding new item.

            gemini_people.refreshPeopleTabIfVisible(data);
        });

        $(".person, .footer", "#workspace-people-zone").unbind('click').bind('click', function ()
        {
            gemini_people.selectResource($(this).attr('data-id'));
        });

        $.unsubscribe('side-pane');
        $.subscribe('side-pane', function (data) {
            if ($('#side-pane .side-pane-tabs .tab.selected').data('action') != 'people') return;
            gemini_people.refreshPeopleTabIfVisible(data);
            
        });
    },
    
    hide: function ()
    {
        //$('#workspace-people-zone').hide('slide', { direction: 'down' }, 250);

        $.unsubscribe('items-grid-filter-executed.people');

        $.unsubscribe('issue-update');
        $.unsubscribe('issue-delete');
        $.unsubscribe('issue-create');

        gemini_people.subscribedFilter = false;
    },

    selectResource: function (id)
    {
        if ($("#filter-form").length == 0) return;
        $.unsubscribe('items-grid-filter-executed.people');
        gemini_people.subscribedFilter = false;
        if ($('#instant-filter-AssignedTo').length == 0) {
            gemini_filter.addFilterBox('AssignedTo', function (response) {
                gemini_people.selectResource(id);
            });
        }
        else {
            $('#AssignedTo option', '#instant-filter-AssignedTo').prop('selected', false);
            $('#AssignedTo', '#instant-filter-AssignedTo').val(id);
            gemini_ui.chosenUpdate($('#AssignedTo', '#instant-filter-AssignedTo'));
            $('#AssignedTo', '#instant-filter-AssignedTo').trigger("change");
        }

        /*** WIZARD ***/
        if (gemini_wizard.active)
        {
            $.publish('wizard-action', ['people']);
        }
        /*** WIZARD ***/
        
    },
    refreshPeopleTabIfVisible: function(data)
    {
        gemini_people.stopEffect = true;
        gemini_sidepane.switchTab(null, $('.tab[data-action=people]', '#side-pane .side-pane-tabs'));
    }
};