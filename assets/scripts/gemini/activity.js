gemini_activity = {
    callback: [],
    currentCalendarChecked: false,
    currentCalendarIndex: 0,
    initTimeline: function ()
    {
        gemini_master.currentRefreshFunction = gemini_activity.executeTimeline;
        gemini_activity.sizeTimelanes();

        $(window).resize(function () {
            waitForFinalEvent(function () { gemini_activity.sizeTimelanes(); }, 500, "timelane-resize");
        });

        $.subscribe('items-grid-filter-executed.timeline', function (_, result) {
            gemini_activity.executeTimeline();
        });
    },

    executeTimeline: function()
    {
        gemini_ajax.postCall('timeline', 'fetch', function (response)
        {
            $('#activity-timeline-data', '#activity-timeline').html(response.Result.Data.Html);
           
            gemini_appnav.pageCard.Options['Timeline'] = response.Result.Data.SavedCard.Options['Timeline'];

            gemini_activity.sizeTimelanes();
        }, null, { filter: $('#filter-form').serialize() });
    },

    sizeTimelanes: function () {
        $(".timelane").height($("#page-content-zone").height() - 200);
        $(".timelane").jScrollPane({});
    },

    loadCalendarItems: function (response, callback) {
        var events = [];

        if (response.Result.SavedCard != null) {
            gemini_appnav.pageCard.Options['Calendar'] = response.Result.SavedCard.Options['Calendar'];
        }

        $(response.Result.Events).each(function () {
            events.push({
                title: this.Title,
                start: this.Start,
                end: this.End,
                url: this.Url,
                color: this.Color,
                id: this.Id,
                editable: this.Editable,
                allDay: this.AllDay,
                className: this.ClassName,
                backgroundColor: this.BackgroundColor,
                borderColor: this.BorderColor,
                textColor: this.TextColor,
                resizable: this.Resizable,
                draggable: this.Draggable,
                refId: this.RefId,
                description: this.Description,
                colorText : this.ColorText

            });

        });
        callback(events);
    },

    initCalendar: function ()
    {
        gemini_master.currentRefreshFunction = gemini_activity.refreshView;
        var options = jQuery.parseJSON(gemini_commons.htmlDecode(gemini_appnav.pageCard.Options['Calendar']));
        gemini_ui.fancyInputs('#calendar-control-box .fancy', 'background-color-white');
        $("#widget-calendar").fullCalendar({
            editable: true,
            year: options.Year,
            month: options.Month - 1,
            date: options.Day - 1,
            defaultView: options.CurrentView,
            header: {
                left: '',
                center: '',
                right: ''
            },
            firstDay: 1,
            timeFormat: 'H:mm',
            aspectRatio: 2,

            eventDrop: function (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) {
                if (false && !confirm("Are you sure about this drop change?")) {
                    revertFunc();
                }
                else {
                    var data =
                        {
                            issueid: event.id,
                            daysOffset: dayDelta,
                            minutesOffset: minuteDelta
                        };
                    gemini_ajax.call("calendar", "dropSave", function (result) { if (!result.Success) { revertFunc(); } }, revertFunc, data);

                }
            },
            
            eventResize: function (event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view) {
                if (false && !confirm("Are you sure about this resize change?")) {
                    revertFunc();
                }
                else {
                    var data =
                        {
                            issueid: event.id,
                            daysOffset: dayDelta,
                            minutesOffset: minuteDelta
                        };
                    gemini_ajax.call("calendar", "resizeSave", function (result) { if (!result.Success) { revertFunc(); } }, revertFunc, data);
                }
            },
            
            eventRender: function (event, element) {

                element.find("div.fc-event-inner").wrapInner('<div class="event-content" title="' + event.colorText + '" />');
                element.find("div.fc-event-inner div.event-content").append("&nbsp;<span class=\"CalendarItemTitle\">" + event.description + "</span>");
            },
            viewDisplay: function (view) {
                $("#calendar-title").html("<h2>" + view.title + "</h2>");
            }
        });
        
        $("#calendar-control-box #calendar-month").bind("click", function () {
            gemini_activity.changeView('month');
        });
        
        $("#calendar-control-box #calendar-basicweek").bind("click", function () {
            gemini_activity.changeView('basicWeek');
        });
        
        $("#calendar-control-box #calendar-agendaweek").bind("click", function () {
            gemini_activity.changeView('agendaWeek');
        });
        
        $("#calendar-control-box #calendar-basicday").bind("click", function () {
            gemini_activity.changeView('basicDay');
        });
        
        $("#calendar-control-box #calendar-prev").bind("click", function (e) {
            e.preventDefault();
            $("#widget-calendar").fullCalendar('prev');
        });
        
        $("#calendar-control-box #calendar-next").bind("click", function (e) {
            e.preventDefault();
            $("#widget-calendar").fullCalendar('next');
        });
        
        $("#calendar-control-box #IncStartDate").bind("ifClicked", function () {
            gemini_activity.amendSource(($(this).is(':checked') ? false : true), 0);
        });

        $("#calendar-control-box #IncDueDate").bind("ifClicked", function () {
            gemini_activity.amendSource(($(this).is(':checked') ? false : true), 1);
        });
        $("#calendar-control-box #IncGantt").bind("ifClicked", function () {
            gemini_activity.amendSource(($(this).is(':checked') ? false : true), 2);
        });

        $("#calendar-control-box #ColorBySelected").change(function () { $("#widget-calendar").fullCalendar('refetchEvents'); });

        /*if (!options.ColorMode || options.ColorMode == "undefined")
        options.ColorMode = "Status";*/
        $("#ColorBySelected").val(options.ColorMode);

        //Set up the UI from the card options
        if (options.ShowStart) gemini_activity.amendSource(true, 0);
        if (options.ShowDue) gemini_activity.amendSource(true, 1);
        if (options.ShowDuration) gemini_activity.amendSource(true, 2);

        gemini_activity.changeView(options.CurrentView);

        $('.control-icon', '#calendar-control-box').click(function () {
            var _this = $(this);
            var options = _this.find('+ .options');

            if (options.is(":visible")) {
                options.hide();
            }
            else {
                _this.parent().parent().find(".options").each(function () {
                    if ($(this).is(":visible")) {
                        $(this).hide();
                    }
                });

                options.show();
            }

            options.position({
                "of": _this,
                "my": "right top",
                "at": "right bottom",
                "offset": "0 0",
                "collision": "none"
            });
        });

        $.subscribe('items-grid-filter-executed.calendar', function (_, result) {
            gemini_activity.executeCalendarFilter();

        });
    },

    refreshView: function()
    {
        gemini_activity.changeView($("#widget-calendar").fullCalendar("getView").name);
    },

    changeView: function (viewname) {
        var curview = $("#widget-calendar").fullCalendar("getView").name.toLowerCase();
        $("#widget-calendar").fullCalendar('changeView', viewname);
        $("#calendar-" + curview).removeClass(curview + "-selected").addClass(curview);
        /*
        $("#calendar-month").removeClass("month-selected").addClass("month");
        $("#calendar-basicweek").removeClass("basicweek-selected").addClass("basicweek");
        $("#calendar-agendaweek").removeClass("agendaweek-selected").addClass("agendaweek");
        $("#calendar-basicday").removeClass("basicday-selected").addClass("basicday");
        */
        /*$("#calendar-control-box .fc-button").removeClass("fc-state-active");*/

        $( "#calendar-" + viewname.toLowerCase() ).addClass( viewname.toLowerCase() + "-selected" );
        if (viewname !== curview) { //update the options to the global card
            var options = jQuery.parseJSON( gemini_commons.htmlDecode( gemini_appnav.pageCard.Options['Calendar'] ) );
            options.CurrentView = viewname;
            gemini_appnav.pageCard.Options['Calendar'] = gemini_commons.htmlEncode( JSON.stringify( options ) );
        }
        
    },

    amendSource: function (checked, index) {
        gemini_activity.currentCalendarChecked = checked;
        gemini_activity.currentCalendarIndex = index;
        switch (index) {
            case 0:
                //$("#IncGantt").prop("checked", false);
                //$("#IncStartDate").prop("checked", checked);
                $("#IncGantt").iCheck("uncheck");
                $("#IncStartDate").iCheck("check");
                $("#widget-calendar").fullCalendar('removeEventSource', gemini_activity.calendarSources[2]);
                break;
            case 1:
                //$("#IncGantt").prop("checked", false);
                //$("#IncDueDate").prop("checked", checked);
                $("#IncGantt").iCheck("uncheck");
                $("#IncDueDate").iCheck("check");
                $("#widget-calendar").fullCalendar('removeEventSource', gemini_activity.calendarSources[2]);
                break;
            case 2:
                //$("#IncStartDate").prop("checked", false);
                //$("#IncDueDate").prop("checked", false);
                //$("#IncGantt").prop("checked", checked);
                $("#IncStartDate").iCheck("uncheck");
                $("#IncDueDate").iCheck("uncheck");
                $("#IncGantt").iCheck("check");
                $("#widget-calendar").fullCalendar('removeEventSource', gemini_activity.calendarSources[0]);
                $("#widget-calendar").fullCalendar('removeEventSource', gemini_activity.calendarSources[1]);
                break;
        }
        if (checked) {
            $("#widget-calendar").fullCalendar('addEventSource', gemini_activity.calendarSources[index]);
        } else {
            $("#widget-calendar").fullCalendar('removeEventSource', gemini_activity.calendarSources[index]);
        }
    },

    calendarSources: [
        function (start, end, callback) {
            gemini_ajax.postCall("calendar", "StartDate", gemini_activity.loadCalendarItems, null, {
                start: Math.round(start.getTime() / 1000),
                end: Math.round(end.getTime() / 1000),
                options: gemini_activity.getOptions(),
                filterForm: $('#filter-form').serialize()
            }, callback);
        },
        function (start, end, callback) {
            gemini_ajax.postCall("calendar", "DueDate", gemini_activity.loadCalendarItems, null, {
                start: Math.round(start.getTime() / 1000),
                end: Math.round(end.getTime() / 1000),
                options: gemini_activity.getOptions(),
                filterForm: $('#filter-form').serialize()
            }, callback);
        },
        function (start, end, callback) {
            gemini_ajax.postCall("calendar", "Gantt", gemini_activity.loadCalendarItems, null, {
                start: Math.round(start.getTime() / 1000),
                end: Math.round(end.getTime() / 1000),
                options: gemini_activity.getOptions(),
                filterForm: $('#filter-form').serialize()
            }, callback);
        }
    ],
    
    getOptions: function ()
    {
        var d = $("#widget-calendar").fullCalendar('getDate');

        var opts = {
            Year: d.getFullYear(),
            Month: d.getMonth() + 1,
            Day: d.getDate() + 1,
            CurrentView: $("#widget-calendar").fullCalendar('getView').name,
            ShowStart: $("#IncStartDate").is(":checked"),
            ShowDue: $("#IncDueDate").is(":checked"),
            ShowDuration: $("#IncGantt").is(":checked"),
            ColorMode: $("#ColorBySelected").val()
        };
        
        return JSON.stringify(opts);
    },
    executeCalendarFilter: function () {
        $("#widget-calendar").fullCalendar('removeEventSource', gemini_activity.calendarSources[0]);
        $("#widget-calendar").fullCalendar('removeEventSource', gemini_activity.calendarSources[1]);
        $("#widget-calendar").fullCalendar('removeEventSource', gemini_activity.calendarSources[2]);
        $("#widget-calendar").fullCalendar('addEventSource', gemini_activity.calendarSources[gemini_activity.currentCalendarIndex]);
  //      gemini_activity.amendSource(gemini_activity.currentCalendarChecked, gemini_activity.currentCalendarIndex);
    }
};