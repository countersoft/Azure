gemini_add =
{
    pendingChanges: false,
    editingMode: false,
    newItemRenderedCallbackOrig: null,
    newItemRenderedCallback: null,
    newItemCreatedCallback: null,
    newItemBeforeRenderedCallback: null,
    newItemCloseCallback: null,
    hidePlan: false,
    hideProject: false,
    addUrl: false,
    postData: null,

    init: function () {

        gemini_add.addUrl = csVars.WorkspaceUrl;
        gemini_keyboard.initKeyboard();
                
        $("#add-item, #add-item-dropdown").click(function (e)
        {
            if ($(this).attr('data-projects') == '0')
            {
                $("#add-project").click();
                return;
            }
            if ($("#cs-popup-add").is(":visible"))
            {
                gemini_add.hide();
            }
            else
            {
                gemini_keyboard.bindEscape("#cs-popup-add #cs-popup-add-close");

                //$('span[data-tab-id="quick-items"]', '#cs-popup-add').hide();
                gemini_add.hidePlan = true;

                $('span[data-tab-id="full-item"]', '#cs-popup-add').show();

                $('span[data-tab-id="new-project"]', '#cs-popup-add').hide();
                gemini_add.hideProject = true;
                
                gemini_add.show();
            }
        });

        $("#add-project").click(function (e)
        {
            gemini_add.addProject();
        });

        $("#add-workspace").click(function (e)
        {
            gemini_appnav.newWorkspace();
        });

        $("#add-coworker").click(function (e) {
            gemini_add.addCoWorkers();
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

        gemini_ui.destroyHtmlEditor('#cs-popup-add-content .wysiwyg-editor');
        
        gemini_add.newItemRenderedCallback = gemini_add.newItemRenderedCallbackOrig;

        gemini_ui.startBusy('#cs-popup-add #cs-popup-add-save');

        gemini_edit.triggerXHR = gemini_ajax.postCall(gemini_add.addUrl + 'item', 'edit?viewtype=' + gemini_commons.PAGE_TYPE.Item, function (response) { gemini_add.populateAddItem(response); gemini_ui.stopBusy('#cs-popup-add #cs-popup-add-save'); }, null, $('#inline-edit-form').serialize(), $('[data-attribute-id="' + $(elem).attr('id') + '"]').parent().parent(), true);
    },

    triggerCustomfieldChange: function (elem)
    {
        var trigger = $(elem).data('customfield-trigger');

        if (trigger == '') return;

        var id = $(elem).attr("id").replace("cf_", "");
        
        var selectedval = "";
        $(elem).find("option:selected").each(function (index) {
            selectedval += $(this).val() + "|";
        });
        if(selectedval.length > 0)
            selectedval = selectedval.slice(0, -1); //remove trailing |

        gemini_ajax.postCall("", "cascade", gemini_add.cascadeUpdate, null,
            {
                fieldid: id, value: selectedval,
                projectid: $("#ProjectName", "#cs-popup-add").find("option:selected").val(),
                issueid: $("#id", "#cs-popup-add").val()
            });
    },

    cascadeUpdate: function (response)
    {
        var data = response.Result.Data;
        
        for (var i = 0; i < data.length; i++) {
            var item = data[i];
            //get preselected list
            
            var presel = "";
            $("#" + item.Key, '#cs-popup-add').find("option:selected").each(function () {
                presel += "|" + $(this).val() + "|";
            });

            $("#" + item.Key, '#cs-popup-add').empty();
            for (var j = 0; j < item.Value.length; j++) {
                var selected = "";
                if (item.Value[j].Selected || presel.indexOf("|" + item.Value[j].Value + "|") >= 0) {
                    selected = " selected='selected' ";
                }
                $("#" + item.Key, '#cs-popup-add').append("<option " + selected + "value='" + item.Value[j].Value + "'>" + item.Value[j].Text + "</option>");
            }

            gemini_ui.chosenUpdate($("#" + item.Key, '#cs-popup-add'));
            //call update on this.
            $("#" + item.Key, '#cs-popup-add').change();
        }
    },

    populateAddItem: function (response)
    {
        if (response.success == null || (response.success != null && response.success)) {

            $('#full-item').html(response);
            $('#cs-popup-add-content').data('jsp').reinitialise({ contentWidth: '700px' });
            setTimeout(function () { $('#cs-popup-add-content').data('jsp').reinitialise({ contentWidth: '700px' }); }, 500);
            $(".checked-select", '#cs-popup-add-content').jScrollPane({});

            gemini_ui.datePicker('#cs-popup-add-content .datepicker');
            $('select:not(.no-chosen)', '#cs-popup-add-content').chosen({ stay_open: true, topmost_container: '#cs-popup-add-content .jspPane:first', fix_popup: false /*'#cs-popup-add-content .jspPane:first'*/ });
            gemini_ui.ajaxChosen('#cs-popup-add-content select.no-chosen.auto-complete-chosen', '#cs-popup-add-content .jspPane:first', false);
            $('input', '#full-item').change(gemini_add.setPendingChanges);
            $('input[type=text]', '#full-item').keyup(gemini_add.setPendingChanges);
            $('select', '#full-item').change(gemini_add.setPendingChanges);

            $('#cs-popup-add-content').find('*[data-trigger]').change(function (index) {
                gemini_add.triggerChange(this);
            });

            $('#cs-popup-add-content').find('*[data-customfield-trigger]').change(function (index) {
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
            //$('.chosen-results', '#cs-popup-add-content').jScrollPane({});
            gemini_ui.htmlEditor('.wysiwyg-editor', /*gemini_edit.onHtmlEditorInit*/null, gemini_add.setPendingChanges);
            gemini_ui.userAutocomplete('#cs-popup-add-content .user-autocomplete');

            // Mark descriptions for textareas as vertical-align top
            $("#full-item #inline-edit-form tr").each(function () {
                if ($(this).find("textarea").length > 0) $("td:eq(0)", $(this)).css("vertical-align", "top");
            });

            var options = {
                dataType: "json",
                success: function (responseText, statusText, xhr, $form) {
                    if (responseText.success)
                    {
                        gemini_add.postIssueCreate(responseText);
                        gemini_ui.destroyHtmlEditor("#cs-popup-add-content .wysiwyg-editor");
                    }
                    else
                    {
                        $('#server-validation-error', '#cs-popup-add').html(responseText.Message).show();
                    }
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
                gemini_add.newItemRenderedCallbackOrig = gemini_add.newItemRenderedCallback;
                gemini_add.newItemRenderedCallback = null;
            }
            $("#inline-edit-form input[type='text']:first").focus();

            gemini_ui.fancyInputs('#inline-edit-form .fancy');
        }
        else
        {
            gemini_add.hide();
        }
    },

    show: function () {
        var oldProjectUrl = gemini_add.addUrl;
        if (gemini_add.newItemBeforeRenderedCallback) {
            gemini_add.newItemBeforeRenderedCallback();
            gemini_add.newItemBeforeRenderedCallback = null;
        }
        gemini_ajax.postCall(gemini_add.addUrl, "item/edit?viewtype=" + gemini_commons.PAGE_TYPE.Item, gemini_add.populateAddItem, null, gemini_add.postData, null, true);
        gemini_add.postData = null;
        gemini_add.addUrl = oldProjectUrl;
        gemini_add.showContent();
    },

    showContent: function ()
    {
        window.onbeforeunload = gemini_add.warn;
        $('#cs-popup-add-content').html('<div id="cs-template"></div><div id="full-item" class="tab-content"></div><div id="new-project" class="tab-content hide"></div></div>');
        $('#cs-popup-add').show();
        $('#cs-popup-add-zone').show();
                
        var availableHeight = gemini_sizing.availableHeight();
        $('#cs-popup-add').css("height", availableHeight+40);
        $('#cs-popup-add').css("width", "820px");

        var contentHeight = availableHeight + 40 - $('#cs-popup-add-buttons').height() - 60;
        /*$("#cs-popup-add-content").jScrollPane({ contentWidth: '700px' });

        //Hack alert
        $('.jspContainer', '#cs-popup-add-content').css("height", contentHeight);*/
        


        /***/
        $("#cs-popup-add").css("display", "block"); //ensure the div stays this width if content inside is changed
        var params = {
            inline: true,
            href: "#cs-popup-add",
            transition: "none",
            /*initialWidth: "850px",
            initialHeight: "530px",*/
            width: "820px",
            height: availableHeight + 40,
            overlayClose: false,
            escKey: false,
            opacity: '0.8',
            onComplete: function () {
                $("#cs-popup-add-content").jScrollPane({ contentWidth: '700px' });

                //Hack alert
                $('.jspContainer', '#cs-popup-add-content').css("height", contentHeight);
            }
        };
        $.colorbox(params);
        /***/
        


        $('#cs-popup-add .tabs span.tab').removeClass("selected").addClass('normal');
        $('#cs-popup-add .tabs span.tab:eq(0)').removeClass('normal').addClass("selected");

        $('input', '#cs-popup-add').change(gemini_add.setPendingChanges);
        $('input[type=text]', '#cs-popup-add').keyup(gemini_add.setPendingChanges);
        $('select', '#cs-popup-add').change(gemini_add.setPendingChanges);
        $("#cs-popup-add-save").unbind("click");
        $("#cs-popup-add-close").unbind("click");

        $("#cs-popup-add-save").click(gemini_add.save);
        $("#cs-popup-add-close").click(gemini_add.hide);

        $('.tab', '#cs-popup-add').disableSelection();
        $('.tab', '#cs-popup-add').click(function () {
            $('.tab', '#cs-popup-add').addClass("normal").removeClass('selected');
            $(this).removeClass('normal').addClass("selected");
            $('.tab-content', '#cs-popup-add-content').hide();
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


        /*$("#quick-items").liManipulator({
            debug: false,
            events: {
                onAddText: gemini_add.setPendingChanges
            }
        });*/

        /*$('#quick-items input').attr('placeholder', 'Issue');*/

        $("#cs-popup-add-buttons .button-popup").css('width', '');
        gemini_sizing.sameWidth("#cs-popup-add-buttons .button-popup", 10);

        $('.tab:not(":hidden")', '#cs-popup-add').click();
    },

    setPendingChanges: function ()
    {
        gemini_add.pendingChanges = true;
        $('#cs-popup-add-content').data('jsp').reinitialise({ contentWidth: '700px' });
    },

    save: function () {
        $('#server-validation-error', '#cs-popup-add').hide();

        //if ($("#quick-items .limTextContainer input").length > 0 && $.trim($("#quick-items .limTextContainer input").val()) != "") {
        //    var val = $("#quick-items .limTextContainer input").val();
        //    $("#quick-items .limTextContainer").parent().html("<div><span class='fonticon-drag-handle valign-text-bottom margin-right-5' style='color:#C4C4C4;'></span>" + val + "</div>");
        //}

        var fullItem = $('.tab[data-tab-id="full-item"]', '#cs-popup-add-zone').hasClass('selected');
        var project = $('.tab[data-tab-id="new-project"]', '#cs-popup-add-zone').hasClass('selected');
        var valid = !(fullItem) || $("#inline-edit-form", '#cs-popup-add').valid();
       // var data = $("#quick-items").liManipulator("data");
        //var isQuickItems = $('#quick-items').is(':visible');
        //if (data.length > 0) {
        //    if (isQuickItems) gemini_ui.startBusy('#cs-popup-add #cs-popup-add-save');
        //    gemini_ajax.postCall(gemini_add.addUrl + "items", "dump/SaveItemDump", function (response) {
        //        if (valid && response.Success) {
        //            gemini_add.postIssueCreate(response);
        //        }
        //        //if (isQuickItems) gemini_ui.stopBusy('#cs-popup-add #cs-popup-add-save');
        //    }, function () { /*if (isQuickItems) gemini_ui.stopBusy('#cs-popup-add #cs-popup-add-save');*/ }, { items: JSON.stringify(data) }, null, true);

        //}
        if (fullItem) {
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
        else if (project) {
            gemini_add.pendingChanges = false;
            if ($("#new-project-form", '#cs-popup-add').valid()) {
                gemini_ui.startBusy('#cs-popup-add #cs-popup-add-save');
                $("#new-project-form", '#cs-popup-add').submit();
            }
            else {
                $('.error', '#cs-popup-add').first().focus();
            }
        }
    },

    postIssueCreate: function (data)
    {
        /*** WIZARD ***/
        if (gemini_wizard.active)
        {
            $.publish('wizard-action', ['issuecreated']);
        }

        $.publish('issue-create', [data.Result.Item.Id]);

         /*** WIZARD ***/
        gemini_add.pendingChanges = false;
        gemini_add.hide();

        if ($('#pager-next').length > 0) {
            var currentPage = $('#pager-next').data('page') - 1;

            if (currentPage < 0) currentPage = 0;

            gemini_filter.getFilteredItemsPage(currentPage);
        }
        else if ($('#data.items-data-container img').length > 0)
        {
            gemini_filter.getFilteredItemsPage(0); // Refresh the filter when we have the "no items" image and the grid is hidden
        }

        gemini_notifications.fetchLastItem();

        if (gemini_add.newItemCreatedCallback)
        {
            gemini_add.newItemCreatedCallback(data.Result.Item.Id);
            gemini_add.newItemCreatedCallback = null;
        }
    },

    warn: function () {
        if (gemini_add.pendingChanges) {
            return "Unsaved changes.";
        }
    },

    hide: function () {
        $('#server-validation-error', '#cs-popup-add').hide();
        // wants to move away from editing?
        if (gemini_add.pendingChanges) {
            // warn of lost changes
            //$('#cs-popup-add').hide();
            //gemini_popup.sameConfirmWidth();
            gemini_commons.translateMessage("[[SaveChanges]]", ['SaveChanges'], function (message) {
            
                gemini_popup.modalConfirm(message + "?", null,
                function () {
                    gemini_add.save();
                },
                function () {
                    gemini_add.pendingChanges = false;
                    gemini_add.hide();

                });
            });
        }
        else {
            // nothing to save, so dismiss
            gemini_ui.destroyHtmlEditor("#cs-popup-add-content .wysiwyg-editor");
            $('#cs-popup-add').hide();
            gemini_add.pendingChanges = false;
            gemini_add.editingMode = false;

            $('#cs-popup-add-content').empty();
            $('#cs-popup-add-content').data("jsp", "");

            gemini_keyboard.unbindEscape("#cs-popup-add #cs-popup-add-close");
            $.colorbox.close();
        }

        if (gemini_add.newItemCloseCallback) {
            gemini_add.newItemCloseCallback();
            gemini_add.newItemCloseCallback = null;
        }
    },

    initNewProjectWizard: function ()
    {
        $('li', '#new-project-wizard').click(function () {
            $('li', '#new-project-wizard').removeClass('selected');
            $('.title', '#template-details').html($(this).data('title'));
            $('.description', '#template-details').html($(this).data('description'));
            $(this).addClass('selected');
            $("#new-project-form input[type='text']:first").focus();
            $('#cloud-component', '#template-cloud').html($(this).data('component'));
            $('#cloud-version', '#template-cloud').html($(this).data('version'));
            $('#cloud-item', '#template-cloud').html($(this).data('item'));
            $('#cloud-resource', '#template-cloud').html($(this).data('resource'));
            $('#cloud-type', '#template-cloud').html($(this).data('type'));
            $('#cloud-status', '#template-cloud').html($(this).data('status'));
            $('#id', '#new-project-form').val($(this).data('id'));
        });

        $('li:first', '#new-project-wizard').click();
        $('#new-project-form').validate({});

        if (!Modernizr.input.placeholder) {
            $("#new-project-form input[type=text]").each(function () {
                if ($(this).attr("placeholder") != "") {

                    $(this).addClass("search_box_placeholder");

                    if ($(this).val() == '') $(this).val($(this).attr("placeholder"));
                    $(this).focus(function () {
                        if ($(this).val() == $(this).attr("placeholder")) $(this).val("");
                        $(this).removeClass("search_box_placeholder");
                    });

                    $(this).blur(function () {
                        if ($(this).val() == "") {
                            $(this).val($(this).attr("placeholder"));
                            $(this).addClass("search_box_placeholder");
                        }
                    });
                }
            });
        }
    },

    addCoWorkers: function () {
        $("#cs-popup-center-content").css("width", "615px");
        $("#cs-popup-center-content").css("height", "370px");

        var add = "Save";

        gemini_commons.translateMessage("[[Send]]", ['Send'], function (message) {
            add = message;

            gemini_popup.centerPopup('coworkers', 'show', null, null, add, null, null, null,
                function ()
                {
                    $("#popup-button-no", "#cs-popup-center").click(function (e)
                    {
                        gemini_popup.popupClose(e);
                    });

                    $("#popup-button-yes", "#cs-popup-center").click(function (e)
                    {
                        if ($(".popup-header #regular-form").valid())
                        {
                            
                            gemini_ajax.postCall('coworkers', 'add', function (response)
                            {
                                
                            }, null, $('#regular-form').serialize(), null, true);

                            gemini_popup.popupClose(e);
                        }
                    });

                    $("#Key", "#cs-popup-center").focus();
                    $(".popup-header #regular-form").validate();

                    // Fix for browsers (i.e IE9) which don't support placeholder attribute
                    if (!Modernizr.input.placeholder)
                    {
                        $("#edit-appnav-card input[type=text]").each(function ()
                        {
                            gemini_ui.legacyPlaceholder($(this));
                        });
                    }

                }, true
            );
        });
    },

    addProject: function () {
        $("#cs-popup-center-content").css("width", "850px");
        $("#cs-popup-center-content").css("height", "550px");

        var add = "Add";

        gemini_commons.translateMessage("[[Add]],[[Cancel]]", ['Add', 'Cancel'], function (message) {
           
            var translations = message.split(",");
            add = translations[0];
            cancel = translations[1];

            gemini_popup.centerPopup('', 'wizard', null, null, add, cancel, null, null,
                function ()
                {
                    $("#popup-button-no", "#cs-popup-center").click(function (e) {
                        gemini_popup.popupClose(e);
                    });

                    $("#popup-button-yes", "#cs-popup-center").click(function (e) {
                        if ($("#new-project-form").valid()) {

                            gemini_ajax.postCall('wizard', 'save', function (response) {
                                if(response.success)
                                {
                                    window.location.href = response.Result.Data;
                                }
                            }, null, $('#new-project-form').serialize());

                            gemini_popup.popupClose(e);
                        }
                    });

                    $("input:first", "#cs-popup-center").focus();
                    $("#new-project-form",'#new-project-wizard').validate();

                    // Fix for browsers (i.e IE9) which don't support placeholder attribute
                    if (!Modernizr.input.placeholder) {
                        $("#new-project-wizard input[type=text]").each(function () {
                            gemini_ui.legacyPlaceholder($(this));
                        });
                    }

                }
            );
        });
    },

    showADData: function(element)
    {
        $(element).addClass('auto-popup-keep');
        if($('#reported-by-ad-details').length)
        {
            $('#reported-by-ad-details').remove();
            return;
        }
        
        var reportedBy = $('#' + $(element).attr('data-id'), $(element).parent()).val();
        var project = $('#ProjectName').length ? $('#ProjectName').val() : 0;
        var issue = $('#Id', '#inline-edit-form').length ? $('#Id', '#inline-edit-form').val() : 0;

        gemini_ajax.postCall('user', 'action/addetails', function(response)
        {
            if(response.success)
            {
                var hide = "$('#reported-by-ad-details').remove()";
                var showOn = $('#' + $(element).attr('data-id'), $(element).parent()).next();
                $('<div id="reported-by-ad-details" class="field-extra-details-info auto-popup" style="top:' + (showOn.position().top + showOn.height() + 4) + 'px;left:' + showOn.position().left + 'px;" data-hide-func="' + hide + '">' + response.Result.Data + '</div>').insertAfter($(element));
            }
        }, null, { userId: reportedBy, projectId: project, issueId: issue });
    }
};

