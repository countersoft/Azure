if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (elt /*, from*/) {
        var len = this.length >>> 0;

        var from = Number(arguments[1]) || 0;
        from = (from < 0)
             ? Math.ceil(from)
             : Math.floor(from);
        if (from < 0)
            from += len;

        for (; from < len; from++) {
            if (from in this &&
                this[from] === elt)
                return from;
        }
        return -1;
    };
}
gemini_filter = {
    wizardBoxAdded: false,
    wizrdBoxFiltered: false,
    pageType: 0,
    dropZoneIndex: 0,
    rowDragIndex: 0,
    currentExecuteRequest: null,
    executeEndPoint: null,
    executeData: null,
    refreshTable: null,
    currentListValues: null,
    needFiltering: false,
    currentSelectedField: false,
    suspendICheck: false,
    fields: [],
    gridColumnRefreshCallback: null,
    gridReorderCallback: null,
    filterTooltip: function() {
        $("#filter-form .instant-filter-box").hoverIntent({
            interval: 250,
            over: function () {
                var width = $(this).width();
                var visible = $('.instant-filter-dropdown', $(this)).is(':visible');
                if (width < 200 || visible) return;
                $('#instant-filter-tooltip').width(width - 14);
                $('#instant-filter-tooltip').html($('.instant-filter-caption', $(this)).html());
                $('#instant-filter-tooltip').show();
                $('#instant-filter-tooltip').position({
                    "my": "left top",
                    "at": "left bottom",
                    "of": $(this),
                    "offset": "0 0",
                    "collision": "none"
                });
                $('#instant-filter-tooltip').hide();
                $('#instant-filter-tooltip').slideDown('fast');
            },
            out: function () {
                $('#instant-filter-tooltip').hide();
            }
        });
    },
    populateNotCaption: function(parent, checked) {
        var data = $('.instant-filter-caption', parent).html();
        var notText = $('#not_ProjectCode').attr('data-text') + ' ';
        if(checked) {
            $('.instant-filter-caption', parent).html(notText + data);
        } else {
            $('.instant-filter-caption', parent).html(data.substring(notText.length));
        }
    },
    populateCaptionFromSelect: function(parent) {
        var data = '';
        var notText = $('#not_ProjectCode').attr('data-text') + ' ';
        $('option:selected', parent).each(function () {
            data += $(this).text() + ', ';
        });
        data = data.replace(new RegExp(String.fromCharCode(160), 'g'), '');
        data = data.replace(new RegExp(', $', 'g'), '');
        if($('.notfilter',parent).is(':checked')) {
            $('.instant-filter-caption', parent).html(notText + data);
        }
        else {
            $('.instant-filter-caption', parent).html(data);
        }
    },
    populateCaptionFromCustom: function (parent) {
        var data = '';
        $('input:checked', parent).each(function () {
            data += $(this).parent().next().html() + ', ';
        });

        $('option:selected', parent).each(function () {
            data += $(this).text() + ', ';
        });
        data = data.replace(new RegExp(String.fromCharCode(160), 'g'), '');
        data = data.replace(new RegExp(', $', 'g'), '');
        $('.instant-filter-caption', parent).html(data);
    },
    populateCaptionFromText: function(parent) {
        var checked = $('input[type="radio"]:checked', parent);
        var next = checked.parent().next();
        if (next.is('input[type="text"]')) {
            var data = gemini_commons.htmlEncode(next.val());
            next = next.next('input');
            if (next.length > 0) {
                data += ' - ' + gemini_commons.htmlEncode(next.val());
            }
            $('.instant-filter-caption', parent.parent()).html(data);
        }
        else {
            $('.instant-filter-caption', parent.parent()).html(next.html());
        }
    },
    populateCaptionFromFollowersText: function(parent, emails) {
        $('.instant-filter-caption', parent.parent()).html(emails);
    },
    populateCaptionFromChecks: function (parent) {
        var data = '';
        var checked = parent.find('input[type="checkbox"]:checked');
        checked.each(function () {
            data += $(this).parent().next().html() + ', ';
        });
        data = data.replace(new RegExp(String.fromCharCode(160), 'g'), '');
        data = data.replace(new RegExp(', $', 'g'), '');
        $('.instant-filter-caption', parent.parent()).html(data);
    },
    checkNeedsFilter: function() {
        if (gemini_filter.needFiltering) {
            gemini_filter.executeFilter();
        }
        $('.instant-filter-dropdown', '#filter-form').hide({});
    },
    dateChanged: function (date, element) {
        $(element).keyup();
        gemini_filter.executeFilter();
    },
    init: function (pageType, filterFields) {
        gemini_filter.pageType = pageType;
        // NEW INSTANT FILTER!

        // Populate a dropdown select list with selected options
        $('#filter-form').on('change', '.instant-filter-box[data-field-name="ProjectCode"] select', function (e) {
            var value = $(this).val();
            var any = $('option:first', $(this)).val();
            if (value != null && value != undefined && value.length > 1 && value.indexOf(any) != -1) {
                if (gemini_filter.currentListValues != null && gemini_filter.currentListValues != undefined && gemini_filter.currentListValues.indexOf(any) != -1) {
                    var newSelected = $(this).val();
                    newSelected.splice(0, 1);
                    $(this).val(newSelected);
                }
                else {
                    $(this).val(any);
                }
            }
            else if (value == null || value == undefined) {
                $(this).val(any);
            }
            gemini_ui.chosenUpdate($(this));
            gemini_filter.currentListValues = $(this).val();
            gemini_filter.populateCaptionFromSelect($(this).parent().parent());
            gemini_ajax.postCall('items', 'filteredprojectchanged', function (response) {
                $('.dynamic', '#filter-form').remove();
                $('#instant-filter-fields').before(response.Result.Html);
                gemini_filter.filterTooltip();
                gemini_ui.datePicker('#filter-form .datepicker', gemini_filter.dateChanged);
                gemini_ui.fancyInputs('#filter-form .fancy');
                gemini_filter.fields = [];
                $(response.Result.Fields).each(function () {
                    gemini_filter.fields.push({ value: this.Key, label: this.Value });
                });
                gemini_filter.executeFilter();
            }, null, { filter: $('#filter-form').serialize() });
        });

        $('#filter-form').on('change', '.instant-filter-box:not([data-field-name="ProjectCode"]) select', function (e) {
            var value = $(this).val();
            var any = $('option:first', $(this)).val();
            if (value != null && value != undefined && value.length > 1 && value.indexOf(any) != -1) {
                if (gemini_filter.currentListValues != null && gemini_filter.currentListValues != undefined && gemini_filter.currentListValues.indexOf(any) != -1) {
                    var newSelected = $(this).val();
                    newSelected.splice(0, 1);
                    $(this).val(newSelected);
                }
                else {
                    $(this).val(any);
                }
            }
            else if(value == null || value == undefined) {
                $(this).val(any);
            }
            gemini_ui.chosenUpdate($(this));
            gemini_filter.currentListValues = $(this).val();
            if ($(this).parent().attr('data-field-type')=='custom') {
                gemini_filter.populateCaptionFromCustom($(this).parent().parent());
            }
            else {
                gemini_filter.populateCaptionFromSelect($(this).parent().parent());
            }
            gemini_filter.executeFilter();
        });

        // Show / Hide the filter box
        $('#filter-form').on('click', '.instant-filter-box .instant-filter-header, .instant-filter-box .fonticon-dropdown', function (e) {
            gemini_commons.stopClick(e);
            $('#instant-filter-tooltip').hide();
            gemini_filter.checkNeedsFilter();
            var _this = $(this).parent();
            if ($('.instant-filter-dropdown', _this).is(':visible')) {
                $('.instant-filter-dropdown', _this).hide();
                gemini_filter.currentListValues = null;
            }
            else {
                $('.instant-filter-dropdown', '#filter-form').hide();
                $('.instant-filter-dropdown', _this).show();
                var addJSCrollpane = false;
                if ($('.chosen-container', _this).length == 0) {
                    if ($('.auto-complete-chosen', _this).length == 0) {
                        gemini_ui.chosen($('select', _this), null);
                    }
                    else {
                        var selId = $('select', _this);
                        gemini_ui.ajaxChosen($('select', _this), null, null, 'project/filter/get/customfield', { filter: function () { return $('#filter-form').serialize(); }, selected: function () { return selId.val(); } });
                    }
                    addJSCrollpane = true;
                }
                gemini_filter.currentListValues = $('select', _this).val();
                var custom = $('.instant-filter-dropdown[data-field-type="custom"]', _this).length > 0;
                if ($('select', _this).length > 0 && !custom) {
                    $('.chosen-container', _this).focus().mousedown();
                }
                else if (!custom) {
                    var checkboxes = $('.instant-filter-dropdown[data-field-type="check"]', _this).length > 0;
                    if (checkboxes) {
                        $('div.icheckbox_minimal:first input', _this).trigger('focus.i');
                    }
                    else {
                        $('input[type="text"]:first', _this).focus().click();
                    }
                    addJSCrollpane = false;
                }

                if (addJSCrollpane) {
                    // add jscrollpane after chosen is opened!
                    $('.chosen-results', _this).jScrollPane({});
                }
            }
        });

        $('#filter-form').on('click', '.instant-filter-box .instant-filter-dropdown[data-field-type="select"]', function (e) {
            gemini_commons.stopClick(e);
        });

        $('#filter-form').on('ifChecked', '.instant-filter-box .instant-filter-dropdown[data-field-type="text"] input[type="radio"]', function (e) {
            var _this = $(this);
            if (_this.attr('data-clear') == 'true') {
                _this.parent().parent().children('input[type="text"]').val('');
                gemini_filter.populateCaptionFromText(_this.parent().parent());
                gemini_filter.executeFilter();
            }
        });

        $('#filter-form').on('ifChanged', '.instant-filter-box .instant-filter-dropdown[data-field-type="custom"] input[type="checkbox"], .instant-filter-box .instant-filter-dropdown[data-field-type="custom"] input[type="radio"]', function (e) {
            gemini_filter.populateCaptionFromCustom($(this).parent().parent().parent());
            gemini_filter.executeFilter();
        });

        $('#filter-form').on('ifChanged', '.instant-filter-box .instant-filter-dropdown[data-field-type="check"] input[type="checkbox"]', function (e) {
            if (gemini_filter.suspendICheck) return;
            gemini_filter.suspendICheck = true;
            var _this = $(this);
            if (_this.val() == '-|1') {
                _this.parent().parent().find('input[type="checkbox"]:checked').not(":eq(0)").each(function () { $(this).iCheck('uncheck'); });
                _this.parent().parent().find('input[type="checkbox"]:checked').not(":eq(0)").prop('checked', false);
                if (!_this.prop('checked')) {
                    gemini_filter.suspendICheck = false;
                    /*_this.iCheck('check');
                    _this.prop('checked', true);*/
                    return;
                }
            }
            else {
                _this.parent().parent().find('input[type="checkbox"]:first').iCheck('uncheck');
                _this.parent().parent().find('input[type="checkbox"]:first').prop('checked', false);
            }
            gemini_filter.populateCaptionFromChecks(_this.parent().parent());
            gemini_filter.executeFilter();
            gemini_filter.suspendICheck = false;
        });

        // NOT filter
        $('#filter-form').on('ifChanged', '.instant-filter-box .notfilter', function (e) {
            gemini_filter.populateNotCaption($(this).parent().parent().parent().parent(), $(this).is(':checked'));
            if($(this).attr('id') == 'not_ProjectCode') {
                gemini_ajax.postCall('items', 'filteredprojectchanged', function (response) {
                    $('.dynamic', '#filter-form').remove();
                    $('#instant-filter-fields').before(response.Result.Html);
                    gemini_filter.filterTooltip();
                    gemini_ui.datePicker('#filter-form .datepicker', gemini_filter.dateChanged);
                    gemini_ui.fancyInputs('#filter-form .fancy');
                    gemini_filter.fields = [];
                    $(response.Result.Fields).each(function () {
                        gemini_filter.fields.push({ value: this.Key, label: this.Value });
                    });
                    gemini_filter.executeFilter();
                }, null, { filter: $('#filter-form').serialize() });
            }
            else {
                gemini_filter.executeFilter();
            }
        });
                
        // Text search
        $('#filter-form').on('keydown', '.instant-filter-box .instant-filter-dropdown[data-field-type="text"] input[type="text"]', function (e) {
            var code = e.keyCode || e.which;
            if (code == $.ui.keyCode.ENTER) {
                e.preventDefault();
                gemini_filter.populateCaptionFromText($(this).parent());
                gemini_filter.executeFilter();
                return false;
            }
        });

        // Email Followers Text search
        $('#filter-form').on('keydown', '#instant-filter-AssociatedWatchers #AssociatedWatchers-email', function (e) {
            var code = e.keyCode || e.which;
            if (code == $.ui.keyCode.ENTER) {
                e.preventDefault();
                gemini_filter.populateCaptionFromFollowersText($(this).parent(), $(this).val());
                gemini_filter.executeFilter();
                return false;
            }
        });

        $('#filter-form').on('keyup', '.instant-filter-box .instant-filter-dropdown[data-field-type="text"] input[type="text"]', function (e) {

            var _this = $(this);
            var val = _this.val();
            if (val != null && val != undefined && val.length > 0) {
                var radio = null;
                if (gemini_commons.endsWith(_this.attr('id'), '_to')) {
                    radio = _this.prev('input').prev().first('input[type="radio"]');
                }
                else {
                    radio = _this.prev().first('input[type="radio"]');
                }
                radio.prop('checked', true);
                radio.iCheck('check');
                gemini_filter.needFiltering = true;
            }
            else {
                var empty = true;
                if (gemini_commons.endsWith(_this.attr('id'), '_to')) {
                    var txt = _this.prev('input');
                    if (txt.length > 0) {
                        val = txt.val();
                        if (val != null && val != undefined && val.length > 0) {
                            empty = false;
                        }
                    }
                }
                else {
                    var txt = _this.next('input');
                    if (txt.length > 0) {
                        val = txt.val();
                        if (val != null && val != undefined && val.length > 0) {
                            empty = false;
                        }
                    }
                }

                if (empty) {
                    var radio = _this.parent().find('input[type="radio"]:first').parent();
                    radio.prop('checked', true);
                    radio.iCheck('check');
                }
                gemini_filter.executeFilter();
            }
            gemini_filter.populateCaptionFromText(_this.parent());
        });

        $('#filter-form').on('keyup', '#instant-filter-AssociatedWatchers #AssociatedWatchers-email', function (e) {

            var _this = $(this);
            var val = _this.val();
            gemini_filter.needFiltering = true;
            gemini_filter.populateCaptionFromText(_this.parent());
        });

        gemini_ui.fancyInputs('#filter-form .fancy');

        // Remove attribute!
        $('#filter-form').on('click', '.instant-filter-box .fonticon-cross', function (e) {
            gemini_commons.stopClick(e);
            var _this = $(this);
            var parent = _this.parent();
            gemini_filter.fields.push({ value: $(parent).attr('data-field-name'), label: $(parent).attr('data-field-desc') });
            gemini_filter.fields.sort(function (a, b) {
                return a.label > b.label;
            });
            $(parent).remove();
            $('#instant-filter-tooltip').hide();
            gemini_filter.executeFilter();
            $('#instant-filter-new-field').focus().click();
        });

        // User looking for new field!
        gemini_filter.fields = [];

        $(filterFields).each(function () {
            gemini_filter.fields.push({ value: this.Key, label: this.Value });
        });

        $("#instant-filter-new-field").bind("keydown", function (event) {
            if (event.keyCode === $.ui.keyCode.ENTER) {
                if(!gemini_filter.currentSelectedField) {
                    $('#instant-filter-Keywords').remove();
                    gemini_ajax.postCall('items', 'newfilterbox', function (response) {
                        gemini_filter.wizardBoxAdded = true;
                        $('#instant-filter-fields').before(response.Result.Html);
                        gemini_ui.fancyInputs('#instant-filter-Keywords .fancy');
                        gemini_filter.filterTooltip();
                        gemini_filter.executeFilter();
                    }, null, { field: $(this).val(), filter: $('#filter-form').serialize() });
                    $(this).val('');
                
                    for (var i = gemini_filter.fields.length - 1; i >= 0; i--) {
                        if (gemini_filter.fields[i].value === 'Keywords') {
                            gemini_filter.fields.splice(i, 1);
                            break;
                        }
                    }
                    return false;
                }
                else if($(this).val() == null || $(this).val() == undefined || $(this).val().length  == 0) {
                    return false;
                }
            }
            else if (event.keyCode == 8) {
                var data = $('#instant-filter-new-field').val();
                if (data == null || data == undefined || data.length == 0) {
                    var cross = $('.fonticon-cross:last', '#filter-form');
                    if (cross.length > 0) {
                        cross.click(); 
                    }
                    else {
                        // Open the project box.
                        $('.instant-filter-header', '#instant-filter-ProjectCode').click();
                    }
                }
            }
        });
        
        $('#instant-filter-new-field').autocomplete({
            select: function (event, ui) {
                gemini_ajax.postCall('items', 'newfilterbox', function (response) {
                    gemini_filter.wizardBoxAdded = true;
                    $('#instant-filter-fields').before(response.Result.Html);
                    gemini_filter.filterTooltip();
                    gemini_ui.datePicker('#instant-filter-' + response.Result.Field + ' .datepicker', gemini_filter.dateChanged);
                    gemini_ui.fancyInputs('#instant-filter-' + response.Result.Field + ' .fancy');
                    setTimeout(function () { $('.instant-filter-title', '#instant-filter-' + response.Result.Field).click(); }, 100);
                    //$('.instant-filter-title', '#instant-filter-' + response.Result.Field).click();
                }, null, { field: ui.item.value, filter: $('#filter-form').serialize() });
                $(this).val('');
                gemini_filter.fields.splice(gemini_filter.fields.indexOf(ui.item), 1);
                return false;
            },
            focus: function (event, ui) {
                $('.auto-popup', '#filter-form').hide({});
                return false;
            },
            delay: 0,
            minLength: 0,
            autoFocus: true,
            source: function (request, response) {
                var matches = $.map(gemini_filter.fields, function (tag) {
                    if (tag.label.toUpperCase().indexOf(request.term.toUpperCase()) === 0) {
                        return tag;
                    }
                });
                gemini_filter.currentSelectedField = matches.length > 0;
                response(matches);
            }
        });
        $("#instant-filter-new-field").autocomplete("widget").css('position', 'absolute').addClass('z-index-medium');
        // Auto popup auto complete for fields when we focus!
        $("#instant-filter-new-field").bind('focus', function () {
            $("#instant-filter-new-field").autocomplete("search");
        });

        gemini_ui.datePicker('#filter-form .datepicker', gemini_filter.dateChanged);


        gemini_filter.filterTooltip();
        // NEW INSTANT FILTER!
        
        $("#filter-form .instant-filter-title, #filter-form .instant-filter-caption").disableSelection();

        $('#contents').on('click', "#grid-import-data", function (e) {
            $("#cs-popup-center-content").css("width", "800px");
            $("#cs-popup-center-content").css("height", "400px");
            
            gemini_popup.centerPopup("items", "importdatap/popup");
        });
        
        
        var fieldLimits = $("#filter-limit", '#items-filter');
        if (parseInt(fieldLimits.val()) > parseInt(fieldLimits.attr('data-filterlimit'))) {
            $("#filter-project-specific .custom-filter").hide();
        }       

        $('#data').on('click', '#pager-next', function () {
            var currentPage = $('#pager-next').data('page');
            gemini_filter.getFilteredItemsPage(currentPage);
        });

        $('#data').on('click', '#pager-prev', function () {
            var currentPage = $('#pager-prev').data('page') - 2;
            if(currentPage >= 0) gemini_filter.getFilteredItemsPage(currentPage);
        });
       
        if (gemini_filter.pageType != gemini_commons.PAGE_TYPE.Planner && gemini_filter.pageType != gemini_commons.PAGE_TYPE.Burndown && gemini_filter.pageType != gemini_commons.PAGE_TYPE.Calendar) {
            gemini_filter.initDataTable();
        }

        if (gemini_appnav.pageCard.Id == 0 || gemini_appnav.pageCard.Locked)
        {
            if (gemini_appnav.pageCard.Id == 0) $('#filter-form #ShowSequenced').iCheck('uncheck');
            if($('#filter-form #ShowSequenced:checked').length == 0) {
                // Only disable if we are not showing the sequence zone
                $('#filter-form #ShowSequenced').attr('disabled', 'disabled');
                $('#filter-form .instant-filter-dropdown label[for="ShowSequenced"]').addClass('color-grayscale2');
            }
        }

        if (gemini_appnav.pageCard.Filter && gemini_appnav.pageCard.Filter.ShowSLA)
        {
            gemini_filter.startSLATimer();
        }
        
        $('#filter-form').on('ifChanged', '#ShowSLA', function ()
        {
            if($('#ShowSLA', '#filter-form').prop('checked'))
            {
                gemini_filter.startSLATimer();
            }
            else 
            {
                gemini_filter.stopSLATimer();
            }
        });
        
    },

    slaTimerHandle: null,
    stopSLATimer: function()
    {
        if (gemini_filter.slaTimerHandle)
        {
            clearInterval(gemini_filter.slaTimerHandle)
            gemini_filter.slaTimerHandle = null;
        }
    },

    startSLATimer: function()
    {
        gemini_filter.stopSLATimer();
        gemini_filter.slaTimerHandle = setInterval(gemini_filter.recalcSLA, 60 * 1000);
    },

    recalcSLA: function()
    {
        var ids = [];
        $('#tabledata .sla-timer', '#items-grid').each(function()
        {
            ids.push($(this).closest('tr').attr('data-issue-id'));
        });

        if (ids.length)
        {
            gemini_ajax.postCall('items', 'slatime', function (response)
            {
                if (response.Success)
                {
                    $(response.Result.Data).each(function ()
                    {
                        var span = $('span.sla-timer', '#tr-issue-' + this.Id + ' td.items-first-column');
                        span.html(this.SLATime).attr('data-sla-minutes', this.SLATimeMinutes).attr('title', this.SLATimeFull);
                        span.parent().removeAttr('class').addClass('sla-' + this.SLAStatus);
                    });
                }
            }, null, { ids: ids });
        }

    },

    addFilterBox: function(id, callback) 
    {
        gemini_ajax.postCall('items', 'newfilterbox', function (response)
        {
            gemini_filter.wizardBoxAdded = true;
            $('#instant-filter-fields').before(response.Result.Html);
            gemini_filter.filterTooltip();
            gemini_ui.datePicker('#instant-filter-' + response.Result.Field + ' .datepicker', gemini_filter.dateChanged);
            gemini_ui.fancyInputs('#instant-filter-' + response.Result.Field + ' .fancy');
            for (var i = gemini_filter.fields.length - 1; i >= 0; i--)
            {
                if (gemini_filter.fields[i].value === id)
                {
                    gemini_filter.fields.splice(i, 1);
                    break;
                }
            }

            callback(response);
        }, null, { field: id, filter: $('#filter-form').serialize() });
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
        
    initDataTable: function () {
        if ($('#tabledata').length == 0) return;

        var nonSort = { "bSortable": false, "aTargets": [0] };
        if ($('#ShowSLA', '#filter-form').prop('checked'))
        {
            nonSort = { "bSortable": true, "aTargets": [0] };
        }
        var x = $('#tabledata').dataTable(
        {
            bFilter: false,
            bPaginate: false,
            bInfo: false,
            "aaSorting": [],
            fnSortCallback: gemini_filter.sortColumn,
            sDom: 'Rlfrtip',
            "bAutoWidth": false,
            "aoColumnDefs": [ 
            nonSort
            ],
            "oColReorder": {
                //"iFixedColumns": $('#tabledata').find('thead').find('tr')[0].cells.length,
                "fnColReorderCallback": function (x, y) {
                    if (x == y) return;

                    var xProperty = $($('#tabledata').find('thead').find('tr')[0].cells[x]).data('id');
                    var yProperty = $($('#tabledata').find('thead').find('tr')[0].cells[y]).data('id');

                    if (gemini_filter.gridReorderCallback)
                    {
                        gemini_filter.gridReorderCallback(xProperty, yProperty);
                    }
                    else
                    {
                        gemini_ajax.postCall("items", 'reordercolumns?viewtype=' + gemini_filter.pageType,
                            function (response) {
                                if (response.Success) {
                                    if (gemini_filter.refreshTable != null) {
                                        gemini_filter.executeFilter();
                                    }
                                    else {
                                        var currentPage = $('#pager-next').data('page');
                                        gemini_filter.getFilteredItemsPage(currentPage - 1);
                                        var card = $.parseJSON(gemini_commons.htmlDecode(gemini_appnav.pageCard.Options['Items']));
                                        card.DisplayColumns = response.Result.Data;
                                        gemini_appnav.pageCard.Options['Items'] = gemini_commons.htmlEncode(JSON.stringify(card));
                                    }
                                }
                            },
                            function (xhr, ajaxOptions, thrownError) {
                                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                            }, { from: xProperty, to: yProperty });
                    }
                }
            }
        });

        gemini_filter.initTableDnD();

        var sort = $('#Sort').length>0 ? $('#Sort').val().split('|') : '';
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
                gemini_ajax.postCall('items', 'fetchdependants' + '?issueid=' + $(this).parent().parent().data('issue-id'), gemini_filter.showDependants, null, { filter: $('#filter-form').serialize() });
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

                gemini_ajax.postCall("items", "resequence", function ()
                {
                        /*** WIZARD ***/
                        if (gemini_wizard.active)
                        {
                            var seqItem = $('tr.drop-zone', '#tabledata').prev();
                            if (seqItem.attr('data-issue-id'))
                            {
                                seqItem = seqItem.prev();
                                if (seqItem.attr('data-issue-id'))
                                {
                                    $.publish('wizard-action', ['itemsequenced']);
                                }
                            }
                        }
                        /*** WIZARD ***/
                    },
                    function (xhr, ajaxOptions, thrownError) {
                        gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                    },
                    {
                        issueId: $(row).data('issue-id'), afterIssueId: row.rowIndex == 1 || dropZoneIndex < row.rowIndex ? 0 : $(table.rows[row.rowIndex - 1]).data('issue-id'),
                        newIndex: dropZoneIndex < row.rowIndex ? -1 : row.rowIndex - 1,  oldIndex: gemini_filter.rowDragIndex - 1
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
        $('#tr-issue-' + response.Result.IssueId, '#tabledata').after(response.Result.Dependants);
        $("tr[id^='tr-issue-'] td", '#tabledata').destroyContextMenu();
        gemini_items.bindContextMenu();
        gemini_ui.fancyInputs('#tabledata .fancy');
        gemini_items.initCheckAllItems();
        gemini_items.initShiftSelect();
    },
    
    getFilteredItemsCurrentPage: function () {
        gemini_filter.getFilteredItemsPage($('#pager-next').data('page') - 1);
    },
    
    getFilteredItemsPage: function (page) {
        if (gemini_filter.currentExecuteRequest != null) {
            return;
        }
        $('#items-grid').css('opacity', '0.6');
        gemini_filter.currentExecuteRequest = gemini_ajax.postCall('items/page', '' + page,
                                                function (response) {
                                                    gemini_filter.currentExecuteRequest = null;
                                                    if (response.Success) {
                                                        $('#pager-next').data('page', response.Result.CurrentPage);
                                                        $('#pager-prev').data('page', response.Result.CurrentPage);
                                                        $('#data').html(response.Result.Data);
                                                        gemini_filter.initDataTable();
                                                        gemini_ui.fancyInputs('#tabledata .fancy');
                                                        gemini_items.initCheckAllItems();
                                                        gemini_items.initShiftSelect();
                                                        gemini_items.initPageSize();
                                                        if (!($('#tabledata tbody tr:not(.drop-zone):first').length)) {
                                                            $('#pageSizeContainer').hide();
                                                        }
                                                        else {
                                                            $('#pageSizeContainer').show();
                                                        }
                                                    }
                                                    $.publish('items-grid-page-loaded');
                                                    gemini_items.resizeMainItemsGrid();
                                                    $('#items-grid').css('opacity', '1');
                                                    $.publish('items-grid-filter-executed', [response.Result]);
                                                },
                                                function (xhr, ajaxOptions, thrownError) {
                                                    $('#items-grid').css('opacity', '1');

                                                    gemini_filter.currentExecuteRequest = null;
                                                    gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                                                }, { filterForm: $('#filter-form').serialize() });
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
        /*** WIZARD ***/
        if (gemini_wizard.active)
        {
            if (gemini_filter.wizardBoxAdded)
            {
                $.publish('wizard-action', ['filtered']);
            }
        }
        /*** WIZARD ***/
        
        gemini_filter.needFiltering = false;

        if (gemini_filter.currentExecuteRequest != null) {
            gemini_filter.currentExecuteRequest.abort();
        }

        $('#contents').toggleClass('cursor-busy');
        $('#items-grid').css('opacity', '0.6');
        var endPoint = 'items/executefilter';
        
        if (gemini_filter.executeEndPoint != null) endPoint = gemini_filter.executeEndPoint;

        if (gemini_filter.pageType == gemini_commons.PAGE_TYPE.Burndown || gemini_filter.pageType == gemini_commons.PAGE_TYPE.Calendar) {
            endPoint = endPoint + '?RF=1';
        }

        var data;
        if(gemini_filter.pageType == gemini_commons.PAGE_TYPE.Items)
        {
            data = { filterForm: $('#filter-form').serialize(), pageSize: $('#pageSize').val() };
        }
        else 
        {
            data = gemini_filter.executeData == null ? { filterForm: $('#filter-form').serialize() } : gemini_filter.executeData();
        }

        gemini_filter.currentExecuteRequest = gemini_ajax.postCall('', endPoint,
                                                function (response) {
                                                    gemini_filter.currentExecuteRequest = null;
                                                    if (response.Success) {
                                                        $('#contents').toggleClass('cursor-busy');

                                                        if (gemini_filter.pageType == gemini_commons.PAGE_TYPE.Planner) {
                                                            planner.filterChanged();
                                                            $.publish('items-grid-filter-executed', [response.Result]);
                                                            gemini_appnav.pageCard.Filter = response.Result.SavedCard.Filter;
                                                            return;
                                                        }
                                                        else if (gemini_filter.pageType == gemini_commons.PAGE_TYPE.Burndown || gemini_filter.pageType == gemini_commons.PAGE_TYPE.Calendar || gemini_filter.pageType == gemini_commons.PAGE_TYPE.Custom) {
                                                            $.publish('items-grid-filter-executed', [response.Result]);
                                                            gemini_appnav.pageCard.Filter = response.Result.SavedCard.Filter;
                                                            return;
                                                        }
                                                        else {
                                                            if (gemini_filter.refreshTable == null) {
                                                                $('#data').html(response.Result.Data);
                                                            }
                                                            else {
                                                                gemini_filter.refreshTable(response.Result.Data);
                                                            }
                                                            gemini_filter.initDataTable();
                                                            gemini_items.resizeMainItemsGrid();
                                                            gemini_ui.fancyInputs('#tabledata .fancy');
                                                            gemini_items.initCheckAllItems();
                                                            gemini_items.initShiftSelect();
                                                            gemini_items.initPageSize();
                                                        }
                                                        if (response.Result.SavedCard != null) {
                                                            //gemini_appnav.pageCard.Options = response.Result.SavedCard.Options;
                                                            gemini_appnav.pageCard.Filter = response.Result.SavedCard.Filter;
                                                        }

                                                        if (!($('#tabledata tbody tr:not(.drop-zone):first').length)) {
                                                            $('#pageSizeContainer').hide();
                                                        }
                                                        else {
                                                            $('#pageSizeContainer').show();
                                                        }
                                                        $.publish('items-grid-filter-executed', [response.Result]);
                                                    }
                                                    else {
                                                        $('#items-grid').css('opacity', '1');
                                                    }
                                                },
                                                function (xhr, ajaxOptions, thrownError) {
                                                    gemini_filter.currentExecuteRequest = null;
                                                    $('#contents').toggleClass('cursor-busy');
                                                    $('#items-grid').css('opacity', '1');
                                                    if(xhr.status == 500) {
                                                        gemini_popup.toast('There was an error executing your filter', true);
                                                    }
                                                }, data);
       
    },
    refreshFilterCard: function () {
        var endPoint = 'items/executefilter';
 
        if (gemini_filter.executeEndPoint != null) endPoint = gemini_filter.executeEndPoint;

        if (endPoint.indexOf('?') != -1) {
            endPoint = endPoint + '&RF=1';
        }
        else {
            endPoint = endPoint + '?RF=1';
        }

        var data;
        if (gemini_filter.pageType == gemini_commons.PAGE_TYPE.Items) {
            data = { filterForm: $('#filter-form').serialize(), pageSize: $('#pageSize').val() };
        }
        else {
            data = gemini_filter.executeData == null ? { filterForm: $('#filter-form').serialize() } : gemini_filter.executeData();
        }

        gemini_ajax.postCall('', endPoint,
            function (response) {
                gemini_filter.currentExecuteRequest = null;
                if (response.Success) {

                    if (response.Result.SavedCard != null) {
                        //gemini_appnav.pageCard.Options = response.Result.SavedCard.Options;
                        gemini_appnav.pageCard.Filter = response.Result.SavedCard.Filter;
                    }
                }
            },null, data);
    },
    gridColumnPickerInit: function (refreshCallback) {

        gemini_filter.gridColumnRefreshCallback = refreshCallback;
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
                gemini_keyboard.unbindEscape("#column-picker");
            }
            else {
                gemini_ajax.call('items', 'getcolumns?viewtype=' + gemini_filter.pageType,
                    function (response) {
                        if (response.Success) {
                            $("#column-picker").css({
                                top: $("#grid-column-picker").position().top + $("#grid-column-picker").height() + 8,
                                left: $("#grid-column-picker").position().left - 225
                            });

                            $('#column-picker').html(response.Result.Data);

                            $("#column-picker").slideDown('fast');

                            $('#colmun-picker-submit').click(function () {
                                $("#column-picker").fadeOut('fast');
                                gemini_ui.startBusy('#column-picker #colmun-picker-submit');

                                gemini_ajax.postCall('items', 'setcolumns?viewtype=' + gemini_filter.pageType,
                                    function (response) {
                                        if (response.Success) {
                                            if (gemini_filter.gridColumnRefreshCallback) {
                                                gemini_filter.gridColumnRefreshCallback(response);
                                            }
                                            else {
                                                var currentPage = $('#pager-next').data('page') - 1;
                                                if (currentPage < 0) currentPage = 0;
                                                var card = $.parseJSON(gemini_commons.htmlDecode(gemini_appnav.pageCard.Options['Items']));
                                                card.DisplayColumns = response.Result.Data;
                                                gemini_appnav.pageCard.Options['Items'] = gemini_commons.htmlEncode(JSON.stringify(card));
                                                gemini_filter.getFilteredItemsPage(currentPage);
                                            }

                                        }
                                        gemini_ui.stopBusy('#column-picker #colmun-picker-submit');
                                    },
                                    function (xhr, ajaxOptions, thrownError) {
                                        gemini_ui.stopBusy('#column-picker #colmun-picker-submit');
                                    }, $('#column-picker-form').serialize());
                            });

                            gemini_keyboard.bindEscape("#column-picker", gemini_filter.EscapeDropdowns);

                            gemini_ui.fancyInputs('#column-picker .fancy');
                        }
                    });               
            }
        });
    }
};

