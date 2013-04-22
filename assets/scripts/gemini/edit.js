gemini_edit = {
    //var $th = $td.closest('table').find('th').eq($td.index());
    pageType: 0,
    popupContainer: '',
    formContainer: '',
    pendingChanges: false,
    editingMode: false,
    issueId: 0,
    triggerXHR: null,
    refreshFunction: null,
    clickedElement: null,
    includeProjectsField: false,
    initEditing: function (elm) {
        if (!gemini_edit.editingMode) {
            // looking to start editing
            if (gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) {
                gemini_edit.issueId = $(elm).parent().data('issue-id'); 
            }
            else {
                elm = this;
            }

            var paramsString = "{}";
            if (gemini_edit.includeProjectsField) paramsString = { includeProjectsField: gemini_edit.includeProjectsField };
            
            var params = $.extend({},
                {
                    id: gemini_edit.issueId
                },
                paramsString);

            gemini_edit.pendingChanges = false;
            gemini_ajax.postCall(csVars.ProjectUrl + "edit", gemini_edit.pageType, gemini_edit.showEditingPopup, null, params, elm);
        }
        else {
            gemini_edit.hideEditingPopup();
        }
    },

    setPendingChanges: function () {
        gemini_edit.pendingChanges = true;
        $('#cs-popup-content').data('jsp').reinitialise({});
    },

    saveEditing: function () {
        if ($("#inline-edit-form", gemini_edit.formContainer).valid()) {
            gemini_ui.startBusy('#cs-popup #cs-popup-save');
            $('#inline-edit-form', gemini_edit.formContainer).submit();
            //gemini_ajax.postCall(csVars.ProjectUrl + "save", gemini_edit.pageType, gemini_edit.refresh, null, $('#inline-edit-form', gemini_edit.formContainer).serialize(), gemini_edit.issueId);
        }
        else {
            $('.error:not(label)', '#cs-popup-content').first().focus();
        }
    },

    refresh: function (response, issueId) {
        gemini_edit.pendingChanges = false;
        gemini_edit.hideEditingPopup();

        if (gemini_edit.pageType == gemini_commons.PAGE_TYPE.Item)
        {
            // View item
            $('#item-attributes').html(response.Result.Html);
            $('.widget-header').each(function () {
                gemini_item.getAppControlValue(gemini_item.issueId, $(this).data('gemini-app-id'), $(this).data('gemini-control-id'), 'value', '');
            });
            $(response.Result.Sections).each(function () {
                if (this.Key == 'Title') {
                    $('h2:last-child', '#content-header-navigation-text').html(this.Value);
                }
                else if (this.Key == 'reload') {
                    window.location = response.Result.RedirectUrl;
                }
                else if (this.Key == 'AssociatedHistory') {
                    var currentHistory = $('#history').parent();
                    $(this.Value).insertBefore(currentHistory);
                    if ($('.section-content', currentHistory).hasClass('collapsed')) {
                        gemini_ui.collapseStarting('history-');
                    }
                    currentHistory.remove();
                }
                else if (this.Key == 'AssociatedCustomFields')
                {
                    var current = $('#additional').parent();
                    $(this.Value).insertBefore(current);
                    if ($('.section-content', current).hasClass('collapsed'))
                    {
                        gemini_ui.collapseStarting('customfields-');
                    }
                    current.remove();


                }
            });
        }
        else /*if (gemini_edit.pageType == gemini_commons.PAGE_TYPE.Item)*/ {
            // Item grid
            gemini_edit.refreshFunction(response, issueId);
        }
    },
    showEditingPopup: function (response, elem) {
        
        if (typeof response == 'object') {
            if (!response.success) return;
        }
        gemini_edit.triggerXHR = null;
        gemini_edit.clickedElement = elem;
        try { $('#cs-popup-content', gemini_edit.popupContainer).html(response); } catch (e) { }

        gemini_ui.datePicker('#cs-popup-content .datepicker');
        //$('select', '#cs-popup-content').chosen({ stay_open : true, topmost_container: '#cs-popup-content .jspPane:first' });
        gemini_ui.chosen('#cs-popup-content select:not(.no-chosen)', null, true);
        
        $('#cs-popup-content', gemini_edit.popupContainer).data("jsp", "");
        $(gemini_edit.popupContainer).show();

        var availableHeight = gemini_sizing.availableHeight();
        if(gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) availableHeight -= 200;
        $(gemini_edit.popupContainer).css("height", availableHeight);
        var contentHeight = availableHeight - $('#cs-popup-buttons').height() - 20;
                
        $(".checked-select").jScrollPane({});
        
        $("#cs-popup-content", gemini_edit.popupContainer).jScrollPane({});
        $('.jspContainer', '#cs-popup-content').css("height", contentHeight);
        $('.jspPane', '#cs-popup-content').css("min-height", contentHeight-10);
        gemini_ui.htmlEditor('.wysiwyg-editor', /*gemini_edit.onHtmlEditorInit*/null, gemini_edit.setPendingChanges);
        gemini_ui.userAutocomplete('#cs-popup-content .user-autocomplete');
        $("#cs-popup-content", gemini_edit.popupContainer).jScrollPane('reinitialise');

        var options = {
            dataType: "json",
            success: function (responseText, statusText, xhr, $form) {
                if (responseText.success) gemini_edit.refresh(responseText, gemini_edit.issueId);
                gemini_ui.stopBusy('#cs-popup #cs-popup-save');
            },
            error: function (e, data) {
                gemini_ui.stopBusy('#cs-popup #cs-popup-save');
                gemini_popup.toast("Item could not be created", true);
            }// post-submit callback   

        };
        $("#inline-edit-form", gemini_edit.formContainer).ajaxForm(options);

        $("#inline-edit-form", gemini_edit.formContainer).validate({
            ignoreTitle: true,
            submitHandler: function (form) {
                //gemini_edit.saveEditing();
                //$('#inline-edit-form', gemini_edit.formContainer).submit();
            }
        });
        
        //gemini_sizing.sameWidth(".button-popup", 3);
        if (gemini_edit.pageType == gemini_commons.PAGE_TYPE.Item) {
            $(gemini_edit.popupContainer).position({
                "my": "left top",
                "at": "right top",
                "of": $('.attributes-pane'),
                "offset": "0 0",
                "collision": "none"
            });
        }
        else {
            var of = $(elem).parent();
            var offset = "0 -500";

            if ($("#planner-box").length > 0)
            {
                of = $("#planner-box");
                offset = "0 0";
            }

            $(gemini_edit.popupContainer).position({
                "my": "left top",
                "at": "left top",
                "of": of,
                "offset": offset,
                "collision": "none"
            });
            //$(gemini_edit.popupContainer).css('left', '10px'); OPERA?
            if ($("#tabledata").length > 0) {
                var tableTop = $('#tabledata').position().top;
                if (tableTop > $(gemini_edit.popupContainer).position().top) {
                    $(gemini_edit.popupContainer).css('top', tableTop + 'px');
                }
            }
        }

        var top = $(gemini_edit.popupContainer).position().top;
        var scrollOffset = window.pageYOffset;
        if (scrollOffset > top) {
            $(gemini_edit.popupContainer).css('top', scrollOffset + 'px');
        }
        
        gemini_edit.editingMode = true;

        $('input', gemini_edit.popupContainer).change(gemini_edit.setPendingChanges);
        $('input[type=text]', gemini_edit.popupContainer).keyup(gemini_edit.setPendingChanges);
        $('select', gemini_edit.popupContainer).change(gemini_edit.setPendingChanges);
        $("#cs-popup-save", gemini_edit.popupContainer).unbind("click");
        $("#cs-popup-close", gemini_edit.popupContainer).unbind("click");

        $("#cs-popup-save", gemini_edit.popupContainer).click(gemini_edit.saveEditing);
        $("#cs-popup-close", gemini_edit.popupContainer).click(gemini_edit.hideEditingPopup);

        window.onbeforeunload = gemini_edit.warnLoseChanges;

        gemini_commons.inputKeyHandler($(document), null, gemini_edit.hideEditingPopup);
        var api = $("#cs-popup-content", gemini_edit.popupContainer).data('jsp');
        
        if (gemini_edit.pageType == gemini_commons.PAGE_TYPE.Item)
        {
            var li = $(elem).find('.attribute-header');

            if ($(li).length == 0) li = elem;
            
            var attribId = $(li).data('attribute-id');

            if ($("#" + attribId, '#cs-popup-content').length == 0) return;
            if (!$("*[name='" + attribId + "']", '#cs-popup-content').is('select'))
            {
                api.scrollToY($("#" + attribId, '#cs-popup-content').position().top);
                
                if (!$("*[name='" + attribId + "'][type!='hidden']", '#cs-popup-content').is(':checkbox'))
                {
                    $("#" + attribId, '#cs-popup-content').focus().click();
                }
                else
                {
                    $("#" + attribId, '#cs-popup-content').focus();
                }
            }
            else
            {
                api.scrollToY($("#" + attribId + '_chzn', '#cs-popup-content').position().top);
                $('*[name="' + attribId + '"] + div', '#cs-popup-content').focus().mousedown();
            }

            $("#" + attribId, '#cs-popup-content').parent().addClass("highlight-underline");
            $("#" + attribId, '#cs-popup-content').parent().siblings().addClass("highlight-underline");
        }
        else
        {
            var th = $(elem).closest('table').find('th').eq($(elem).index());
            if ($("#" + $(th).data('id'), '#cs-popup-content').length == 0)
                return;
            
            if (!$("*[name='" + $(th).data('id') + "'][type!='hidden']", '#cs-popup-content').is('select'))
            {
                api.scrollToY($("#" + $(th).data('id'), '#cs-popup-content').position().top);
                //$("#" + $(th).data('id'), '#cs-popup-content').focus().click();
                if ($("*[name='" + $(th).data('id') + "'][type!='hidden']", '#cs-popup-content').is(':checkbox')) {
                    $("#" + $(th).data('id'), '#cs-popup-content').focus();
                }
                else {
                    $("#" + $(th).data('id'), '#cs-popup-content').focus().click();
                }
            }
            else
            {
                api.scrollToY($('*[name="' + $(th).data('id') + '"] + div', '#cs-popup-content').position().top);
                $('*[name="' + $(th).data('id') + '"] + div', '#cs-popup-content').focus().mousedown();
            }

            $("#" + $(th).data('id'), '#cs-popup-content').parent().addClass("highlight-underline");
            $("#" + $(th).data('id'), '#cs-popup-content').parent().siblings().addClass("highlight-underline");
            
            var tr = $(elem).closest('tr');
            if ($(tr).hasClass('dependant') || $(tr).find('.parent').length == 1) {
                $('.dependant', '#tabledata').remove();
                $('.parent', '#tabledata').removeClass('fonticon-arrow-up').addClass('fonticon-arrow-down')
            }
        }

        $('#cs-popup-content').find('*[data-trigger]').change(function (index) {
            gemini_edit.triggerChange(this);
        });

        $('#cs-popup-content').find('*[data-customfield-trigger]').change(function (index) {
            gemini_edit.triggerCustomfieldChange(this);
        });

        $('#cs-popup-content').find('*[data-customfield-trigger]').each(function (index) {
            if ($(this).data("customfield-trigger") == "P") {
                gemini_edit.triggerCustomfieldChange(this);
            }
        });


        $('.chzn-results','#cs-popup-content').jScrollPane({});

        gemini_keyboard.bindEscape("#cs-popup #cs-popup-close");
    },
    
    triggerChange: function (elem) {
        if (gemini_edit.triggerXHR != null) {
            gemini_edit.triggerXHR.abort();
        }

        var trigger = $(elem).data('trigger');

        if (trigger != '*') {
            var value = '|' + $(elem).val() + '|';
            if (trigger.indexOf(value) == -1) return;
        }


        var params = $('#inline-edit-form', gemini_edit.formContainer).serialize();
        
        if (gemini_edit.includeProjectsField) {
            params += "&includeProjectsField=" + encodeURIComponent(gemini_edit.includeProjectsField);
        }

        gemini_ui.destroyHtmlEditor('.wysiwyg-editor');
        gemini_edit.triggerXHR = gemini_ajax.postCall(csVars.ProjectUrl + "edit", gemini_edit.pageType, gemini_edit.showEditingPopup, null, params, $('[data-attribute-id="' + $(elem).attr('id') + '"]').parent().parent(), '#attributes');
    },
    triggerCustomfieldChange: function (elem) {

        var trigger = $(elem).data('customfield-trigger');

        if (trigger == '') return;

        var id = $(elem).attr("id").replace("cf_", "");

        var selectedval = "";
        $(elem).find("option:selected").each(function (index) {
            selectedval += $(this).val() + "|";
        });
        if (selectedval.length > 0)
            selectedval = selectedval.slice(0, -1); //remove trailing |

        gemini_ajax.postCall("project", "cascadeddata", gemini_edit.cascadeUpdate, null,
            {
                fieldid: id, value: selectedval,
                projectid: null,
                issueid: $("#Id", "#cs-popup").val()
            });
    },
    cascadeUpdate: function (response) {
        var data = response.Result.Data;

        for (var i = 0; i < data.length; i++) {
            var item = data[i];
            //get preselected list

            var presel = "";
            $("#" + item.Key, "#cs-popup").find("option:selected").each(function () {
                presel += "|" + $(this).val() + "|";
            });

            $("#" + item.Key, "#cs-popup").empty();
            for (var j = 0; j < item.Value.length; j++) {
                var selected = "";
                if (item.Value[j].Selected || presel.indexOf("|" + item.Value[j].Value + "|") >= 0) {
                    selected = " selected='selected' ";
                }
                $("#" + item.Key, "#cs-popup").append("<option " + selected + "value='" + item.Value[j].Value + "'>" + item.Value[j].Text + "</option>");
            }
            if (item.Value.length == 0) {
                $("#" + item.Key, "#cs-popup").append("<option  value='0'>-- none --</option>");
            }
            $("#" + item.Key, "#cs-popup").trigger("liszt:updated");
            //call update on this.
            $("#" + item.Key, "#cs-popup").change();
        }
    },
    warnLoseChanges: function () {
        if (gemini_edit.pendingChanges) {
            return "Unsaved changes.";
        }
    },

    hideEditingPopup: function () {
        gemini_edit.includeProjectsField = false;
        // wants to move away from editing?
        if (gemini_edit.pendingChanges) {
            // warn of lost changes
            gemini_popup.modalConfirm("Save changes?", null,
            function () {
                gemini_edit.saveEditing();
            },
            function () {
                gemini_edit.pendingChanges = false;
                gemini_edit.hideEditingPopup();
            });
        }
        else {
            // nothing to save, so dismiss
            $(gemini_edit.popupContainer).hide();
            gemini_edit.pendingChanges = false;
            gemini_edit.editingMode = false;
            gemini_commons.inputKeyHandlerUnbind($(document));
            $('#cs-popup-content', gemini_edit.popupContainer).empty();
            $('#cs-popup-content', gemini_edit.popupContainer).data("jsp", "");

            gemini_keyboard.unbindEscape("#cs-popup #cs-popup-close");
        }
    },
    initEdit: function (issueId, pageType, popupContainer, formContainer, editContainer, refreshFunction) {

        gemini_edit.pageType = pageType;
        gemini_edit.issueId = issueId;
        gemini_edit.popupContainer = popupContainer;
        gemini_edit.formContainer = formContainer;
        gemini_edit.refreshFunction = refreshFunction;
        
        $(editContainer).on("click", '.attribute', gemini_edit.initEditing);
    },
    setProjectFieldDisplay: function (includeProjectField)
    {
        gemini_edit.includeProjectsField = includeProjectField;
    }
};