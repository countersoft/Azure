var gemini_filter = {
    pageType: 0,
    dropZoneIndex: 0,
    rowDragIndex: 0,
    currentExecuteRequest: null,
    executeEndPoint: null,
    executeData: null,
    refreshTable: null,
    init: function (pageType) {
        gemini_filter.pageType = pageType;
        
        $("#items-filter .header,#items-filter .label,#items-filter .icon").disableSelection();

        //$('.filter-changer', '#items-filter').live('change', function () {
        $('#items-filter').on('change', '.filter-changer', function () {
            gemini_filter.resetFilterBoxes(this);
            gemini_filter.executeFilter();
        });
        
        $(document).on('click', "#grid-import-data", function (e) {
            $("#cs-popup-center-content").css("width", "800px");
            $("#cs-popup-center-content").css("height", "380px");
            
            gemini_popup.centerPopup(csVars.ProjectUrl + "items/importdatap", "popup");
        });
        
        
        var fieldLimits = $("#filter-limit", '#items-filter');
        if (parseInt(fieldLimits.val()) > parseInt(fieldLimits.attr('data-filterlimit'))) {
            $("#filter-project-specific .custom-filter").hide();
        }
        
        $(document).on('click', "#expand-collapse-filter", function (e) {
            e.preventDefault();

            if ($("#filter-project-specific .custom-filter").is(":visible")) {
                $("#filter-project-specific .custom-filter").hide();
            }
            else {
                $("#filter-project-specific .custom-filter").show();
            }
        });
        
        $('.project-filter').change(function () {
            gemini_filter.resetFilterBoxes(this);
            $.ajax({
                type: "POST",
                url: csVars.Url + csVars.ProjectUrl + 'items/filteredprojectchanged',
                data: $('#filter-form').serialize(),
                success: function (response) {
                    if (response.Success) {
                        $('#filter-project-specific').html(response.Result.Data);
                        gemini_items.resizeMainItemsGrid();
                        $(".filter-data", '#filter-project-specific').each(function (index) {
                            gemini_filter.dismissFilterPopop(this, $(this).parent());
                        });
                        gemini_filter.attachDatePickers();
                        gemini_filter.executeFilter();
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                }
            });
        });

        //$("#items-filter .header,#items-filter .label,#items-filter .icon").live("click", function (e) {
        $("#items-filter").on("click", ".header, .label, .icon", function (e) {
            var _this = $(this);
            if (_this.hasClass('icon')) {
                _this = $(_this.prev('div'));
            }

            if (_this.hasClass(".filter-data")) return;

            var parent = _this.parent();
            var dataBox = parent.find(".filter-data");

            if ($(dataBox).is(":visible")) {
                gemini_filter.dismissFilterPopop(dataBox, parent);
                if (_this.hasClass('filter-changer-text')) {
                    gemini_filter.executeFilter();
                }
                gemini_keyboard.unbindEscape("#items-filter li.selected .header");
            }
            else {
                $(".filter-data:visible").each(function (index) {
                    gemini_filter.dismissFilterPopop(this, $(this).parent());
                });

                $(dataBox).slideDown('fast', function () { $(dataBox).jScrollPane({}); });
                parent.addClass("selected");
                gemini_keyboard.bindEscape('#items-filter li.selected .header', gemini_filter.EscapeDropdowns);
            }

            parent.find(".icon").toggleClass("fonticon-tick");
            parent.find(".icon").toggleClass("fonticon-arrow-down");
        });

        $(".filter-data").each(function (index) {
            gemini_filter.dismissFilterPopop(this, $(this).parent());
        });

        $('#data').on('click', '#pager-next', function () {
            var currentPage = $('#pager-next').data('page');
            gemini_filter.getFilteredItemsPage(currentPage);
        });

        $('#data').on('click', '#pager-prev', function () {
            var currentPage = $('#pager-prev').data('page') - 2;
            if(currentPage >= 0) gemini_filter.getFilteredItemsPage(currentPage);
        });

        if (gemini_filter.pageType != 2) {
            gemini_filter.initDataTable();
        }

        gemini_ui.userAutocomplete("#ReportedBy");
        gemini_ui.userAutocomplete("#WatchedBy");
        
        gemini_filter.attachDatePickers();
        gemini_filter.bindFilterShowHide();
        gemini_filter.bindExportToShowHide();

    },
    
    EscapeDropdowns: function (guid, selector) {
        if (selector == "#items-filter li.selected .header") {
            $(selector).click();
        }
        else {
            $(selector).fadeOut('fast');            
        }
        gemini_keyboard.unbindEscape(selector);
    },
    
    bindExportToShowHide: function () {

        $(document).on('click', ".export-to-container a", function (e) {
            $(".export-to-container").hide();
            gemini_keyboard.unbindEscape(".export-to-container");
        });
        
        $(document).on('click', "#grid-export-excel", function (e) {

            if ($(".export-to-container").is(":visible")) {
                //$(".export-to-container").hide();
                $(".export-to-container").fadeOut('fast');
                gemini_keyboard.unbindEscape(".export-to-container");

            } else {
                //$(".export-to-container").show();
                $(".export-to-container").slideDown('fast');
                $(".export-to-container").position({
                    "my": "right top",
                    "my": "right top",
                    "at": "right bottom",
                    "of": $("#grid-export-excel"),
                    "offset": "0 6",
                    "collision": "none"
                });
                gemini_keyboard.bindEscape(".export-to-container", gemini_filter.EscapeDropdowns);

            }
        });
    },
    
    bindFilterShowHide: function ()
    {
        if ($("#items-filter").is(':visible')) {
            $("#page-options-box .filterdown").hide();
        }
        else {
            $("#page-options-box .filterup").hide();
        }

        $("#page-options-box .filterup").click(function () { //hide
           $(this).hide();
            $("#column-picker").fadeOut('fast');
            $("#page-options-box .filterdown").show();

            $("#filter-container").removeClass("filter-width");
       
            //$("#items-filter").fadeOut(600, function () { $(window).trigger("resize"); });
            if ($('.filter-container').length > 0)
            {
                $("#items-filter").parents('td:eq(0)').hide();
                $(window).trigger("resize");
            }
            else
                $("#items-filter").parent().hide();
            

            //$(window).trigger("resize");

            $("#header").slideUp(600);
            $("#top-right-box").slideUp(600);
            $("#data.items-data-container").addClass('width-100');
        });

        $("#page-options-box .filterdown").click(function () { //show
            $(this).hide();
            $("#data.items-data-container").removeClass('width-100');
            $("#column-picker").fadeOut('fast');
            $("#page-options-box .filterup").show();

            $("#filter-container").addClass("filter-width");
            //$("#items-filter").fadeIn(600, function () { $(window).trigger("resize"); });
            if ($('.filter-container').length > 0)
                $("#items-filter").parents('td:eq(0)').show();
            else
                $("#items-filter").parent().show();
            
            $("#header").slideDown(600);
       
            $("#top-right-box").slideDown(600);

            if ($('#pager-next').length > 0) {
                setTimeout(function() { $(window).trigger("resize"); }, 50);
                $(window).trigger("resize");
            }

            // else 
               // $(window).trigger("resize");         
        });
    },
    
    resetFilterBoxes: function (current) {
        if ($(current).is('input') && $(current).attr('type') == 'checkbox') {
            if ($(current).parent().index() == 0 && !$(current).hasClass('options-filter')) {
                if ($(current).is(':checked')) {
                    $(current).parent().parent().find('input[type="checkbox"]:not(:first)').attr('checked', false);
                }
            }
            else {
                var any = $(current).parent().parent().find('input[type="checkbox"]:first');
                if (!$(any).hasClass('options-filter')) {
                    $(any).attr('checked', false);
                }
            }
        }
    },
    
    attachDatePickers: function () {
        gemini_ui.datePicker('#filter-form #CreatedFrom');
        gemini_ui.datePicker('#filter-form #CreatedTo');
        gemini_ui.datePicker('#filter-form #RevisedFrom');
        gemini_ui.datePicker('#filter-form #RevisedTo');
        gemini_ui.datePicker('#filter-form #ClosedFrom');
        gemini_ui.datePicker('#filter-form #ClosedTo');
        gemini_ui.datePicker('#filter-form #ResolvedFrom');
        gemini_ui.datePicker('#filter-form #ResolvedTo');
        gemini_ui.datePicker('#filter-form #StartFrom');
        gemini_ui.datePicker('#filter-form #StartTo');
        gemini_ui.datePicker('#filter-form #DueFrom');
        gemini_ui.datePicker('#filter-form #DueTo');
    },
    
    initDataTable: function () {
        var x = $('#tabledata').dataTable(
        {
            bFilter: false,
            bPaginate: false,
            bInfo: false,
            "aaSorting": [],
            fnSortCallback: gemini_filter.sortColumn,
            sDom: 'Rlfrtip',
            "oColReorder": {
                //"iFixedColumns": $('#tabledata').find('thead').find('tr')[0].cells.length,
                "fnColReorderCallback": function (x, y) {
                    if (x == y) return;
                    var xProperty = $($('#tabledata').find('thead').find('tr')[0].cells[x]).data('id');
                    var yProperty = $($('#tabledata').find('thead').find('tr')[0].cells[y]).data('id');
                    $.ajax({
                        type: "POST",
                        url: csVars.Url + csVars.ProjectUrl + 'items/reordercolumns/' + gemini_filter.pageType,
                        data: {
                            from: xProperty,
                            to: yProperty
                        },
                        success: function (response) {
                            if (response.Success) {
                                if (gemini_filter.refreshTable != null) {
                                    gemini_filter.executeFilter();
                                } else {
                                    var currentPage = $('#pager-next').data('page');
                                    gemini_filter.getFilteredItemsPage(currentPage - 1);
                                }
                            }
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                        }
                    });
                }
            }
        });

        gemini_filter.initTableDnD();

        var sort = $('#Sort').val().split('|');
        var i = 0;
        var data = [];
        for (i = 0; i < sort.length; i += 2) {
            if (sort[i] != '') {
                var col = $('#tabledata').find('[data-id="' + sort[i] + '"]');
                if (col.length > 0) data.push([col.index(), sort[i + 1] == 0 ? 0 : 1]);
            }
        }
        x.fnSetSort(data);

        $('#tabledata').on('click', '.parent', function (e) {
            gemini_commons.stopClick(e);
            if ($(this).hasClass('fonticon-arrow-down')) {
                gemini_ajax.postCall(csVars.ProjectUrl + 'items/' + $(this).parent().parent().data('issue-id'), 'fetchdependants', gemini_filter.showDependants, null, $('#filter-form').serialize());
                $(this).removeClass('fonticon-arrow-down');
                $(this).addClass('fonticon-arrow-up');
            }
            else {

                var nextTr = $(this).parent().parent().next();
                while ($(nextTr).hasClass('dependant')) {
                    var current = nextTr;
                    nextTr = $(nextTr).next();
                    $(current).remove();

                }

                $(this).removeClass('fonticon-arrow-up');
                $(this).addClass('fonticon-arrow-down');
            }
        });

        gemini_items.bindContextMenu();
    },
    
    initTableDnD: function () {
        $('#tabledata').tableDnD({
            dragHandle: ".dragHandle",
            onDrop: function (table, row) {
                var dropZoneIndex = $('.drop-zone').index();
                if (dropZoneIndex < row.rowIndex && gemini_filter.rowDragIndex > row.rowIndex) {
                    return;
                }
                //alert('issue id: ' + $(row).data('issue-id')+ ' moved to ' + row.rowIndex + ' from ' + gemini_filter.rowDragIndex);
                if (dropZoneIndex < row.rowIndex) {
                    $('.dragHandle', row).addClass('item-drag-handle');
                    $('.dragHandle', row).removeClass('item-drag-handle-selected');
                }
                else {
                    $('.dragHandle', row).addClass('item-drag-handle-selected');
                    $('.dragHandle', row).removeClass('item-drag-handle');
                }
                $.ajax({
                    type: "POST",
                    url: csVars.Url + csVars.ProjectUrl + 'items/resequence',
                    data: {
                        issueId: $(row).data('issue-id'),
                        afterIssueId: row.rowIndex == 1 || dropZoneIndex < row.rowIndex ? 0 : $(table.rows[row.rowIndex - 1]).data('issue-id'),
                        newIndex: dropZoneIndex < row.rowIndex ? -1 : row.rowIndex - 1,
                        oldIndex: gemini_filter.rowDragIndex - 1
                    },
                    success: function (response) {
                        if (response.Success) {

                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                    }
                });
            },
            onDragStart: function (table, row) {
                gemini_filter.rowDragIndex = row.parentNode.parentNode.rowIndex;
                $('.dependant', '#tabledata').remove();
            },
            onDragClass: 'highlight-hover'
            /*onAllowDrop: function(draggedRow, dropTargetRow) {
            return $(dropTargetRow).hasClass('item-ordered');
            }*/
        });
    },
    
    showDependants: function (response) {
        $('#tr-issue-' + response.Result.IssueId).after(response.Result.Dependants);
        $("tr[id^='tr-issue-'] td", '#tabledata').destroyContextMenu();
        gemini_items.bindContextMenu();
    },
    
    getFilteredItemsCurrentPage: function () {
        gemini_filter.getFilteredItemsPage($('#pager-next').data('page') - 1);
    },
    
    getFilteredItemsPage: function (page) {
        if (gemini_filter.currentExecuteRequest != null) {
            return;
        }
        $('#items-grid').css('opacity', '0.6');
        gemini_filter.currentExecuteRequest = $.ajax({
            type: "POST",
            url: csVars.Url + csVars.ProjectUrl + 'items/' + page + '?card=' + gemini_appnav.pageCard.Id,
            data: $('#filter-form').serialize(),
            success: function (response) {
                gemini_filter.currentExecuteRequest = null;
                if (response.Success) {
                    $('#pager-next').data('page', response.Result.CurrentPage);
                    $('#pager-prev').data('page', response.Result.CurrentPage);
                    $('#data').html(response.Result.Data);
                    gemini_filter.initDataTable();
                    gemini_filter.bindFilterShowHide();
                }
                $('#items-grid').css('opacity', '1');

            },
            error: function (xhr, ajaxOptions, thrownError) {
                $('#items-grid').css('opacity', '1');

                gemini_filter.currentExecuteRequest = null;
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
            }
        });
    },
    
    dismissFilterPopop: function (dataBox, parent) {
        var selected = "";
        var encode = false;
        $(dataBox).find("input:checked").each(function (index) {
            selected += $(this).parent().find("label").attr("title");
            selected += ", ";
        });

        if (selected.length > 0) {
            selected = selected.substring(0, selected.lastIndexOf(","));
        }
        else {
            $(dataBox).find("input[type=text]").each(function (index) {

                if ($(this).val().length) {
                    selected += $(this).val();
                    selected += ", ";
                }
            });


            if (selected.length > 0) {
                encode = true;
                selected = selected.substring(0, selected.lastIndexOf(","));
            }
        }

        if (encode) selected = gemini_commons.htmlEncode(selected);

        if (selected.length == 0) {
            parent.find(".label").attr("title", "");
            parent.find(".label").html("&nbsp;");
        }
        else {
            parent.find(".label").attr("title", selected);
            parent.find(".label").html(selected);
        }

        $(dataBox).fadeOut('fast');

        parent.removeClass("selected");
    },
    
    sortColumn: function (options) {
        var i;
        var sort = '';
        for (i = 0; i < options.aaSorting.length; i++) {
            if (sort + options.aoColumns[options.aaSorting[i][0]].sGeminiId == '0') return;
            sort = sort + options.aoColumns[options.aaSorting[i][0]].sGeminiId + '|' + options.aaSorting[i][2] + '|';
        }

        $('#Sort').val(sort);

        gemini_filter.executeFilter();
    },
    
    executeFilter: function ()
    {
        if (gemini_filter.currentExecuteRequest != null) {
            gemini_filter.currentExecuteRequest.abort();
        }

        $('#contents').toggleClass('cursor-busy');
        $('#items-grid').css('opacity', '0.6');
        var endPoint = 'items/executefilter';
        
        if (gemini_filter.executeEndPoint != null) endPoint = gemini_filter.executeEndPoint;

        if (endPoint.indexOf('?') != -1) {
            endPoint = endPoint + '&card=' + gemini_appnav.pageCard.Id;
        }
        else {
            endPoint = endPoint + '?card=' + gemini_appnav.pageCard.Id;
        }

        var data;
        if(gemini_filter.pageType == gemini_commons.PAGE_TYPE.Items)
        {
            data = gemini_filter.executeData == null ? $('#filter-form').serialize()+'&'+$('#pageSize').serialize() : gemini_filter.executeData();
        }
        else 
        {
            data = gemini_filter.executeData == null ? $('#filter-form').serialize() : gemini_filter.executeData();
        }

        gemini_filter.currentExecuteRequest = $.ajax({
            type: "POST",
            url: csVars.Url + csVars.ProjectUrl + endPoint,
            data: data,
            success: function (response) {
                gemini_filter.currentExecuteRequest = null;
                if (response.Success) {
                    $('#contents').toggleClass('cursor-busy');

                    if (gemini_filter.pageType == gemini_commons.PAGE_TYPE.Planner) {
                        //endPoint = '/planner/executefilter';
                        planner.saveData();
                        return;
                    }
                    else {
                        if (gemini_filter.refreshTable == null) {
                            $('#data').html(response.Result.Data);
                            gemini_filter.bindFilterShowHide();
                        }
                        else {
                            gemini_filter.refreshTable(response.Result.Data);
                        }
                        gemini_filter.initDataTable();
                        gemini_items.resizeMainItemsGrid();
                    }
                    if (response.Result.SavedCard != null) {
                        gemini_appnav.pageCard.Options = response.Result.SavedCard.Options;
                    }
                }
                else {
                    $('#items-grid').css('opacity', '1');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                gemini_filter.currentExecuteRequest = null;
                $('#contents').toggleClass('cursor-busy');
                $('#items-grid').css('opacity', '1');
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
            }
        });
    },
    
    gridColumnPickerInit: function (refreshCallback) {

       /* $("#column-picker").position({
            "of": $("#grid-column-picker"),
            "my": "right top",
            "at": "right bottom",
            "offset": "0 8",
            "collision": "none"
        });*/

        $("#column-picker-list").jScrollPane({ autoReinitialise: true, autoReinitialiseDelay: 250 });

        $('#grid-column-picker').click(function () {

            if ($("#column-picker").is(":visible")) {
                $("#column-picker").fadeOut('fast');
                //$("#grid-column-picker").addClass('fonticon-arrow-down');
                //$("#grid-column-picker").removeClass('fonticon-arrow-up');
                gemini_keyboard.unbindEscape("#column-picker");
            }
            else {
                $.ajax({
                    type: "GET",
                    url: csVars.Url + csVars.ProjectUrl + 'items/getcolumns/' + gemini_filter.pageType,
                    success: function (response) {
                        if (response.Success) {
        
                            /*$("#column-picker").position({
                                "of": $("#grid-column-picker"),
                                "my": "right top",
                                "at": "right bottom",
                                "offset": "0 8",
                                "collision": "none"
                            });*/

                            $("#column-picker").css({
                                top: $("#grid-column-picker").position().top + $("#grid-column-picker").height() + 8,
                                left: $("#grid-column-picker").position().left - 225
                            });

                            
                            
                            $('#column-picker').html(response.Result.Data);
            
                            //$("#grid-column-picker").addClass('fonticon-arrow-up');
                            //$("#grid-column-picker").removeClass('fonticon-arrow-down');
                            $("#column-picker").slideDown('fast');

                            $('#colmun-picker-submit').click(function () {
                                $("#column-picker").fadeOut('fast');
                                //$("#grid-column-picker").addClass('fonticon-arrow-down');
                                //$("#grid-column-picker").removeClass('fonticon-arrow-up');
                                gemini_ui.startBusy('#column-picker #colmun-picker-submit');
                                $.ajax({
                                    type: "POST",
                                    url: csVars.Url + csVars.ProjectUrl + 'items/setcolumns/' + gemini_filter.pageType,
                                    data: $('#column-picker-form').serialize(),
                                    success: function (response) {
                                        if (response.Success) {
                                            if (refreshCallback) {
                                                refreshCallback();
                                            }
                                            else {
                                                var currentPage = $('#pager-next').data('page') - 1;
                                                gemini_filter.getFilteredItemsPage(currentPage);
                                            }
                                     
                                        }
                                        gemini_ui.stopBusy('#column-picker #colmun-picker-submit');
                                    },
                                    error: function (xhr, ajaxOptions, thrownError) {
                                        gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                                        gemini_ui.stopBusy('#column-picker #colmun-picker-submit');
                                    }
                                });

                            });

                            gemini_keyboard.bindEscape("#column-picker", gemini_filter.EscapeDropdowns);
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                    }
                });
            }
        });
    }
};

