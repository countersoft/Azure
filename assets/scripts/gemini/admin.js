var gemini_admin = {

    currentTab: "",
    currentSubTab: "",
    currentTemplate: 0,
    tabTopSelector: "#tabs-top > .tab",
    tabLeftSelector: "#tabs-left",
    currentXHR: null,
    currentTable: null,

    initGlobal: function (templatedId) {
        var tabsTop = gemini_admin.tabTopSelector;
        var tabsLeft = gemini_admin.tabLeftSelector;

        gemini_admin.currentTemplate = templatedId;

        // Stop text selection
        $(tabsTop).disableSelection();
        $(tabsLeft).disableSelection();

        // Top tabs
        gemini_sizing.sameWidth(tabsTop);

        $(tabsTop).on("click", function (e) {

            $(tabsTop).removeClass("selected").addClass("normal");
            $(this).removeClass("normal").addClass("selected");

            gemini_admin.currentTab = $(this).data("tab");
            gemini_admin.getSubTab();
        });

        // Left tabs
        $(tabsLeft).on("click", "div:not(.help)", function (e) {

            $("#tabs-left div:not(.help)").removeClass("selected").addClass("normal");
            $(this).removeClass("normal").addClass("selected");

            gemini_admin.currentSubTab = $(this).data("tab");
            gemini_admin.getPage();
        });

        if(gemini_admin.currentTab.length == 0)
        {
            gemini_admin.currentTab = $("#tabs-top div:first-child").data("tab");
        }
        else
        {
            $(tabsTop).removeClass("selected").addClass("normal");
            $(tabsTop + '[data-tab="' + gemini_admin.currentTab + '"]').addClass("selected");
        }
        
        gemini_admin.getSubTab(gemini_admin.currentSubTab);
    },

    checkXHR: function () {
        if (gemini_admin.currentXHR != null) {
            gemini_admin.currentXHR.abort();
            gemini_admin.currentXHR = null;
        }
    },

    getSubTab: function (subTab) {
        
        gemini_admin.checkXHR();
        if (subTab == null || subTab == undefined)
        {
            gemini_admin.currentSubTab = "";
        }
        
        gemini_admin.currentXHR = gemini_ajax.jsonCall("configure", "tab/" + gemini_admin.currentTab, gemini_admin.renderSubTabs);
    },

    renderSubTabs: function (response) {
        $("#tabs-left-content").html(response.Result.Menu);

        if (gemini_admin.currentSubTab == "") {
            gemini_admin.currentSubTab = $("#tabs-left div:first-child").data("tab");
        }
        gemini_admin.currentXHR = null;
        gemini_admin.getPage();
    },

    getPage: function () {
        gemini_admin.checkXHR();
        gemini_admin.clearPage();

        gemini_admin.currentXHR = gemini_ajax.postCall("configure", "tab/" + gemini_admin.currentTab
            + "/" + gemini_admin.currentSubTab, gemini_admin.renderPage, null, { template: gemini_admin.currentTemplate } );
    },

    clearPage: function () {
        $("#configure-page-content").empty();
    },

    getTemplateId: function () {
        return gemini_admin.currentTemplate;
    },

    getFormTemplateId: function() {
        return "&template=" + gemini_admin.currentTemplate;
    },

    renderPage: function (response) {
        $("#configure-page-content").html(response.Result.Page);
        gemini_admin.currentXHR = null;

        gemini_ui.chosen('select', null);
        
        $("#tabs-left div:not(.help)").removeClass("selected").addClass("normal");
        $('#tabs-left div:not(.help)[data-tab="' + gemini_admin.currentSubTab + '"]').removeClass("normal").addClass("selected");

        if (gemini_admin.currentTab == "Templates")
        {
            gemini_admin.currentTemplate = $("#Template").val();
            
            // Template change
            $("#Template").unbind('change').change(function(e) {
                gemini_admin.currentTemplate = $("#Template").val();
                gemini_admin.getPage();
            });

            // Export
            $("#export-template").unbind('click').click(function (e)
            {
                gemini_commons.stopClick(e);
                gemini_commons.openUrl(csVars.Url + "configure/template/export/" + gemini_admin.currentTemplate);
            });

            // Delete
            $("#delete-template").unbind('click').click(function (e)
            {
                gemini_commons.stopClick(e);

                gemini_popup.modalConfirm("Delete Project Template?", null, function () {
                    gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                    gemini_ajax.postCall("configure", "template/delete/" + gemini_admin.currentTemplate,
                        function () {
                            $("#Template option").each(function() {
                                if($(this).val() != gemini_admin.currentTemplate) {
                                    gemini_admin.currentTemplate = $(this).val();
                                    return false;
                                }
                            });
                            gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
                            gemini_admin.getPage();
                        }, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); });
                }, null);
            });

            // Load
            $("#load-templates").unbind('click').click(function (e)
            {
                gemini_commons.stopClick(e);
                gemini_ajax.postCall("configure", "template/load/", gemini_admin.getPage);
            });

            // Duplicate
            $("#duplicate-template").unbind('click').click(function (e)
            {
                gemini_commons.stopClick(e);
                gemini_popup.centerPopup("configure/template/duplicate", "popup", null);
            });
        }
    },

    initDatatables: function (selector, options) {
        var optionsString = {};

        if (options != null) optionsString = options;

        var params = $.extend({},
            {
                bFilter: true,
                bInfo: true,
                bSort: true,
                bPaginate: true,
                bLengthChange: false,
                iDisplayLength: 20,
                sPaginationType: "full_numbers",
                "oLanguage": {
                    "sInfo": "Showing _START_ to _END_ of _TOTAL_ entries",
                    "sInfoEmpty": ""
                }
            }, optionsString);


        gemini_admin.currentTable = $(selector).dataTable(params);
    },
    rowDragIndex: 0,
    initTableDnD: function (selector) {
        $(selector).tableDnD({
            dragHandle: ".dragHandle",
            onDrop: function (table, row) {
                gemini_ajax.postCall('configure', gemini_admin.currentTab + "/" + gemini_admin.currentSubTab+'/resequence', function () { }, null, {
                    id: $(row).data('id'),
                    template: gemini_admin.currentTemplate,
                    afterid: row.rowIndex == 1 ? 0 : $(table.rows[row.rowIndex - 1]).data('id'),
                    newIndex: row.rowIndex - 1,
                    oldIndex: gemini_admin.rowDragIndex - 1
                });
            },
            onDragStart: function (table, row) {
                gemini_admin.rowDragIndex = row.parentNode.parentNode.rowIndex;
            },
            onDragClass: 'highlight-hover',
            onAllowDrop: function (draggedRow, dropTargetRow) {
                return $(dropTargetRow.children[0]).is('td');
            }
        });
    },
    initDatatablesWithEdit: function (selector, dndEnabled, editSelector, options) {
        var optionsString = {};

        if (editSelector == null || editSelector == undefined) editSelector = "tbody td:not([data-edit='false'])";

        if (options != null) optionsString = options;

        var dnd = true;//dndEnabled;
        var dndDisabled = false;
        var wasSorted = false;

        var params = $.extend({},
            {
                bFilter: true,
                bInfo: true,
                bSort: true,
                bPaginate: true,
                bLengthChange: false,
                iDisplayLength: 20,
                sPaginationType: "full_numbers",
                "oLanguage": {
                    "sInfo": "Showing _START_ to _END_ of _TOTAL_ entries",
                    "sInfoEmpty": "No data."
                },
                fnDrawCallback: function (value, y) {

                    if (dnd) {
                        if (value.bFiltered || value.bSorted) {
                            $('.dragHandle').hide();
                            wasSorted = true;

                        } else if(!wasSorted) {
                            $('.dragHandle').show();

                        }
                    }

                    $(selector + ' ' + editSelector).editable(csVars.Url + 'configure/' + gemini_admin.currentTab + "/" + gemini_admin.currentSubTab + '/saveproperty', {
                        placeholder: '',
                        detectType: function (elem) {
                            var th = gemini_ui.getTableTHForTD(elem);
                            return $(th).data('edit-type');
                        },
                        validationRequired: function (elm) {
                            var th = gemini_ui.getTableTHForTD(elm);
                            return $(th).data('required');
                        },
                        validationEmail: function (elm) {
                            var th = gemini_ui.getTableTHForTD(elm);
                            return $(th).data('email');
                        },
                        loadurl: csVars.Url + 'configure/' + gemini_admin.currentTab + "/" + gemini_admin.currentSubTab + '/getproperty',
                        loaddata: function () {
                            var th = gemini_ui.getTableTHForTD(this);
                            var field = $(th).data('field');
                            return {
                                id: $(this).parent().data('id'),
                                property: field
                            };
                        },
                        submitdata: function () {
                            var th = gemini_ui.getTableTHForTD(this);
                            var field = $(th).data('field');
                            return {
                                id: $(this).parent().data('id'),
                                property: field
                            };
                        },
                        /*"callback": function (sValue, y) {
                        /// Redraw the table from the new data on the server
                        //oTable.fnDraw();
                        },*/
                        "height": "14px"
                    });

                    if ($('*[data-edit-type="color"]').length > 0) {
                        $(editSelector).each(function () {
                            var th = gemini_ui.getTableTHForTD(this);
                            if ($(th).data('edit-type') == "color") {
                                $(this).click();
                            }
                        });
                    }
                }
            }, optionsString);


       gemini_admin.currentTable = $(selector).dataTable(params);
    },
    removeRow: function (itemInRow) {
        var row = $(itemInRow).closest("tr");
        var tbody = row.closest("tbody");
        //row.remove();
        var rowIndex = gemini_admin.currentTable.fnGetPosition(row[0]);
        gemini_admin.currentTable.fnDeleteRow(rowIndex);
        //even firstly as it is 0 based
        tbody.children("tr:even").addClass("odd").removeClass("even");
        tbody.children("tr:odd").addClass("even").removeClass("odd");
    },

    showPopup: function (controller, method, id) {

        gemini_ajax.call(controller, method, function (response) {
            $("#cs-popup-center-content").html(response.result.data.html);
            $("#cs-popup-center").show();
        }, null, { id: id }, null);
    },
    
    saveStarted: function(button) {
        gemini_ui.togglePageOverlay("#tabs-left, #tabs-top");
        gemini_ui.cursorWait();
        gemini_ui.disableButton(button);        
    },

    saveFinished: function(button) {
        //gemini_ui.togglePageOverlay("#tabs-left, #tabs-top");
        gemini_ui.cursorDefault();
        gemini_ui.enableButton(button);
        gemini_popup.toast("Saved");
    },
    
    hideAttributeOptionsPicker: function () {
        $('#attribute-options-picker').hide();
        var field = $('#attribute-options-picker').attr('data-field');
        $('#attribute-options-picker').attr('data-field', '');
        var id = $('#' + field).attr('id');
        $('#attribute-options-picker').removeClass(id);
    },

    persistAttributeOptionsPicker: function (showSectionRequired, applyCallback)
    {
        var update = $('#attribute-options-picker').attr('data-field');
        var selected = '';

        $(':selected', '#attribute-options-ProjectGroup').each(function () {
            selected = selected + "|" + $(this).val();
        });
        $('#' + update).attr('data-project-groups', selected);

        if (showSectionRequired) {
            if ($("#field-required").is(":checked")) {
                $('#' + update).attr('data-required', 'true');
            } else {
                $('#' + update).attr('data-required', 'false');
            }
        }

        if (applyCallback) applyCallback();
    },
    EscapeAttributeDdropdown: function (guid, selector) {
        gemini_admin.hideAttributeOptionsPicker();
    },
    attributeOptionsPicker: function (optionsTrigger, dataStoreCallback, showSectionRequired, applyCallback) {
        
        if (showSectionRequired)
        {
            $('#option-required', '#attribute-options-picker').show();
        }
        else
        {
            $('#option-required', '#attribute-options-picker').hide();
        }
        
        $('#option-delete', '#attribute-options-picker').hide();

        $("#option-apply-button", '#attribute-options-picker').unbind('click');
        $("#option-apply-button", '#attribute-options-picker').click(function (e) {
            gemini_admin.persistAttributeOptionsPicker(showSectionRequired, applyCallback);
            gemini_admin.hideAttributeOptionsPicker();
        });

        $(optionsTrigger).unbind('click');
        $(optionsTrigger).click(function (e) {
            var field = dataStoreCallback(this);// $(this).siblings("input");
            var update = $('#attribute-options-picker').attr('data-field');

            // Need to hide
            if (update != undefined && update != '')
            {
                gemini_admin.persistAttributeOptionsPicker(showSectionRequired, applyCallback);
            }
            
            if ($('#attribute-options-picker').hasClass(field.attr("id"))) {
                $('#attribute-options-picker').hide();  
                $('#attribute-options-picker').removeClass(field.attr("id"));
                $('#attribute-options-picker').attr('data-field', '');

                return;
            }

            // Getting ready to show
            if (showSectionRequired) {
                var requiredValue = field.attr('data-required');
                $("#field-required").removeAttr("checked");
                if (requiredValue == 'true') $("#field-required").attr("checked", "checked");
            }
            
            $('option', '#attribute-options-ProjectGroup').attr('selected', false);

            var groups = field.attr('data-project-groups').split("|");
            $(groups).each(function (e) {
                if (this != '') $('option[value="' + this + '"]', '#attribute-options-ProjectGroup').attr('selected', true);
            });

            $("#attribute-options-ProjectGroup").trigger("liszt:updated");    // Chosen needs updating too !!!

            $('#attribute-options-picker').attr('data-field', field.attr("id"));
            $('#attribute-options-picker').addClass(field.attr("id"));
            $('#attribute-options-picker').slideDown('fast');

            $('#attribute-options-picker').position({
                "my": "left top",
                "at": "left bottom",
                "of": this,
                "offset": "-10 0",
                "collision": "none"
            });
            gemini_keyboard.bindEscape("#attribute-options-picker", gemini_admin.EscapeAttributeDdropdown);
        });
    }
};
