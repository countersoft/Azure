gemini_wizard = {
    currentInterval: null,
    active: null,

    init: function ()
    {
        gemini_wizard.active = 1;
        gemini_ajax.call('wizard', 'view', function (response)
        {
            if (!response.success) return;
            var html = $('#wizard-placeholder').empty().html(response.Result.Data);
            gemini_wizard.adjustStepPosition();
            html.fadeIn('slow');
            gemini_wizard.startPull();
        }, null, null, null, true);

        $.unsubscribe('wizard-position');
        $.subscribe('wizard-position', function ()
        {
            if ($('#wizard-action-container').length)
            {
                gemini_wizard.adjustStepPosition();
            }
        });
    },

    adjustStepPosition: function()
    {
        if ($('#wizard-action-container').length)
        {
            $('#wizard-action-container').css('right', (parseInt($('#side-pane').css('width').replace('px', '')) + 7) + 'px');
        }
    },

    initStart: function()
    {
        $('.wizard-box', '#wizard-welcome-box').click(function () {
            $('.wizard-box').removeClass('wizard-box-selected');
            $(this).addClass('wizard-box-selected');
            $('.wizard-disabled-btn', '#wizard-welcome-box').addClass('wizard-green-btn').removeClass('wizard-disabled-btn');
        });

        $('#wizard-welcome-box').on('click', '.wizard-green-btn', function () {
            var selectedBox = $('.wizard-box-selected').attr('data-box');
            if (selectedBox == undefined || selectedBox == null || selectedBox.length == 0) return;
            $('.absolute-center-is-fixed-inner').fadeOut('slow', function () {
                $('.absolute-center-is-fixed').hide();
                gemini_ajax.postCall('wizard', 'start', function (response)
                {
                    if (!response.success) return;
                    gemini_wizard.renderStep(response.Result.Data);
                }, null, {type: selectedBox}, null, true);
            });
        });
    },

    initEnd : function()
    {
        if (gemini_wizard.currentInterval != null)
        {
            clearInterval(gemini_wizard.currentInterval)
            gemini_wizard.currentInterval = null;
        }

        $('.wizard-welldone-action', '#wizard-welldone-box').click(function ()
        {
            var selectedBox = $(this).attr('data-box');
            if (selectedBox == undefined || selectedBox == null || selectedBox.length == 0) return;
            if (selectedBox == "download")
            {
                gemini_ajax.postCall('wizard', 'action/download', function (response) {
                    if (response.success) {
                        if (response.Result && response.Result.Data && response.Result.Data.Url) {
                            window.location.href = response.Result.Data.Url;
                        }
                        $('.absolute-center-is-fixed-inner-welldone').fadeOut('slow', function () {
                            $('.absolute-center-is-fixed').hide();
                        });
                        gemini_wizard.active = null;
                    }
                }, null, { restart: true }, null, true);
                return;
            }
            $('.wizard-welldone-content', '#wizard-welldone-box').hide();
            $('.wizard-welldone-' + selectedBox, '#wizard-welldone-box').show();
        });

        $('.wizard-welldone-btn', '#wizard-welldone-box').click(function ()
        {
            var form=$(this).closest('form');
            gemini_ajax.postCall('wizard', 'action/' + form.attr('action'), function (response)
            {
                if(response.success)
                {
                    if (response.Result && response.Result.Data && response.Result.Data.Url)
                    {
                        window.location.href = response.Result.Data.Url;
                    }
                    $('.absolute-center-is-fixed-inner-welldone').fadeOut('slow', function ()
                    {
                        $('.absolute-center-is-fixed').hide();
                    });
                    gemini_wizard.active = null;
                }
            }, null, form.serialize(), null, true);
            
        });
    },

    initStep: function(fade)
    {
        $('#wizard-action-container').fadeIn('slow');
        $.unsubscribe('wizard-action');
        $.subscribe('wizard-action', function (_, data)
        {
            if(data == $('#wizard-action-box').attr('data-action'))
            {
                gemini_ajax.postCall('wizard', 'step', function (response)
                {
                    if (!response.success) return;
                    if (fade)
                    {
                        $('#wizard-action-container').fadeOut('slow', function ()
                        {
                            gemini_wizard.renderStep(response.Result.Data);
                        });
                    }
                    else
                    {
                        gemini_wizard.renderStep(response.Result.Data);
                    }
                }, null, { type: $('#wizard-action-box').attr('data-type'), step: $('#wizard-action-box').attr('data-next-step') }, null, true);
            }
        });
    },

    pullState: null,
    renderStep: function(html)
    {
        if (gemini_wizard.currentInterval != null)
        {
            clearInterval(gemini_wizard.currentInterval)
            gemini_wizard.currentInterval = null;
            gemini_ajax.postCall('wizard', 'pull', null, null, { type: $('#wizard-action-box').attr('data-type'), state: '0' }, null, true);
        }
        var newHtml = $('#wizard-placeholder').empty().html(html);
        gemini_wizard.adjustStepPosition();
        newHtml.fadeIn('slow');
        gemini_wizard.startPull();
    },

    startPull: function()
    {
        if ($('#wizard-action-box').attr('data-pull') == '1') {
            gemini_wizard.pullState = '1';
            setInterval(gemini_wizard.pull, 5000);
        }
    },
    
    pull: function()
    {

        gemini_ajax.postCall('wizard', 'pull', function (response)
        {
            if(response.Result.Data == "1")
            {
                $.publish('wizard-action', [$('#wizard-action-box').attr('data-action')]);
            }
            
        }, null, { state: gemini_wizard.pullState }, null, true);

        gemini_wizard.pullState = '2';
    }
};