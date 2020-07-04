gemini_reports =
{
    backgroundImage: '',
    stopEffect: false,
    currentXHR: null,

    hasLoaded: false,

    init: function ()
    {
        if (!gemini_reports.hasLoaded) {
            gemini_reports.fetch();
            gemini_reports.hasLoaded = true;
        }
        //setTimeout(function () { gemini_reports.fetch(); }, 1000);
    },

    fetch: function ()
    {
        if (gemini_reports.currentXHR != null)
        {
            gemini_reports.currentXHR.abort();
        }
        
        gemini_reports.currentXHR = gemini_ajax.postCall('reports', '', gemini_reports.render, null, gemini_reports.getPostParams());
    },

    getPostParams: function ()
    {
        return { cardId: gemini_appnav.pageCard.Id, filter: $('#filter-form').serialize() };
    },
    
    render: function (response)
    {
        if (response.success) {
            var reportItems = response.Result.Data.Reports;
            if (reportItems.length > 8) {
                $("li.reports ul").addClass("two-column");
            }
            var adminLi = $("li.reports ul li.controls");
            $("li.reports ul").empty();
            var workspace = gemini_ajax.getUrl('items', 'prepareexportxlsx');
            workspace += "?template=";
            $.each(reportItems, function (index, item) {
                var url = workspace + item.Template;
                var li = "<li>" +
                    "<a href=\""+url+"\"><i class=\"fad fa-file-spreadsheet\"></i>" +
                    item.Name + "</a></li>";
                $("li.reports ul").append(li);
            });
            if (adminLi.length) {
                $("li.reports ul").append(adminLi);
            }
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
                    gemini_reports.hasLoaded = false;
                    gemini_reports.init();
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