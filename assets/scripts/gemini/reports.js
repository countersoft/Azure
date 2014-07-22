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

            var report = $('#reportFile')[0];
            if (report != undefined && report != null) {
                gemini_reports.ReportFileUploader(report);
            }
        }
    },
    
    hide: function ()
    {
        $('#workspace-reports-zone').hide('slide', { direction: 'down' }, 250);
    },

    ReportFileUploader: function (element) {
        var template = '<li>' +
                '<span class="qq-upload-file configure"></span>' +
                '<span class="qq-upload-spinner"></span>' +
                '<span class="qq-upload-size"></span>' +
                '<a class="qq-upload-cancel" href="#">[[Cancel]]</a>' +
                '<span class="qq-upload-failed-text">[[Failed]]</span>' +
                '<span class="fonticon-cross"></span>' +
            '</li>';

        var attachmentUploader = new qq.FileUploader({
            element: element,
            action: gemini_ajax.getUrl('reports', 'upload'),
            debug: false,

            onComplete: function (_id, fileName, responseJSON) {
                if (responseJSON.success) {
                    gemini_reports.init();
                    if (responseJSON.Result == undefined) {
                        gemini_reports.init();
                    }
                }
                $(".qq-upload-fail .fonticon-cross").click(function () {
                    $(this).parent().remove();
                });
            },
            taxonomy: {
            uploadButton: "<a href='#'>" + $('#reportFile').attr('data-upload-text') + "</a>",
            },
            fileTemplate: template
        });
    },
};