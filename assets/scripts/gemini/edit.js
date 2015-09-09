gemini_edit = {
    //var $th = $td.closest('table').find('th').eq($td.index());
    pageType: 0,
    popupContainer: '',
    formContainer: '',
    pendingChanges: false,
    editingMode: false,
    useInlineEdit: true,
    issueId: 0,
    triggerXHR: null,
    refreshFunction: null,
    clickedElement: null,
    includeProjectsField: false,
    editItemRenderedCallback:null,
    inlineEditSaveCallback: null,
    pendingHtmlChanges: false,
    inlineEditingRequestPending: false,
    initEditing: function (elm, inlineEditing) {
        if (gemini_edit.inlineEditingRequestPending) return;

        inlineEditSaveCallback = null;
 
        if (!gemini_edit.editingMode)
        {
            window.onbeforeunload = gemini_edit.warnLoseChanges;

            if (gemini_edit.hasInlineEditFieldChanged())
            {
                gemini_commons.translateMessage("[[SaveChanges]]", ['SaveChanges'], function (message) {
                    gemini_popup.modalConfirm(message + "?", null,
                        function () {
                            gemini_edit.inlineEditSaveCallback = function () { gemini_edit.initEditingFinal($('li[data-attribute-id=' + $('.attribute-header', elm).attr("data-attribute-id") + ']'), inlineEditing); };
                            gemini_edit.saveEditingField();
                        },
                        function () {
                            gemini_edit.initEditingFinal(elm, inlineEditing);
                        });
                });
            }
            else
                gemini_edit.initEditingFinal(elm, inlineEditing);
        }
        else {
            gemini_edit.hideEditingPopup();
        }
    },
    initEditingFinal: function (elm, inlineEditing)
    {
        var paramsString = "{}";
        if (gemini_edit.includeProjectsField) paramsString = { includeProjectsField: gemini_edit.includeProjectsField };

        // looking to start editing
        if (gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) {
            gemini_edit.issueId = $(elm).parent().data('issue-id');
        }

        if (gemini_edit.useInlineEdit) {
            if (gemini_edit.pageType == gemini_commons.PAGE_TYPE.Item) {
                var attrElement = $(elm).find('.attribute-header');

                if ($(attrElement).length > 0) elm = attrElement;
            }

            gemini_edit.pendingChanges = false;

            var url = false;
            if (gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) {
                url = csVars.ProjectUrl;
            }
            else {
                url = gemini_item.itemUrl;
            }

            if (inlineEditing) {

                var property = '';

                if (gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) {
                    property = elm.closest('table').find('th').eq(elm.index()).attr('data-id');
                }
                else {
                    property = $(elm).attr('data-attribute-id');
                }

                if (property != "Repeat") {

                    var params = $.extend({},
                    {
                        id: gemini_edit.issueId,
                        property: property
                    }, paramsString);

                    gemini_ajax.postCall("inline", 'get?viewtype=' + gemini_edit.pageType, gemini_edit.showEditingField, null, params, elm);
                }
                else {

                    var params = $.extend({},
                    {
                        id: gemini_edit.issueId
                    },
                    paramsString);

                    gemini_ajax.postCall('item', "edit?viewtype=" + gemini_edit.pageType, gemini_edit.showEditingPopup, null, params, setTimeout(function () { $("#Repeat_Interval").focus(); }, 200));
                }
            }
            else {
                var params = $.extend({},
                {
                    id: gemini_edit.issueId
                },
                paramsString);

                gemini_ajax.postCall('item', "edit?viewtype=" + gemini_edit.pageType, gemini_edit.showEditingPopup, null, params, elm);
            }
        }
        else {
            var params = $.extend({},
                {
                    id: gemini_edit.issueId
                },
                paramsString);

            gemini_edit.pendingChanges = false;
            gemini_ajax.postCall('item', "edit?viewtype=" + gemini_edit.pageType, gemini_edit.showEditingPopup, null, params, elm);
        }
    },

    setPendingChanges: function () {
        gemini_edit.pendingChanges = true;
        $('#cs-popup-content').data('jsp').reinitialise({});
    },

    saveEditing: function () {
        $('#server-validation-error','#cs-popup').hide();
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
                    $('.item-title .title', '#view-item').html(this.Value);
                }
                else if (this.Key == 'reload') {
                    window.location = response.Result.RedirectUrl;
                }
                else if (this.Key == 'AssociatedHistory') {
                    gemini_item.replaceContentContainer('history',this.Value);
                }
                else if (this.Key == 'AssociatedCustomFields')
                {
                    gemini_item.replaceContentContainer('additional', this.Value);
                }
                else if (this.Key == 'AssociatedAttachments')
                {
                    $('#item-attachments').replaceWith(this.Value);
                }
                else if (this.Key == 'EstimatedEffort') {
                    $('.progress-info', '#view-item').replaceWith(this.Value);
                }
                else if (this.Key == 'Description') {
                    $('.description', '#view-item').replaceWith(this.Value);
                }
                else if (this.Key == 'DateCreated') {
                    $('#touch-info-container', '#view-item').html(this.Value);
                    gemini_sizing.sameWidth(".touch-info .box", 10);
                    gemini_item.initSLA();
                }
            });
        }
        else /*if (gemini_edit.pageType == gemini_commons.PAGE_TYPE.Item)*/ {
            // Item grid
            gemini_edit.refreshFunction(response, issueId);
        }
    },
    showInlineEditField: function (response, elm)
    {
        gemini_edit.hideEditingField();
        gemini_edit.hideInlineEditField();

        //this is for inline editing inside div
        if (response.success) {
            var oldvalue = elm.text();

            var resHtml = response.Result.Html;
            while (resHtml.charAt(0) == '\r')
            {
                resHtml = resHtml.replace("\r\n", "");
            }
            var parsedHtml = $(resHtml);

            //Removing unecessary classes, which determine the height and width as we need to set it manually
            parsedHtml.each(function (index, value) {
                if ($(value).hasClass('inline-editing')) {
                    $(value).removeClass('input-tall').attr('class', $(value).attr('class').replace(/\binput-size\d+\b/g, ''));         
                }
            });

            var url = false;
            if (gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) {
                url = csVars.ProjectUrl;
            }
            else {
                url = gemini_item.itemUrl;
            }

            var formText = '<form style="display:inline-block;" method="post" action="' + gemini_ajax.getUrl('inline', 'save?viewtype=' + gemini_edit.pageType) + '"></form>';

            elm.html(formText);
            $('form', elm).append(parsedHtml);

            $('input', $(elm)).focus().data('oldvalue', oldvalue).css('height','22px').css('width','500px').css('font-size','0.8em');

            $('input', $(elm)).blur(function () {
                gemini_edit.hideInlineEditField();
            });

            gemini_commons.inputKeyHandlerUnbind(elm);
            gemini_commons.inputKeyHandler(elm, gemini_edit.saveInlineEditField, gemini_edit.hideInlineEditField);


        }
    },
    saveInlineEditField: function ()
    {
        var elm = $('.inline-editing');

        var form = elm.parents('form:eq(0)');

        if (form.valid()) {
            var data = form.serialize();

            var tempData = data;
            tempData += '&id=' + elm.attr('name') + '&itemid=' + gemini_item.issueId + '&property=' + elm.attr('name');

            var url = false;
            if (gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) {
                url = csVars.ProjectUrl;
            }
            else {
                url = gemini_item.itemUrl;
            }

            gemini_ajax.postCall('inline', 'save?viewtype=' + gemini_edit.pageType, gemini_edit.InlineEditSaveResponse, null, tempData, elm);
        }
    },
    hideInlineEditField: function ()
    {
        //Used for real inline editing, like title or description on view items page
        if ($('.inline-editing').length > 0) {
            var value = $('.inline-editing').data('oldvalue');
            $('.inline-editing').closest('form').parent().text(value);
        }
    },
    showEditingField: function (response, elem)
    {
        gemini_edit.hideEditingField();
        gemini_edit.hideInlineEditField();

        if (response.Success)
        {
            //Setting up new elements size and classes
            var resHtml = response.Result.Html;
            while (resHtml.charAt(0) == '\r') {
                resHtml = resHtml.replace("\r\n", "");
            }
            var parsedHtml = $(resHtml);
            
            var firstInlineElement = false;        
            
            //Removing unecessary classes, which determine the height and width as we need to set it manually
            parsedHtml.each(function (index, value) {               
                if ($(value).hasClass('inline-editing')) {
                    $(value).removeClass('input-tall').attr('class', $(value).attr('class').replace(/\binput-size\d+\b/g, ''));
                    if (!firstInlineElement) firstInlineElement = $(value);
                }
            });
           
            //If input is subchild of another element, then try again here
            if (!firstInlineElement) firstInlineElement = parsedHtml.find('.inline-editing');

            //Ignore Repeat interval
            if (firstInlineElement.attr('id') != 'Repeat_Interval') {
                //Saving old value to reset field if editing is canceled
                elem.data('value', $(elem).html());

                //Mark td as being edited
                elem.addClass('edit-mode');

                var url = false;
                if (gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) {
                    url = csVars.ProjectUrl;
                }
                else {
                    url = gemini_item.itemUrl;
                }

                var formText = '<form method="post" action="' + gemini_ajax.getUrl('inline', 'save?viewtype=' + gemini_edit.pageType) + '" enctype="multipart/form-data"><div class="left"></div></form>';
           
                //Create overlay for elements
                if (firstInlineElement.is('textarea')) {
                    $("#cs-popup-center-content").css("width", "800px");
                    $("#cs-popup-center-content").css("height", "600px");
                    var newContent = '<form action="' + gemini_ajax.getUrl('inline', 'save?viewtype=' + gemini_edit.pageType) + '">' + '<h2 class="margin-bottom-10">' + response.Result.IssueKey + ' ' + response.Result.Property + '</h2>';
                    newContent += response.Result.Html + '</form>';
                    response.Result.Html = newContent;
                 
                    gemini_popup.showCenterPopup(response);
                    $("#colorbox .inline-editing").css('width', '100%');

                    $("#popup-button-no").click(function (e) {
                        elem.removeClass('edit-mode');
                        gemini_popup.popupClose(e);
                        gemini_ui.destroyHtmlEditor("#cs-popup-center-content .wysiwyg-editor");
                        $("#colorbox .inline-editing").closest('form').remove();
                    });

                    $("#popup-button-yes").click(function (e) {
                        gemini_edit.saveEditingField(gemini_edit.issueId);

                        //elem.removeClass('edit-mode');
                        gemini_popup.popupClose(e);
                        gemini_ui.destroyHtmlEditor("#cs-popup-center-content .wysiwyg-editor");
                        $("#colorbox .inline-editing").closest('form').remove();
                    });

                    setTimeout(function () {
                        gemini_ui.htmlEditor("#colorbox .inline-editing", null, "", true, 530, 800);
                        //tinyMCE.execCommand('mceFocus', false, 'DescriptionWysiwygTextarea');
                    }, 50);

                }
                else {
                    
                    //$(elem).append('<div class="inline-edit-dropdown"> ' + formText + '</div>');
                    $('#page-content-zone').append('<div class="inline-edit-dropdown"> ' + formText + '</div>');

                    $('.inline-edit-dropdown form > div', '#page-content-zone').html(parsedHtml);
                  
                    $('.inline-edit-dropdown', '#page-content-zone').append('<div class="dropdown-options right"><div class="fonticon-tick margin-right-10"></div><div class="fonticon-cross"></div></div>');
                   
                    var inputs = $('.inline-edit-dropdown form .inline-editing', '#page-content-zone').length;

                    if (inputs == 1) {
                        $('.inline-edit-dropdown form .inline-editing', '#page-content-zone').css('width', '270px').addClass('left');
                    }
                    else {
                        $('.inline-edit-dropdown form .inline-editing', '#page-content-zone').css('width', (100 / inputs) + 'px');
                    }
                   
                    var pageWidth = $(window).width();
                    var elementWidth = 350;
                    var elementLeft = $(elem).position().left;

                    //Usually position from left to right, except when there is no space on the right side.
                    var positionX = 'left';
                    if (pageWidth - (elementWidth + elementLeft) < 0) {
                        positionX = 'right';
                    }

                    //If last column position above row. Default is below row.
                    var positionY1 = 'top'
                    var positionY2 = 'bottom'

                    if ($(elem).closest("tr").is(":last-child")) {
                        positionY1 = 'bottom';
                        positionY2 = 'top';
                    }

                    $('.inline-edit-dropdown', '#page-content-zone').position({
                        "my": positionX + " " + positionY1,
                        "at": positionX + " " + positionY2,
                        "of": $(elem),
                        "offset": "0 0",
                        "collision": "none"
                    });
                  
                    $('#page-content-zone .inline-edit-dropdown .fonticon-cross').unbind('click').click(function () {
                        gemini_edit.hideEditingField();
                    });

                    $('#page-content-zone .inline-edit-dropdown .fonticon-tick').unbind('click').click(function () {                      
                        gemini_edit.saveEditingField();
                    });

                }

                //Assigning events to input/select and textboxes.
                var currentInput;
                
                if ($('.inline-edit-dropdown form  input:not(:hidden)', '#page-content-zone').length > 0) {
                    var input = $('.inline-edit-dropdown form  input:not(:hidden)', '#page-content-zone');
                    currentInput = input;
                    gemini_edit.applyFieldFunctionality(input);
                }
                
                if ($('.inline-edit-dropdown form  select', '#page-content-zone').length > 0) {
                    var select = $('.inline-edit-dropdown form  select', '#page-content-zone');
                    currentInput = select;
                    gemini_edit.applyFieldFunctionality(select);
                }
                  
                if ($('.inline-edit-dropdown form  textarea', '#page-content-zone').length > 0) {
                    var textarea = $('.inline-edit-dropdown form  textarea', '#page-content-zone');
                    currentInput = textarea;
                    gemini_edit.applyFieldFunctionality(textarea);
                }
              
                firstInlineElement.focus();          

            }
        }
    },
    InlineEditSaveResponse: function (response)
    {
        if (response.success) {

            if (gemini_edit.pageType == gemini_commons.PAGE_TYPE.Item) {
                var reloading = false;

                if (response.Result.Extra) {
                    $(response.Result.Extra).each(function (key, value) {
                        if (this.Key == 'reload') {
                            reloading = true;
                            gemini_edit.hideInlineEditingSpinner();

                            gemini_edit.hideEditingField();
                            gemini_edit.hideInlineEditField();

                            window.location = response.Result.RedirectUrl;
                        }                       
                        else if (this.Key == 'AssociatedHistory' && ! reloading) {
                            gemini_item.replaceContentContainer('history', this.Value);
                        }
                    else if (this.Key == 'AssociatedCustomFields' && ! reloading)
                            {
                                gemini_item.replaceContentContainer('additional', this.Value);
                            }
                        else if (this.Key == 'Title' && ! reloading) {
                            $('.item-title .title', '#view-item').html(this.Value);
                        }
                    else if (this.Key == 'EstimatedEffort' && ! reloading) {
                            $('.progress-info', '#view-item').replaceWith(this.Value);
                    }
                    else if (this.Key == 'Description') {
                        $('.description', '#view-item').replaceWith(this.Value);
                    }
                    else if (this.Key == 'DateCreated') {
                        $('#touch-info-container', '#view-item').html(this.Value);
                        gemini_sizing.sameWidth(".touch-info .box", 10);
                        gemini_item.initSLA();
                    }
                        
                    });
                }
                if (response.Result.Html && response.Result.Html.length > 0 && !reloading) {
                    $('#item-attributes').html(response.Result.Html);
                }
              
            }
            else {                                
                gemini_edit.refreshFunction(response, response.Result.ItemId);
            }

            if (gemini_edit.inlineEditSaveCallback)
            {
                gemini_edit.inlineEditSaveCallback();
                gemini_edit.inlineEditSaveCallback = null;
            }

            gemini_edit.hideInlineEditingSpinner();

            gemini_edit.hideEditingField(true);
            $.publish('issue-update', [response.Result.ItemId, gemini_edit.pageType]);
        }
        else
        {
            if (gemini_edit.inlineEditSaveCallback) {
                gemini_edit.inlineEditSaveCallback();
                gemini_edit.inlineEditSaveCallback = null;
            }

            if (response.Message && response.Message.length)
            {
                gemini_popup.toast(response.Message, true);
            }
            else
            {
                gemini_popup.toast("Couldn't save changes", true);
            }

            gemini_edit.hideInlineEditingSpinner();
        }
    },
    saveEditingFieldSelect: function (elem) {
        if (elem.parent().find('.chosen-drop').position().left < 0) {
            gemini_edit.saveEditingField();
        }
    },
    cancelInlineEditFieldSelect: function (elem) {
        if (elem.parent().find('.chosen-drop').position().left < 0) {
            gemini_edit.hideEditingField();
        }
    },
    saveEditingField: function (issueId) {
        
        var elm = $('.inline-editing');    
        var form = elm.parents('form:eq(0)');

        var elementIssueId = (gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) ? $('#tabledata tbody td.edit-mode').parent().attr('data-issue-id') : gemini_edit.issueId;

        //Fixes IE8 bug where form.valid() thinks chosen search field is required
        form.validate({ ignore: ".chosen-search input, .search-field input" });
   
        if (form.valid()) {
            if (gemini_edit.inlineEditingRequestPending) return;

            gemini_edit.showInlineEditingSpinner();

            var data = form.serialize();
          
            var currentItem = (issueId != null) ? issueId : elementIssueId;
           
            var items = [currentItem];
            var bulk = false;
            if ($('.checked-items:checked', $('#items-grid')).length > 0) {
                /*** WIZARD ***/
                if (gemini_wizard.active)
                {
                    bulk = $('.checked-items:checked', $('#items-grid')).length > 1;
                }
                /*** WIZARD ***/
                $('.checked-items:checked', $('#items-grid')).each(function (index, value) {
                    if (currentItem != $(value).val()) {
                        items.push($(value).val());
                    }
                });
            }
      
            var url = false;
            if (gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) {
                url = csVars.ProjectUrl;
            }
            else {
                url = gemini_item.itemUrl;
            }

            for (var i in items) {
                if (items[i] > 0) {
                    if (elm.is('input[type="file"]')) {
                        var options = {
                            data: { itemid: items[i], id: elm.attr('name'), property: elm.attr('name') },
                            dataType: "json",
                            type: 'post',
                            success: function (responseText, statusText, xhr, $form) {
                                gemini_edit.InlineEditSaveResponse(responseText);
                            },
                            error: function (e, data) {
                                gemini_edit.hideInlineEditingSpinner();
                            }// post-submit callback   

                        };

                        form.ajaxForm(options);
                        form.submit();
                    }
                    else {
                        var tempData = data;
                        tempData += '&id=' + elm.attr('name') + '&itemid=' + items[i] + '&property=' + elm.attr('name');

                        gemini_ajax.postCall('inline', 'save?viewtype=' + gemini_edit.pageType, gemini_edit.InlineEditSaveResponse, function (response) { gemini_edit.hideInlineEditingSpinner(); }, tempData, elm);

                    }
                }
            }

            /*** WIZARD ***/
            if (gemini_wizard.active)
            {
                if(bulk)
                {
                    $.publish('wizard-action', ['batchupdate']);
                }
            }
            /*** WIZARD ***/
        }
    },
    hideEditingField: function (saved) {

        if (gemini_edit.inlineEditingRequestPending) return;
           
        $('.inline-edit-dropdown', '#page-content-zone').remove();

        if (gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) {
            $('#tabledata tbody td.edit-mode').removeClass('edit-mode');      
        }
        else {
            if ($('#item-attributes li.edit-mode').length > 0) $('#item-attributes li.edit-mode').removeClass('edit-mode');
            if ($('#additional-content tr.edit-mode').length > 0) $('#additional-content tr.edit-mode').removeClass('edit-mode');
        }
    },
    applyFieldFunctionality: function (elm)
    {
        var data_type = elm.attr('data-input-type');
  
        if (elm.is('select')) {
            gemini_ui.chosen('#page-content-zone .inline-edit-dropdown select.inline-editing:not(.no-chosen)', '#page-content-zone', false);
            gemini_ui.ajaxChosen('#page-content-zone .inline-edit-dropdown select.inline-editing.no-chosen.auto-complete-chosen', '#page-content-zone', false);
            var chosenInput = $('#page-content-zone .inline-edit-dropdown select.inline-editing').next();
            chosenInput.addClass('left');
            
            $(elm.next()).focus().mousedown();
            gemini_commons.inputKeyHandler($('.chosen-choices', elm.parent()), function () { gemini_edit.saveEditingFieldSelect(elm); }, function () { gemini_edit.cancelInlineEditFieldSelect(elm); });
            gemini_commons.inputKeyHandler($('.chosen-container', elm.parent()), function () { gemini_edit.saveEditingFieldSelect(elm); }, function () { gemini_edit.cancelInlineEditFieldSelect(elm); });
        }
        else if (elm.is('input') && data_type == 'checkbox')
        {
            $('#page-content-zone .inline-edit-dropdown input[data-input-type="checkbox"]').css('width', 0);
            gemini_ui.fancyInputs('#page-content-zone .inline-edit-dropdown input[data-input-type="checkbox"]');
            $('#page-content-zone .inline-edit-dropdown input[data-input-type="checkbox"]').parent().css('margin-top', '8px');
            gemini_commons.inputKeyHandler(elm, gemini_edit.saveEditingField, gemini_edit.hideEditingField);
        }
        else if (elm.is('input') && data_type == 'date') {
            gemini_ui.datePicker('#page-content-zone .inline-edit-dropdown input[data-input-type="date"]');
            elm.click();
            gemini_commons.inputKeyHandler(elm, gemini_edit.saveEditingField, gemini_edit.hideEditingField);
        }
        else {
            gemini_commons.inputKeyHandler(elm, gemini_edit.saveEditingField, gemini_edit.hideEditingField);
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
        gemini_ui.chosen('#cs-popup-content select:not(.no-chosen)', '#cs-popup-content .jspPane:first', false);
        gemini_ui.ajaxChosen('#cs-popup-content select.no-chosen.auto-complete-chosen', '#cs-popup-content .jspPane:first', false);
        
        $('#cs-popup-content', gemini_edit.popupContainer).data("jsp", "");
        $(gemini_edit.popupContainer).show();

        var availableHeight = gemini_sizing.availableHeight();
        //if(gemini_edit.pageType != gemini_commons.PAGE_TYPE.Item) availableHeight -= 200;
        $(gemini_edit.popupContainer).css("height", availableHeight + 40);
        $(gemini_edit.popupContainer).css("width", '820px');
        var contentHeight = availableHeight + 40 - $('#cs-popup-buttons').height() - 20;
        
        /***/
        var params = {
            inline: true,
            href: gemini_edit.popupContainer,
            transition: "none",
            width: "820px",
            height: availableHeight + 40,
            overlayClose: false,
            escKey: false,
            opacity: '0.8',
            onComplete: function () {
                $(".checked-select").jScrollPane({});

                $("#cs-popup-content", gemini_edit.popupContainer).jScrollPane({});
                $('.jspContainer', '#cs-popup-content').css("height", contentHeight);
                $('.jspPane', '#cs-popup-content').css("min-height", contentHeight - 10);
                gemini_ui.htmlEditor('.wysiwyg-editor', /*gemini_edit.onHtmlEditorInit*/null, gemini_edit.setPendingChanges);
                gemini_ui.userAutocomplete('#cs-popup-content .user-autocomplete');
                $("#cs-popup-content", gemini_edit.popupContainer).jScrollPane('reinitialise');
            }
        };
        $.colorbox(params);
        /***/
        /*
        $(".checked-select").jScrollPane({});
        
        $("#cs-popup-content", gemini_edit.popupContainer).jScrollPane({});
        $('.jspContainer', '#cs-popup-content').css("height", contentHeight);
        $('.jspPane', '#cs-popup-content').css("min-height", contentHeight-10);
        gemini_ui.htmlEditor('.wysiwyg-editor', null, gemini_edit.setPendingChanges);
        gemini_ui.userAutocomplete('#cs-popup-content .user-autocomplete');
        $("#cs-popup-content", gemini_edit.popupContainer).jScrollPane('reinitialise');
        */
        var options = {
            dataType: "json",
            success: function (responseText, statusText, xhr, $form) {
                if (responseText.success)
                {
                    gemini_edit.refresh(responseText, gemini_edit.issueId);
                    $.publish('issue-update', [responseText.Result.Item.Id, gemini_edit.pageType]);
                }
                else
                {
                    $('#server-validation-error', '#cs-popup').html(responseText.Message).show();
                }
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
        
        /*
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
            if (elem.length) {
                var of = $(elem).parent();
                var offset = "0 -500";

                if ($("#planner-box").length > 0) {
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
        }

        var top = $(gemini_edit.popupContainer).position().top;
        var scrollOffset = window.pageYOffset;
        if (scrollOffset > top) {
            $(gemini_edit.popupContainer).css('top', scrollOffset + 'px');
        }*/
        
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

            if ($("#" + attribId, '#cs-popup-content').length != 0) {
                if (!$("*[name='" + attribId + "']", '#cs-popup-content').is('select')) {
                    api.scrollToY($("#" + attribId, '#cs-popup-content').position().top);

                    if (!$("*[name='" + attribId + "'][type!='hidden']", '#cs-popup-content').is(':checkbox')) {
                        $("#" + attribId, '#cs-popup-content').focus().click();
                    }
                    else {
                        $("#" + attribId, '#cs-popup-content').focus();
                    }
                }
                else {
                    api.scrollToY($("#" + attribId + '_chosen', '#cs-popup-content').position().top);
                    $('*[name="' + attribId + '"] + div', '#cs-popup-content').focus().mousedown();
                }

                $("#" + attribId, '#cs-popup-content').parent().addClass("highlight-underline");
                $("#" + attribId, '#cs-popup-content').parent().siblings().addClass("highlight-underline");
            }
            else {
                $("#cs-popup input[type='text']:first").focus();
            }
        }
        else
        {
            var th = $(elem).closest('table').find('th').eq($(elem).index());
            if ($("#" + $(th).data('id'), '#cs-popup-content').length != 0) {

                if (!$("*[name='" + $(th).data('id') + "'][type!='hidden']", '#cs-popup-content').is('select')) {
                    api.scrollToY($("#" + $(th).data('id'), '#cs-popup-content').position().top);
                    //$("#" + $(th).data('id'), '#cs-popup-content').focus().click();
                    if ($("*[name='" + $(th).data('id') + "'][type!='hidden']", '#cs-popup-content').is(':checkbox')) {
                        $("#" + $(th).data('id'), '#cs-popup-content').focus();
                    }
                    else {
                        $("#" + $(th).data('id'), '#cs-popup-content').focus().click();
                    }
                }
                else {
                    api.scrollToY($('*[name="' + $(th).data('id') + '"] + div', '#cs-popup-content').position().top);
                    $('*[name="' + $(th).data('id') + '"] + div', '#cs-popup-content').focus().mousedown();
                }

                $("#" + $(th).data('id'), '#cs-popup-content').parent().addClass("highlight-underline");
                $("#" + $(th).data('id'), '#cs-popup-content').parent().siblings().addClass("highlight-underline");
            }
            else {
                $("#cs-popup input[type='text']:first").focus();
            }
            var tr = $(elem).closest('tr');
            if ($(tr).hasClass('dependant') || $(tr).find('.parent').length == 1) {
                $('.dependant', '#tabledata').remove();
                $('.parent', '#tabledata').removeClass('fonticon-arrow-up').addClass('fonticon-arrow-down');
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


       // $('.chosen-results','#cs-popup-content').jScrollPane({});

        gemini_keyboard.bindEscape("#cs-popup #cs-popup-close");
        gemini_ui.fancyInputs('#inline-edit-form .fancy');
        if(gemini_edit.editItemRenderedCallback)
        {
            gemini_edit.editItemRenderedCallback();
            gemini_edit.editItemRenderedCallback = null;
        }
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

        gemini_ui.destroyHtmlEditor("#cs-popup-content .wysiwyg-editor");

        gemini_ui.startBusy('#cs-popup #cs-popup-save');

        gemini_edit.triggerXHR = gemini_ajax.postCall('item', "edit?viewtype=" + gemini_edit.pageType, function (response) { gemini_edit.showEditingPopup(response); gemini_ui.stopBusy('#cs-popup #cs-popup-save'); }, null, params, $('[data-attribute-id="' + $(elem).attr('id') + '"]').parent().parent());
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

        var pid = null;
        if($('#cs-popup #ProjectName').length) {
            pid= $('#cs-popup #ProjectName').val();
        }
        gemini_ajax.postCall("", "cascade", gemini_edit.cascadeUpdate, null,
            {
                fieldid: id, value: selectedval,
                projectid: pid,
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

            gemini_ui.chosenUpdate($("#" + item.Key, "#cs-popup"));
            //call update on this.
            $("#" + item.Key, "#cs-popup").change();
        }
    },
    warnLoseChanges: function () {
        if (gemini_edit.pendingChanges || gemini_edit.pendingHtmlChanges) {
            return "Unsaved changes.";
        }

        if (gemini_edit.hasInlineEditFieldChanged()) return "Unsaved changes.";
    },

    hideEditingPopup: function () {
        $('#server-validation-error', '#cs-popup').hide();
        gemini_edit.includeProjectsField = false;
        // wants to move away from editing?
        if (gemini_edit.pendingChanges) {
            // warn of lost changes
            //$(gemini_edit.popupContainer).hide();
            //gemini_popup.sameConfirmWidth();
            gemini_commons.translateMessage("[[SaveChanges]]", ['SaveChanges'], function (message) {
                gemini_popup.modalConfirm(message +"?", null,
                function () {
                    gemini_edit.saveEditing();
                },
                function () {
                    gemini_edit.pendingChanges = false;
                    gemini_edit.hideEditingPopup();
                });
            });
        }
        else {
            gemini_ui.destroyHtmlEditor("#cs-popup-content .wysiwyg-editor");
            // nothing to save, so dismiss
            $(gemini_edit.popupContainer).hide();
            gemini_edit.pendingChanges = false;
            gemini_edit.editingMode = false;
            gemini_commons.inputKeyHandlerUnbind($(document));
            $('#cs-popup-content', gemini_edit.popupContainer).empty();
            $('#cs-popup-content', gemini_edit.popupContainer).data("jsp", "");

            gemini_keyboard.unbindEscape("#cs-popup #cs-popup-close");
            gemini_ui.stopBusy('#cs-popup #cs-popup-save');
            gemini_edit.resetButtons();
            $.colorbox.close();
        }
    },
    initEdit: function (issueId, pageType, popupContainer, formContainer, editContainer, refreshFunction) {
        gemini_edit.pageType = pageType;
        gemini_edit.issueId = issueId;
        gemini_edit.popupContainer = popupContainer;
        gemini_edit.formContainer = formContainer;
        gemini_edit.refreshFunction = refreshFunction;

        if (csVars.DontUseInlineEdit) gemini_edit.useInlineEdit = false;
                
        $(editContainer).on("click", '.attribute', gemini_edit.initEditing);
    },
    setProjectFieldDisplay: function (includeProjectField)
    {
        gemini_edit.includeProjectsField = includeProjectField;
    },
    resetButtons: function()
    {
        var orig = $('#cs-popup-save', '#cs-popup').attr('data-orig-val');
        if (orig && orig.length) {
            $('#cs-popup-save', '#cs-popup').val(orig);
            $('#cs-popup-save', '#cs-popup').attr('data-orig-val', '');
        }
    },
    hasInlineEditFieldChanged: function () {
        var inlineEditingElement = $('.inline-editing');

        if (inlineEditingElement.length > 0) {
            var originalValue = inlineEditingElement.data('original');
            var newValue = inlineEditingElement.val();

            if (originalValue == null) originalValue = '';
            if (newValue == null) newValue = '';
            if (newValue instanceof Array) newValue = newValue.join("|") + '|';

            if (inlineEditingElement.data('input-type') == 'attachment' && originalValue != '') {
                //If newValue is empty then we assume that a new attachment was not uploaded. inlineEditingElement.val(); returns empty for file upload
                if (newValue == '') newValue = originalValue;

                if (inlineEditingElement.parents('form:eq(0)').find('input[type=checkbox]').is(':checked')) newValue = originalValue + "x";
            }
            else if (inlineEditingElement.data('input-type') == 'checkbox') {
                if (inlineEditingElement.is(':checked'))
                    newValue = "True";
                else
                    newValue = "False";
            }
            else if (inlineEditingElement.data('input-type') == 'combobox' && originalValue == '') {
                if (newValue == 0) newValue = originalValue;
            }

            if (inlineEditingElement.length > 0 && originalValue != newValue) {
                return true;
            }
        }

        return false;
    },
    showInlineEditingSpinner: function()
    {
        gemini_edit.inlineEditingRequestPending = true;

        var spinner = gemini_ui.getSpinnerProgress2('inline-edit');
        $('.inline-edit-dropdown .dropdown-options > div').hide();
        $('.inline-edit-dropdown .dropdown-options').append(spinner.Markup);
        eval(spinner.JS);
    },
    hideInlineEditingSpinner: function()
    {
        gemini_ui.removeSpinner('inline-edit', '.inline-edit-dropdown');
        $('.inline-edit-dropdown .dropdown-options > div').show();
        gemini_edit.inlineEditingRequestPending = false;
    }
};