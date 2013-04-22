gemini_progress = {

    init: function (versionId, versionLabel, currentUrl) {

        $(document).on('click', ".burndown .radio-check input[type='radio']", function (e) {             
            window.location.href = currentUrl + "progress/burndown/" + versionId + "/" + $("#days").val() + "/" + $(this).val() + "?card=" + gemini_appnav.pageCard.Id;
        });
        $(document).on('change', ".burndown #days", function (e) {
            window.location.href = currentUrl + "progress/burndown/" + versionId + "/" + $("#days").val() + "/" + $("#burndown-form .radio-check input[type='radio']:checked").val() + "?card=" + gemini_appnav.pageCard.Id;
        });
    },
    burddownChart: function (translation,burndownCategory,burndownOpenData,burndownCreatedData,burndownIdealLine) {
        burddownChart = new Highcharts.Chart({
            colors: ['#A00000', '#20AA00', '#000000'],
            chart: {
                renderTo: 'burndown',
                type: 'column'
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: burndownCategory,
                labels: { align: 'right', rotation: -90 }
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
                x: -100,
                verticalAlign: 'top',
                y: 20,
                floating: true,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.x + '</b><br/>' +
                        this.series.name + ': ' + Math.floor(this.y) + '<br/>' + (this.series.name == 'Ideal' ? '' :
                        translation.Total + this.point.stackTotal);
                }
            },
            plotOptions: {
                column: {
                    stacking: 'normal'/*,
                    pointWidth: 20*/
                }
            },
            series: [{
                name: translation.Created,
                data: burndownCreatedData
            }, {
                name: translation.Open,
                data: burndownOpenData
            }, {
                type: 'spline',
                name: 'Ideal',
                data: burndownIdealLine
            }
            ]
        });
    },
    burdupChart: function (translation, burnupCategory, burnupTotalData, burnupClosedData) {
        burdupChart = new Highcharts.Chart({
            colors: ['#A00000','#20AA00', '#000000'],
            chart: {
                renderTo: 'burnup',
                type: 'line'
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: burnupCategory,
                labels: { align: 'right',rotation: -90 }
            },
            yAxis: {
                min: 0,
                title: {
                    text: translation.Items
                }
            },
            legend: {
                align: 'right',
                x: -100,
                verticalAlign: 'top',
                y: 20,
                floating: true,
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.x +'</b><br/>'+
                        this.series.name +': '+ this.y +'<br/>';
                }
            },
            series: [{
                name: translation.Total,
                data: burnupTotalData
            }, {
                name: translation.Closed,
                data: burnupClosedData
            }]
        });
    },
    chart: function (categories, issueTotal, data) {

        var yData = [];

        $(data).each(function () {
            yData.push({ y: this.Second, url: this.Third });
        });

        var background = 'transparent';
        if (csVars.IEVersion >= 7 && csVars.IEVersion < 9) {
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
    minutes: function(days, hours, mins)    {
        return ((days*8)+hours)*60+mins;
    },
    deltaString: function(min)   {
        mins = Math.abs(min);
        hours = (mins > 60) ? Math.floor(mins/60) : 0;
        mins -= (hours*60);
        
        // populate the screen
        $('.delta-hours').text(hours+'h');
        $('.delta-minutes').text(mins+'m');
    },    
    showDelta: function(remain)
    {   
        delta    = remain;

        if (delta > 0)
            $('.delta').removeClass("behind ahead").addClass("ahead");
        else
            $('.delta').removeClass("behind ahead").addClass("behind");
        
        gemini_progress.deltaString(delta);
    },
    showDays: function (Estimated, Logged)
    {
        $('.days-est').text(Math.floor(Estimated / 60)+ 'h ' + Math.floor(Estimated%60)+'m');
        $('.days-cpt').text(Math.floor(Logged / 60)+ 'h ' + Math.floor(Logged%60)+'m');
        //$('.days-rem').text(@(Model.Remain / 60)+ 'h ' + @(Model.Remain%60)+'m');
    },
    showCompleteness: function (completeness)
    {
        gemini_ui.tinyPercent('#statusbar .tinyProgress', Math.floor(completeness), '#0B0', '#4c4c4c', 500, 0, 0, 50 );
    },
    showGrid: function (ProjectTemplatePageType, versionId, executeEndPoint)
    {
        gemini_filter.executeEndPoint = executeEndPoint;
        gemini_filter.executeData = function () {
            return $('#Sort').val();
        };
        gemini_filter.refreshTable = function(result) {
            $('#progress-items-table').html(result);
            $('#items-grid').css('opacity', '1');
        };
        gemini_filter.init(ProjectTemplatePageType);
        gemini_edit.initEdit(0, ProjectTemplatePageType, '#cs-popup', '#cs-popup-content', '#data', gemini_items.refreshRow);

        gemini_filter.gridColumnPickerInit(function () {
            var endPoing = "getroadmap";
            if (ProjectTemplatePageType == gemini_commons.PAGE_TYPE.Changelog) endPoing = "getchangelog";
            gemini_ajax.call(csVars.ProjectUrl + "progress", endPoing, function (response) { if (response.Success) {
                $('#progress-items-table').html(response.Result.Data); 
                gemini_filter.initDataTable();           
            } }, null, {id: versionId});
        });
    }

};