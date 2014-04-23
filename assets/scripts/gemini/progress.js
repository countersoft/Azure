gemini_progress = {

    init: function (versionId, versionLabel, currentUrl) {
     
        $(document).on('ifChecked', ".burndown .radio-check input[type='radio']", function (e) {           
            gemini_progress.executeFilter();
        });
        $(document).on('change', ".burndown #days", function (e) {            
            gemini_progress.executeFilter();
        });

    },
    initInlineEditing: function ()
    {
        $('#contents').on('click', '#tabledata tr:not(.drop-zone) td:not(:first-child):not(.read-only):not(.edit-mode)', function (e) {
         
            //Making sure the edit doesn't get invoked when clicking on link
            if (!$(e.target).is('a')) {
                gemini_edit.initEditing($(this), true);
            }
        });
    },
    burndownChart: function (translation, burndownCategory, burndownOpenData, burndownCreatedData, burndownIdealLine, burndownTrendLine) {
        burndownChart = new Highcharts.Chart({
            colors: ['#20AA00', '#A00000', '#000000', '#20AA00'],
            chart: {
                renderTo: 'burndown',
                type: 'area'
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: burndownCategory,
                labels: {
                    rotation: -90,
                    align: 'right',
                    style: {
                        fontSize: '12px'
                    }
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: translation.Items
                },
                stackLabels: {
                    /*enabled: true,
                    style: {
                        fontWeight: 'bold',
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                    }*/
                }
            },
            legend: {
                align: 'right',
                x: -210,
                verticalAlign: 'top',
                y: 0,
                floating: true,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.x + '</b><br/>' +
                        this.series.name + ': ' + (this.series.name == 'Ideal' ? Math.ceil(this.y) : this.y) + '<br/>' + (this.series.name == 'Ideal' || this.series.name == 'Trend' ? '' :
                        translation.Total + ': ' + this.point.stackTotal);
                }
            },
            plotOptions: {
                area: {
                    stacking: 'normal',/*,
                    pointWidth: 20*/
                    marker: {
                        enabled: true,
                        symbol: 'circle',
                        radius: 0,
                        states: {
                            hover: {
                                enabled: true,
                                radius: 4
                            }
                        }
                    }
                }
            },
            series: [{
                name: translation.Open,
                data: burndownOpenData
            },
            {
                name: translation.Created,
                data: burndownCreatedData
            },
            {
                type: 'spline',
                name: 'Ideal',
                data: burndownIdealLine,
                marker: {
                    enabled: true,
                    symbol: 'circle',
                    radius: 0,
                    states: {
                        hover: {
                            enabled: true,
                            radius: 4
                        }
                    }
                }
            },
            {
                type: 'spline',
                name: 'Trend',
                data: burndownTrendLine,
                dashStyle: 'dot',
                marker: {
                    enabled: true,
                    symbol: 'circle',
                    radius: 0,
                    states: {
                        hover: {
                            enabled: true,
                            radius: 4
                        }
                    }
                }
            }
            ]
        });
    },
    burndownChartDashboard: function (translation, burndownCategory, burndownOpenData, burndownCreatedData, burndownIdealLine, burndownTrendLine) {
        burndownChart = new Highcharts.Chart({
            colors: ['#20AA00', '#A00000', '#000000', '#20AA00'],
            chart: {
                renderTo: 'burndownMetric',
                backgroundColor: '#e4e9f4',
                type: 'area'
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: burndownCategory,
                lineWidth: 1,
                minorTickLength: 0,
                tickLength: 0,
                labels: { align: 'right', rotation: -90, enabled: false } // enabled = false SAAR
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''//translation.Items SAAR
                },
                labels : {           
                    style: {
                        color: "#888888"
                    }
                },
                gridLineWidth: 0,
                lineWidth:1,
                minorTickLength: 0,
                tickLength: 0
            },
            legend: {
                align: 'right',
                x: -210,
                verticalAlign: 'top',
                y: 0,
                floating: true,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false,
                enabled: false // enabled= false SAAR
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.x + '</b><br/>' +
                        this.series.name + ': ' + (this.series.name == 'Ideal' ? Math.ceil(this.y) : this.y) + '<br/>' + (this.series.name == 'Ideal' || this.series.name == 'Trend' ? '' :
                        translation.Total + ': ' + this.point.stackTotal);
                }
            },
            plotOptions: {
                area: {
                    stacking: 'normal',/*,
                    pointWidth: 20*/
                    marker: {
                        enabled: true,
                        symbol: 'circle',
                        radius: 0,
                        states: {
                            hover: {
                                enabled: true,
                                radius: 4
                            }
                        }
                    }
                }
            },
            exporting: {
                enabled:false
            },
            series: [{
                name: translation.Open,
                data: burndownOpenData
            },
            {
                name: translation.Created,
                data: burndownCreatedData
            },
            {
                type: 'spline',
                name: 'Ideal',
                data: burndownIdealLine,
                marker: {
                    enabled: true,
                    symbol: 'circle',
                    radius: 0,
                    states: {
                        hover: {
                            enabled: true,
                            radius: 4
                        }
                    }
                }
            },
            {
                type: 'spline',
                name: 'Trend',
                data: burndownTrendLine,
                dashStyle: 'dot',
                marker: {
                    enabled: true,
                    symbol: 'circle',
                    radius: 0,
                    states: {
                        hover: {
                            enabled: true,
                            radius: 4
                        }
                    }
                }
            }
            ]
        });
    },
    burnupChart: function (translation, burnupCategory, burnupTotalData, burnupClosedData, burnupTrendLine) {
        burnupChart = new Highcharts.Chart({
            colors: ['#A00000', '#20AA00', '#20AA00'],
            chart: {
                renderTo: 'burnup',
                type: 'line'
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: burnupCategory,
                labels: {
                    align: 'right',
                    rotation: -90,
                    style: {
                        fontSize: '12px'
                    }
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: translation.Items
                }
            },
            legend: {
                align: 'right',
                x: -240,
                verticalAlign: 'top',
                y: 0,
                floating: true,
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.x + '</b><br/>' +
                        this.series.name + ': ' + this.y + '<br/>';
                }
            },
            plotOptions: {
                series: {                    
                    marker: {
                        enabled: true,
                        symbol: 'circle',
                        radius: 0,
                        states: {
                            hover: {
                                enabled: true,
                                radius: 4
                            }
                        }
                    }
                }
            },
            series: [{
                name: translation.Total,
                data: burnupTotalData
            }, {
                name: translation.Closed,
                data: burnupClosedData
            },
            {
                type: 'spline',
                name: 'Trend',
                data: burnupTrendLine,
                dashStyle: 'dot',
                marker: {
                    enabled: true,
                    symbol: 'circle',
                    radius: 0,
                    states: {
                        hover: {
                            enabled: true,
                            radius: 4
                        }
                    }
                }
            }]
        });
    },
    burnupChartDashboard: function (translation, burnupCategory, burnupTotalData, burnupClosedData, burnupTrendLine) {
        burnupChart = new Highcharts.Chart({
            colors: ['#A00000', '#20AA00', '#20AA00'],
            chart: {
                renderTo: 'burnupMetric',
                backgroundColor: '#e4e9f4',
                type: 'line'
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: burnupCategory,
                lineWidth: 1,
                minorTickLength: 0,
                tickLength: 0,
                labels: { align: 'right', rotation: -90, enabled: false }
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
                },
                labels: {
                    style: {
                        color: "#888888"
                    }
                },
                gridLineWidth: 0,
                lineWidth: 1,
                minorTickLength: 0,
                tickLength: 0
            },
            legend: {
                align: 'right',
                x: -240,
                verticalAlign: 'top',
                y: 0,
                floating: true,
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false,
                enabled: false
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.x + '</b><br/>' +
                        this.series.name + ': ' + this.y + '<br/>';
                }
            },
            plotOptions: {
                series: {
                    marker: {
                        enabled: true,
                        symbol: 'circle',
                        radius: 0,
                        states: {
                            hover: {
                                enabled: true,
                                radius: 4
                            }
                        }
                    }
                }
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: translation.Total,
                data: burnupTotalData
            }, {
                name: translation.Closed,
                data: burnupClosedData
            },
            {
                type: 'spline',
                name: 'Trend',
                data: burnupTrendLine,
                dashStyle: 'dot',
                marker: {
                    enabled: true,
                    symbol: 'circle',
                    radius: 0,
                    states: {
                        hover: {
                            enabled: true,
                            radius: 4
                        }
                    }
                }
            }]
        });
    },
    velocityChart: function (translation, velocityCategory, velocityTotalData, velocityTrendLine) {
        velocityChart = new Highcharts.Chart({
            colors: ['#20AA00', '#A00000'],
            chart: {
                renderTo: 'velocity',
                type: 'column'
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: velocityCategory,
                labels: {
                    align: 'right',
                    rotation: -90,
                    style: {
                        fontSize: '12px'
                    }
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: translation.Items
                },
                plotLines: [{
                    value: velocityTrendLine[0],
                    color: '#A00000',
                    width: 3,
                    zIndex: 7,
                    label: {
                        text: 'Average Velocity (' + velocityTrendLine[0] + ')',
                        align: 'center',
                        style: {
                            color: 'black'
                        }
                    }
                }]
            },
            legend: {
                align: 'right',
                x: -240,
                verticalAlign: 'top',
                y: 0,
                floating: true,
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.x + '</b><br/>' +
                        this.series.name + ': ' + this.y + '<br/>';
                }
            },
            plotOptions: {
                series: {                    
                    marker: {
                        enabled: true,
                        symbol: 'circle',
                        radius: 0,
                        states: {
                            hover: {
                                enabled: true,
                                radius: 4
                            }
                        }
                    }
                }
            },
            series: [{
                name: translation.Closed,
                data: velocityTotalData
            }]
        });
    },
    velocityChartDashboard: function (translation, velocityCategory, velocityTotalData, velocityTrendLine) {
        velocityChart = new Highcharts.Chart({
            colors: ['#20AA00', '#A00000'],
            chart: {
                renderTo: 'velocityMetric',
                backgroundColor: '#e4e9f4',
                type: 'column'
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: velocityCategory,
                lineWidth: 1,
                minorTickLength: 0,
                tickLength: 0,
                labels: { align: 'right', rotation: -90, enabled:false }
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
                },
                labels: {
                    style: {
                        color: "#888888"
                    }
                },
                gridLineWidth: 0,
                lineWidth: 1,
                minorTickLength: 0,
                tickLength: 0,
                plotLines: [{
                    value: velocityTrendLine[0],
                    color: '#A00000',
                    width: 1,
                    zIndex: 7,
                    label: {
                        text: 'Average Velocity (' + velocityTrendLine[0] + ')',
                        align: 'center',
                        style: {
                            color: 'black'
                        }
                    }
                }]
            },
            legend: {
                align: 'right',
                x: -240,
                verticalAlign: 'top',
                y: 0,
                floating: true,
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false,
                enabled:false
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.x + '</b><br/>' +
                        this.series.name + ': ' + this.y + '<br/>';
                }
            },
            plotOptions: {
                series: {
                    marker: {
                        enabled: true,
                        symbol: 'circle',
                        radius: 0,
                        states: {
                            hover: {
                                enabled: true,
                                radius: 4
                            }
                        }
                    }
                }
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: translation.Closed,
                data: velocityTotalData
            }]
        });
    },
    chart: function (categories, issueTotal, data) {
        var yData = [];

        $(data).each(function () {
            yData.push({ y: this.Second, url: this.Third });
        });

        var background = 'transparent';
        if ((csVars.IEVersion >= 7 && csVars.IEVersion < 9) || csVars.IsOpera) {
            background = 'rgba(255,255,255,0.1)';
        }
        
        var chart = new Highcharts.Chart({
            chart: {
                backgroundColor: background,
                renderTo: 'status-breakdown',
                type: 'bar',
                marginLeft: 100,
                marginRight: 30
            },
            colors:["#63b6db"],
            title: {
                text: ''
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                labels: {
                    style: {
                        width: '100px' 
                    }
                },
                categories: categories,
                title: {
                    text: null
                }
                
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
                },
                labels: {
                    enabled: false
                },
                gridLineWidth: 0
            },
            tooltip: {
                formatter: function() {
                    return '' + this.y;
                }
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true,
                        formatter: function () {
                            return Math.floor(this.y * 100 / issueTotal) + "%";
                        }
                    }
                },
                series: {
                    cursor: 'pointer',
                    point: {
                        events: {
                            click: function () {
                                location.href = this.options.url;
                            }
                        }
                    }
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -100,
                y: 100,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true,
                itemWidth: 100
            },
            credits: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                data: yData
            }]
        });
    },
    minutes: function (days, hours, mins) {
        return ((days * 8) + hours) * 60 + mins;
    },
    deltaString: function (min) {
        mins = Math.abs(min);
        hours = (mins >= 60) ? Math.floor(mins / 60) : 0;
        mins -= (hours * 60);
  
        // populate the screen
        $('.days-remaining').text(gemini_progress.addLeadingZero(hours, 2) + 'h' + ' ' + gemini_progress.addLeadingZero(mins,2) + 'm');
 
    },
    showDelta: function (remain) {
        delta = remain;
        if (delta > 0)
            $('.delta').removeClass("behind ahead").addClass("ahead");
        else
            $('.delta').removeClass("behind ahead").addClass("behind");

        gemini_progress.deltaString(delta);
    },
    showDays: function (Estimated, Logged, TimeOverLogged) {
        $('.days-est').text(gemini_progress.addLeadingZero(Math.floor(Estimated / 60), 2) + 'h ' + gemini_progress.addLeadingZero(Math.floor(Estimated % 60), 2) + 'm');
        $('.days-cpt').text(gemini_progress.addLeadingZero(Math.floor(Logged / 60), 2) + 'h ' + gemini_progress.addLeadingZero(Math.floor(Logged % 60), 2) + 'm');
        $('.days-excess').text(gemini_progress.addLeadingZero(Math.floor(TimeOverLogged / 60), 2) + 'h ' + gemini_progress.addLeadingZero(Math.floor(TimeOverLogged % 60), 2) + 'm');

        //$('.days-rem').text(@(Model.Remain / 60)+ 'h ' + @(Model.Remain%60)+'m');
    },
    addLeadingZero: function (num, size) {
        var s = num + "";
        while (s.length < size) s = "0" + s;
        return s;
    },
    showCompleteness: function (completeness, id) {
        var elem = '#statusbar .tinyProgress';
        if (id) elem = id;
        gemini_ui.tinyPercent(elem, Math.floor(completeness), '#0B0', '#4c4c4c', 500, 0, 0, 50);
    },
    showGrid: function (ProjectTemplatePageType, versionId, executeEndPoint) {
        gemini_filter.executeEndPoint = executeEndPoint;
        gemini_filter.executeData = function () {
            return $('#Sort').val();
        };
        gemini_filter.refreshTable = function (result) {
            $('#progress-items-table').html(result);
            $('#items-grid').css('opacity', '1');
        };
        gemini_filter.init(ProjectTemplatePageType);
        gemini_edit.initEdit(0, ProjectTemplatePageType, '#cs-popup', '#cs-popup-content', '#data', gemini_items.refreshRow);

        gemini_filter.gridColumnPickerInit(function () {
            var endPoing = "getroadmap";
            if (ProjectTemplatePageType == gemini_commons.PAGE_TYPE.Changelog) endPoing = "getchangelog";
            gemini_ajax.call(csVars.ProjectUrl + "progress", endPoing, function (response) {
                if (response.Success) {
                    $('#progress-items-table').html(response.Result.Data);
                    gemini_filter.initDataTable();
                }
            }, null, { id: versionId });
        });
    },
    executeFilter: function (successCallback) {
        $('#progress').css('opacity',0.7);
        gemini_ajax.postCall('progress/burndown', 'filter',
        function (response) {
            if (response.success) {
                $('#progress').html(response.Result.Data.Data);
                gemini_appnav.pageCard.Options['Burndown'] = response.Result.Data.SavedCard.Options['Burndown'];
                gemini_ui.chosen('#days');
                gemini_ui.fancyInputs('#burndown-form .fancy');
                if (successCallback) eval(successCallback);
            }
            $('#progress').css('opacity', 1);

        }, function () { $('#progress').css('opacity', 1); }, { filterForm: $('#filter-form').serialize(), progressFilter: $('#burndown-form').serialize()});
    }

};