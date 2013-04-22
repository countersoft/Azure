gemini_add = {

    pendingChanges: false,
    editingMode: false,
    newItemRenderedCallback: null,
    newItemCreatedCallback: null,
    init: function () {

        gemini_keyboard.initKeyboard();

        $("#plus-header").click(function (e) {
            if ($(".fonticon-plus", $(this)).length > 0) {
                if ($("#cs-popup-add").is(":visible")) {
                    $(".fonticon-plus", $(this)).removeClass("selected");
                    gemini_add.hide();

                } else {                  
                    $(".fonticon-plus", $(this)).addClass("selected");

                    gemini_keyboard.bindEscape("#cs-popup-add #cs-popup-add-close");
                    gemini_add.show();
                }
            }
        });
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

        gemini_ui.destroyHtmlEditor('.wysiwyg-editor');
        gemini_edit.triggerXHR = gemini_ajax.postCall(csVars.ProjectUrl + "edit", gemini_commons.PAGE_TYPE.Item, gemini_add.populateAddItem, null, $('#inline-edit-form').serialize(), $('[data-attribute-id="' + $(elem).attr('id') + '"]').parent().parent());
    },
    triggerCustomfieldChange: function (elem) {
        var trigger = $(elem).data('customfield-trigger');

        if (trigger == '') return;

        var id = $(elem).attr("id").replace("cf_", "");
        
        var selectedval = "";
        $(elem).find("option:selected").each(function (index) {
            selectedval += $(this).val() + "|";
        });
        if(selectedval.length > 0)
            selectedval = selectedval.slice(0, -1); //remove trailing |

        gemini_ajax.postCall("project", "cascadeddata", gemini_add.cascadeUpdate, null,
            {
                fieldid: id, value: selectedval,
                projectid: $("#ProjectName", "#cs-popup-add").find("option:selected").val(),
                issueid: $("#id", "#cs-popup-add").val()
            });
    },
    cascadeUpdate: function (response) {
        var data = response.Result.Data;
        
        for (var i = 0; i < data.length; i++) {
            var item = data[i];
            //get preselected list
            
            var presel = "";
            $("#" + item.Key).find("option:selected").each(function () {
                presel += "|" + $(this).val() + "|";
            });

            $("#" + item.Key).empty();
            for (var j = 0; j < item.Value.length; j++) {
                var selected = "";
                if (item.Value[j].Selected || presel.indexOf("|" + item.Value[j].Value + "|") >= 0) {
                    selected = " selected='selected' ";
                }
                $("#" + item.Key).append("<option " + selected + "value='" + item.Value[j].Value + "'>" + item.Value[j].Text + "</option>");
            }
            $("#" + item.Key).trigger("liszt:updated");
            //call update on this.
            $("#" + item.Key).change();
        }
    },
    populateAddItem: function (response) {
        $('#full-item').html(response);
        $('#cs-popup-add-content').data('jsp').reinitialise({ contentWidth: '700px' });
        $(".checked-select", '#cs-popup-add-content').jScrollPane({});

        gemini_ui.datePicker('#cs-popup-add-content .datepicker');
        $('select:not(.no-chosen)', '#cs-popup-add-content').chosen({ stay_open: true, topmost_container: null, fix_popup: true /*'#cs-popup-add-content .jspPane:first'*/ });
        $('input', '#full-item').change(gemini_add.setPendingChanges);
        $('input[type=text]', '#full-item').keyup(gemini_add.setPendingChanges);
        $('select', '#full-item').change(gemini_add.setPendingChanges);

        $('#cs-popup-add-content').find('*[data-trigger]').change(function (index) {
            gemini_add.triggerChange(this);
        });

        $('#cs-popup-add-content').find('*[data-customfield-trigger]').change(function(index) {
            gemini_add.triggerCustomfieldChange(this);
        });

        $('#cs-popup-add-content').find('*[data-customfield-trigger]').each(function (index) {
            if ($(this).data("customfield-trigger") == "P") {
                
                gemini_add.triggerCustomfieldChange(this);
            }
        });

        /*$("#inline-edit-form", '#cs-popup-add').validate({
            ignoreTitle: true,
            submitHandler: function (form) {
                return false;
                //gemini_add.save();
            }
        });*/
        $('.chzn-results', '#cs-popup-add-content').jScrollPane({});
        gemini_ui.htmlEditor('.wysiwyg-editor', /*gemini_edit.onHtmlEditorInit*/null, gemini_add.setPendingChanges);
        gemini_ui.userAutocomplete('#cs-popup-add-content .user-autocomplete');

        // Mark descriptions for textareas as vertical-align top
        $("#full-item #inline-edit-form tr").each(function () {
            if ($(this).find("textarea").length > 0) $("td:eq(0)", $(this)).css("vertical-align", "top");
        });

        var options = {
            dataType: "json",
            success: function (responseText, statusText, xhr, $form) {
                if (responseText.success) gemini_add.postIssueCreate(responseText);
                gemini_ui.stopBusy('#cs-popup-add #cs-popup-add-save');

            },
            error: function (e, data) {
                gemini_ui.stopBusy('#cs-popup-add #cs-popup-add-save');
                gemini_popup.toast("Item could not be created", true);
            }// post-submit callback  

        };
        $("#inline-edit-form", '#cs-popup-add').ajaxForm(options);

        if (gemini_add.newItemRenderedCallback) {
            gemini_add.newItemRenderedCallback();
            gemini_add.newItemRenderedCallback = null;
        }
    },

    show: function () {
        gemini_ajax.postCall(csVars.ProjectUrl + "edit", gemini_commons.PAGE_TYPE.Item, gemini_add.populateAddItem);

        window.onbeforeunload = gemini_add.warn;
        $('#cs-popup-add-content').html('<div id="cs-template"><div id="quick-items" class="nestedSortable pill-content hide"></div><div id="full-item" class="pill-content"></div></div>');
        $('#cs-popup-add').show();
        $('#cs-popup-add-zone').show();

        $('#cs-popup-add').position({
            "my": "right top",
            "at": "right bottom",
            "of": $('#plus-header'),
            "offset": "0 -1",
            "collision": "none"
        });

        var availableHeight = gemini_sizing.availableHeight();
        $('#cs-popup-add').css("height", availableHeight/*$(window).height() - $('#cs-popup-add').position().top - 30*/);

        var contentHeight = availableHeight - $('#cs-popup-add-buttons').height() - 60;
        $("#cs-popup-add-content").jScrollPane({ /*autoReinitialise: true, autoReinitialiseDelay: 250,*/ contentWidth: '700px' });

        //Hack alert
        $('.jspContainer', '#cs-popup-add-content').css("height", contentHeight);

        $('#cs-popup-add .cs-pills span').removeClass("cs-pill-active");
        $('#cs-popup-add .cs-pills span:eq(0)').addClass("cs-pill-active");

        $('input', '#cs-popup-add').change(gemini_add.setPendingChanges);
        $('input[type=text]', '#cs-popup-add').keyup(gemini_add.setPendingChanges);
        $('select', '#cs-popup-add').change(gemini_add.setPendingChanges);
        $("#cs-popup-add-save").unbind("click");
        $("#cs-popup-add-close").unbind("click");

        $("#cs-popup-add-save").click(gemini_add.save);
        $("#cs-popup-add-close").click(gemini_add.hide);

        $('.cs-pill', '#cs-popup-add').disableSelection();
        $('.cs-pill', '#cs-popup-add').click(function () {
            $('.cs-pill', '#cs-popup-add').addClass("cs-pill-inactive").removeClass('cs-pill-active');
            $(this).addClass("cs-pill-active");
            $('.pill-content', '#cs-popup-add-content').hide();
            $('#' + $(this).data('tab-id')).show();
            $('#cs-popup-add-content').data('jsp').reinitialise({ contentWidth: '700px' });
        });

        /*$("#cs-popup-add-zone").csTabs({
            classes: {
                tabContainer: "cs-pills",
                tabItem: "cs-pill",
                tabActive: "cs-pill-active",
                tabUnactive: "cs-pill-unactive"
            },
            tabContentSelectorAttribute: "data-tab-id"
        });*/


        $("#quick-items").liManipulator({
            debug: false,
            events: {
                onAddText: gemini_add.setPendingChanges
            }
        });
    },

    setPendingChanges: function () {
        gemini_add.pendingChanges = true;
        $('#cs-popup-add-content').data('jsp').reinitialise({ contentWidth: '700px' });
    },

    save: function () {

        if ($("#quick-items .limTextContainer input").length > 0 && $.trim($("#quick-items .limTextContainer input").val()) != "") {
            var val = $("#quick-items .limTextContainer input").val();
            $("#quick-items .limTextContainer").parent().html("<div><span class='fonticon-drag-handle valign-text-bottom margin-right-5' style='color:#C4C4C4;'></span>" + val + "</div>");
        }

        var valid = !($('#full-item').is(':visible')) || $("#inline-edit-form", '#cs-popup-add').valid();
        var data = $("#quick-items").liManipulator("data");
        var isQuickItems = $('#quick-items').is(':visible');
        if (data.length > 0) {
            if (isQuickItems) gemini_ui.startBusy('#cs-popup-add #cs-popup-add-save');
            gemini_ajax.postCall(csVars.ProjectUrl + "items", "dump/SaveItemDump", function (response) {
                if (valid && response.Success) {
                    gemini_add.postIssueCreate(response);
                }
                if (isQuickItems) gemini_ui.stopBusy('#cs-popup-add #cs-popup-add-save');
            }, function () { if (isQuickItems) gemini_ui.stopBusy('#cs-popup-add #cs-popup-add-save'); }, { items: JSON.stringify(data) });

        }
        if ($('#full-item').is(':visible')) {
            // Save new item
            if ($("#inline-edit-form", '#cs-popup-add').valid()) {
                gemini_ui.startBusy('#cs-popup-add #cs-popup-add-save');
                //gemini_ajax.postCall(csVars.ProjectUrl + "save", gemini_commons.PAGE_TYPE.Item, gemini_item.refresh, null, $('#inline-edit-form', '#cs-popup-add').serialize());
                $("#inline-edit-form", '#cs-popup-add').submit();
                //gemini_ajax.postCall(csVars.ProjectUrl + "save", gemini_commons.PAGE_TYPE.Item, gemini_add.postIssueCreate, null, $('#inline-edit-form', '#cs-popup-add').serialize());
            }
            else {
                $('.error', '#cs-popup-add').first().focus();
            }
        }
    },

    postIssueCreate: function (data) {
        gemini_add.pendingChanges = false;
        gemini_add.hide();

        gemini_ajax.postCall("account", "actions", function (response) {
            $("#user-actions-history-box").html(response.Result.Data);

            if ($('#pager-next').length > 0) {
                var currentPage = $('#pager-next').data('page') - 1;
                if (currentPage < 0) currentPage = 0;
                gemini_filter.getFilteredItemsPage(currentPage);
            }

            gemini_ui.flashContent("#user-actions-history-box");
        }, null);

        if (gemini_add.newItemCreatedCallback)
            gemini_add.newItemCreatedCallback(data.Result.Item.Id);
    },

    warn: function () {
        if (gemini_add.pendingChanges) {
            return "Unsaved changes.";
        }
    },

    hide: function () {
        // wants to move away from editing?
        if (gemini_add.pendingChanges) {
            // warn of lost changes
            gemini_popup.modalConfirm("Save changes?", null,
            function () {
                gemini_add.save();
            },
            function () {
                gemini_add.pendingChanges = false;
                gemini_add.hide();

            });
        }
        else {
            // nothing to save, so dismiss
            $('#cs-popup-add').hide();
            $(".fonticon-plus", $("#plus-header")).removeClass("selected");
            gemini_add.pendingChanges = false;
            gemini_add.editingMode = false;
            //gemini_commons.inputKeyHandlerUnbind($(document));

            $('#cs-popup-add-content').empty();
            $('#cs-popup-add-content').data("jsp", "");

            gemini_keyboard.unbindEscape("#cs-popup-add #cs-popup-add-close");
        }

    }
};