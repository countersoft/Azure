gemini_reports = {

    init: function (opts) {
        
        gemini_reports.settings = opts;

        $("#Reports").change(function (e) {
            gemini_reports.reportChanged(e);
        });
        gemini_ui.datePicker(".datepicker", gemini_reports.reportChanged);

        $(".datepicker").change(function (e) {
            gemini_reports.reportChanged(e);
        });

        $("#SubChart").change(function (e) {
            gemini_reports.reportChanged(e);
        });

        var options = jQuery.parseJSON(gemini_commons.htmlDecode(gemini_appnav.pageCard.Options));

        gemini_ui.setDropdownValue("#Reports", options.SelectedReport);
        //$("#Reports").val(options.SelectedReport); This seems to work?

        $("#FieldId").change(function (e) {
            gemini_reports.reportChanged(e);
        });
        $("#FilterId").change(function (e) {
            gemini_reports.reportChanged(e);
        });
        $("#ProjectId").change(function (e) {
            gemini_reports.reportChanged(e);
        });
        $("#TimeTypeId").change(function (e) {
            gemini_reports.reportChanged(e);
        });
        $("#ResourceId").change(function (e) {
            gemini_reports.reportChanged(e);
        });
        $("#GroupBy").change(function (e) {
            gemini_reports.reportChanged(e);
        });



        $(".report-summary-table-button", "#report-menu").click(function () {
            $("#ProjectSummaryChart").val("false");
            $(".report-summary-chart").fadeOut('fast', function () {
                $(".report-summary-table").fadeIn('fast');
            });
        });
        $(".report-summary-chart-button", "#report-menu").click(function () {
            $("#ProjectSummaryChart").val("true");
            $(".report-summary-table").fadeOut('fast', function () {
                $(".report-summary-chart").fadeIn('fast');
            });
        });
        gemini_reports.options = options;
        gemini_reports.setupControls();
        gemini_reports.reportChanged();

        $('.control-icon', '#report-menu').click(function () {
            var _this = $(this);
            var options = _this.find('+ .options');

            if (options.is(":visible")) {
                options.hide();
                gemini_keyboard.unbindEscape("#page-options-box .options");
            }
            else {
                _this.parent().parent().find(".options").each(function () {
                    if ($(this).is(":visible")) {
                        $(this).hide();
                    }
                });

                options.show();
                gemini_keyboard.bindEscape("#page-options-box .options", gemini_reports.escapeDropdowns);
            }

            options.position({
                "of": _this,
                "my": "right top",
                "at": "right bottom",
                "offset": "0 0",
                "collision": "none"
            });
        });

    },
    escapeDropdowns: function (guid, selector) {
        $(selector).hide();
        gemini_keyboard.unbindEscape(guid);
    },
    settings: null,
    options: null,
    reportChanged: function (e) {

        gemini_ui.cursorWait();
        $("#report-content").html("<div id='cs-template'><div id='no-data'>"+ gemini_reports.settings.Loading  +"</div></div>");

        gemini_ajax.postCall(csVars.ProjectUrl + "report", "get", gemini_reports.displayReport, null, $("#ReportParams").serialize());

    },
    displayReport: function (response) {

        if (response == "Not Found") {
            $("#report-content").empty();
            gemini_ui.cursorDefault();
            return;
        }
        if (response.Result.SavedCard != null) {
            gemini_appnav.pageCard.Options = response.Result.SavedCard.Options;
            gemini_reports.options = jQuery.parseJSON(response.Result.SavedCard.Options);
        }
        gemini_reports.setupControls();
        $("#report-content").html(response.Result.Html);
        $(window).trigger("resize");
    },
    setupControls: function () {
        var options = gemini_reports.options;
        if (options.StartDate) {
            $("#StartDate").show().val(options.StartDateDisplay);
        } else {
            $("#StartDate").hide();
        }
        if (options.EndDate) {
            $("#EndDate").show().val(options.EndDateDisplay);
        } else {
            $("#EndDate").hide();
        }
        gemini_ui.setDropdownValue("#Reports", options.Reports);

        if (options.SubChart && options.Reports == 20) {
            //Resource Item/Hours/? Allocation
            gemini_ui.setDropdownValue("#HoursAllocation", options.SubChart);
            $("#HoursAllocationContainer").show();
        } else {
            $("#HoursAllocationContainer").hide();
        }

        if (options.Reports == 40) {
            $("#FieldFilterContainer").show();
            $("#FilterContainer").show();
        } else {
            $("#FieldFilterContainer").hide();
            $("#FilterContainer").hide();
        }
        if (options.Reports >= 30 && options.Reports < 40) {
            $("#ProjectSummaryControlsContainer").show();
        } else {
            $("#ProjectSummaryControlsContainer").hide();
        }

        if (options.Reports >= 50 && options.Reports < 60) {
            
            $("#ResourceFilterContainer").hide();
            /*if (options.Reports == 53) //User
                $("#ProjectFilterContainer").show();
            else*/ if (options.Reports == 52) //All
            {
                $("#ResourceFilterContainer").show();
            }
            else if (options.Reports == 51) //All
                $("#ResourceFilterContainer").show();
            
            $("#TimeFilterContainer").show();
            $("#TimeReportExtraControls").show();

        } else {
            $("#ProjectFilterContainer").show();
            $("#TimeFilterContainer").hide();
            $("#ResourceFilterContainer").hide();
            $("#TimeReportExtraControls").hide();
        }

        //console.info("pdf url", options.PdfUrl);
        $("#pdf-action").data("pdf", options.PdfUrl);
        gemini_ui.cursorDefault();
        

    }
};