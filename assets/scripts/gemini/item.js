gemini_item = {

    pageType: 0,
    pendingChanges: false,
    editingMode: false,
    issueId: 0,
    triggerXHR: null,
    itemUrl: '',
    initItem: function (projectId, projectCode, issueId, pageType, canEdit,temp_dropzone, temp_delete) {
      
        gemini_item.pageType = pageType;

        gemini_item.issueId = issueId;
        gemini_item.itemUrl = "project/" + projectCode + "/" + projectId + "/"; //Need this because view item.

        gemini_sizing.sameWidth(".touch-info .box", 10);
      
        if (canEdit) {
            gemini_edit.initEdit(issueId, pageType, '#cs-popup', '#cs-popup-content');
    
            $('#view-item-content-pane').on('click', '#additional-content .attribute:not(.edit-mode)', function (e) {
                //Making sure the edit doesn't get invoked when clicking on link

                if (!$(e.target).is('a')) {
                    gemini_edit.initEditing($(this), true);
                }
            });

            $('#item-attributes').on('click', '#attributes-wrapper .attribute:not(.edit-mode)', function (e) {
                //Making sure the edit doesn't get invoked when clicking on link
              
                if (!$(e.target).is('a')) {                  
                    gemini_edit.initEditing($(this), true);
                }
            });

            $('#view-item').on('click', '.item-title', function (e) {
                if (!$(e.target).is('input')) {
                    gemini_ajax.postCall(gemini_item.itemUrl + "inlineedit/getproperty", gemini_edit.pageType, gemini_edit.showInlineEditField, null, { id: issueId, property: $(this).attr('data-attribute-id') }, $('.title', $(this)));
                }
            });

            $('#view-item').on('click', '.progress-info .percent', function (e) {
                //Making sure the edit doesn't get invoked when clicking on link
                    gemini_edit.initEditing($(this), true);                
            });

            $('#view-item').on('click', '.progress-info .estimate', function (e) {
                //Making sure the edit doesn't get invoked when clicking on link
                gemini_edit.initEditing($('#view-item .progress-info .estimate:eq(0)'), true);                
            });

            $('#view-item').on('click', '#add-description', function (e) {
                //Making sure the edit doesn't get invoked when clicking on link              
                gemini_commons.stopClick(e);
                gemini_edit.initEditing($(this), true);                
            });
        }
        
        $('#view-item-content-pane').on("click", '.tab', gemini_item.switchTab);
        gemini_item.switchTab(null, $('.tab:first', '#view-item-content-pane'));

        Mousetrap.bindGlobal(['ctrl+left', 'ctrl+right'], gemini_keyboard.navigateTabs);

        if (!$("#tabledata").length)
        {
            Mousetrap.bindGlobal(['ctrl+,', 'ctrl+.'], gemini_keyboard.navigateItems);
        }

        // Widgets
        $('.widget-header').each(function () {
            gemini_item.getAppControlValue(gemini_item.issueId, $(this).data('gemini-app-id'), $(this).data('gemini-control-id'), 'value', '');
        });
        $('.item-content-widget').each(function () {
            gemini_item.getAppControlValue(gemini_item.issueId, $(this).data('gemini-app-id'), $(this).data('gemini-control-id'), 'value', '');
        });
        
        // Dependencies events
        gemini_item.attachDependencyEvents(issueId);

        gemini_item.attachLinksEvents(issueId);

        gemini_item.attachWatchersEvents(issueId);

        // Expand / collapse comments
        gemini_item.commentExpanders('#cs-sections');

        // ATTACHMENT events
        var attachments = $('#attachmentupload-hit')[0];
        if (attachments != undefined && attachments != null) {
            gemini_item.AttachmentFileUploader(attachments, issueId, "");
        }

        // This is only used for the drag and drop area as we apply above fileuploader to + sign the drag area can't expand to full screen because of + parent's div size
        var uploadArea = $('#phantom-fileuploader')[0];
        if (uploadArea != undefined && uploadArea != null) {
            gemini_item.AttachmentFileUploader(uploadArea, issueId, temp_dropzone);
        }
        
        $('#view-item').on('click', "#item-attachments span.thumbnail-close-image", function (e) {
            e.preventDefault();
            var id = $(this).attr("data-id");            
                
            var itemText = $(this).parents("div:eq(1)").find(".thumbnail-name").attr('title');
            gemini_commons.translateMessage("[[Delete]] " + itemText + "?", ['Delete'], function (message) {

                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.call(gemini_item.itemUrl + "item/" + issueId, "deleteattachment", gemini_item.deleteItemAttachment, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }, { attachmentId: id });
                    }
                );
            });
            
        });

        // Issue Action type events
        $("#item-toolbar #action-delete").on('click', function (e)
        {
            gemini_commons.stopClick(e);
            gemini_commons.translateMessage("[[Delete]]? ", ['Delete'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.call(gemini_item.itemUrl + "item", "deleteissue/" + issueId + '/0' , function (response) {
                            if (response.Success)
                            {
                                window.location.href = response.Result.Data.redirecturl;
                            }
                        }, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }, null);
                    }
                );
            });
        });

        $("#item-toolbar #action-edit").on('click', function (e)
        {
            gemini_commons.stopClick(e);
            gemini_edit.initEditing($(this));
        });

        $("#item-toolbar #action-move").on('click', function (e)
        {
            gemini_commons.stopClick(e);
            gemini_edit.setProjectFieldDisplay(true);
            gemini_edit.initEditing($(this));
        });

        $("#item-toolbar #action-copy").on('click', function (e)
        {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "500px");
            $("#cs-popup-center-content").css("height", "125px");
            gemini_commons.translateMessage("[[Copy]]", ['Copy'], function (message) {
                gemini_popup.centerPopup(gemini_item.itemUrl + "item/" + issueId + "/copyissue", "popup/0", null, null, message);
            });
        });
        
        $("#item-toolbar #action-vote").on('click', function (e)
        {
            gemini_commons.stopClick(e);
            gemini_ajax.call(gemini_item.itemUrl + "item/" + issueId, "voteissue", function (response) {
                if (response.Success) {
                    $('#item-attributes').html(response.Result.Data.Html);
                    $("#item-toolbar #action-vote").hide();
                    gemini_popup.toast(response.Result.Data.Voted);
                }
            });
        });

        $("#item-toolbar #action-follow-unfollow").on('click', function (e)
        {
            gemini_commons.stopClick(e);
            gemini_ajax.call(gemini_item.itemUrl + "item/addwatcher/" + issueId, "0", function (response) {

                if (response.Success) {
                    var title = $("#action-follow-unfollow", "#item-toolbar").text();

                    var altTitle = $("#action-follow-unfollow", "#item-toolbar").attr('data-alt-title');

                    $("#action-follow-unfollow", "#item-toolbar").text(altTitle);
                    $("#action-follow-unfollow", "#item-toolbar").attr('data-alt-title', title);

                    gemini_item.replaceContent(response.Result.Data);
                    gemini_item.attachWatchersEvents(response.Result.Data.issueId);
                }
            });
        });

        $('#item-collapse').click(function () {
            if ($('#view-item-collapse').is(':visible')) {
                $('#view-item-collapse').slideUp();
                $(this).html($(this).attr('data-text-show'));
            }
            else {
                $('#view-item-collapse').slideDown();
                $(this).html($(this).attr('data-text-hide'));
            }
        });
        
        // COMMENTS events
        // initialize tinyMC editor for comments
        gemini_item.attachCommentsEditWindowEvents(issueId);
        gemini_item.attachCommentsTinyMcEvents(issueId, "comments-wysiwyg-content");
      

        $('#view-item').on('click', ".section-content.comments span.delete", function (e) {
            e.preventDefault();

            var id = $(this).attr("data-id");
            gemini_commons.translateMessage("[[Delete]] [[Comment]]? ", ['Delete','Comment'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.call(gemini_item.itemUrl + "item/" + issueId, "deletecomment", gemini_item.deleteComment, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }, { commentId: id });
                    }
                );
            });
         });

        $('#view-item').on('click', ".section-content.comments span.thumbnail-close-image", function (e) {
            e.preventDefault();            
            var id = $(this).attr("data-id");
            
            gemini_commons.translateMessage("[[Remove]] " + $(this).parents(".thumbnail").find(".thumbnail-name a").html() + "?", ['Remove'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.jsonCall(gemini_item.itemUrl + "item/" + issueId, "deleteattachment", gemini_item.deleteCommentAttachment, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }, { attachmentId: id });
                    }
                );         
            });
        });  

        $('#view-item').on("click", ".description-article .fonticon-edit", function (e) {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "725px");
            $("#cs-popup-center-content").css("height", "380px");
            gemini_popup.centerPopup(gemini_item.itemUrl + "item/" + issueId + "/editdescription", "popup", null);
    
        });

        $('#view-item').on("click", "#sourcecode-content .add", function (e) {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "420px");
            $("#cs-popup-center-content").css("height", "100px");
            gemini_popup.centerPopup(gemini_item.itemUrl + "item/" + issueId + "/editsourcecontrol", "popup", null);

        });

        $('#view-item').on("click", "#timelog-content .add", function (e) {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "500px");
            $("#cs-popup-center-content").css("height", "350px");
            gemini_popup.centerPopup(gemini_item.itemUrl + "item/" + issueId + "/edittimeentry", "popup/", { timeid: 0 });
        });

        $('#view-item').on("click", "#timelog-content .action-button-edit", function (e) {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "500px");
            $("#cs-popup-center-content").css("height", "350px");
            gemini_popup.centerPopup(gemini_item.itemUrl + "item/" + issueId + "/edittimeentry", "popup/", { timeid: $(this).parents("tr:eq(0)").attr("data-id") } );
        });

        $('#view-item').on("click", "#sourcecode-content .action-button-delete", function (e) {
            var id = $(this).parents("tr:eq(0)").attr("data-id");

            gemini_commons.translateMessage("[[Delete]] " + $(this).parents("tr:eq(0)").find("td:eq(0)").html() + "?", ['Delete'], function (message) {
                gemini_popup.modalConfirm(message, null,
                     function () {
                         gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                         gemini_ajax.call(gemini_item.itemUrl + "item/" + issueId, "deletesourcecontrol/" + id,
                             function(response) {
                                 if (response.Success) gemini_item.replaceContent(response.Result.Data);
                                 gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
                             }
                         ), function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }
                     }
                );
            });
        });

        $('#view-item').on("click", "#timelog-content .action-button-delete", function (e) {
            var id = $(this).parents("tr:eq(0)").attr("data-id");
            var message = "[[Delete]] " + $(this).parents("tr:eq(0)").find("td:eq(0)").text() + " - " + $(this).parents("tr:eq(0)").find("td:eq(3)").html() + " " + $(this).parents("tr:eq(0)").find("td:eq(4)").html() + "?";
            gemini_commons.translateMessage(message, ['Delete'], function (message) {
                gemini_popup.modalConfirm(message, null,
                     function () {
                         gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                         gemini_ajax.call(gemini_item.itemUrl + "item/" + issueId, "deletetimeentry/" + id,
                            function (response) {
                                if (response.Success)
                                {
                                    //var isCollapsed = $('.dependencies-article .fonticon-arrow-right').length;
                                    gemini_item.replaceContent(response.Result.Data);
                                    //if (isCollapsed) gemini_ui.expandCollapse($('.expander', '.dependencies-article').first().parent());
                                }
                                gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
                            }, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }
                         );
                     }
                );
            });
        });

        $('#view-item').on('click', "#comments-content .toolbar .button", function (e) {
            e.preventDefault();
            if ($(".comments-wysiwyg-container").is(':visible')) {
                $('#comments-content .cs-comment-add-close').click();
                return;
            }

            gemini_ui.expand("#comments-section");

            $(".comments-wysiwyg-container").css("display", "inline-block");
            
            // resetting main editors input fields
            $("#comments-wysiwyg-content").val("");
            var t = $("#comments-wysiwyg-content").parents("form:eq(0)").attr("class");
            var s = $("#comments-wysiwyg-content").parents("form:eq(0)").find(".option-row:eq(0) .file-upload-button").val();

            $("#comments-wysiwyg-content").parents("form:eq(0)").find(".option-row:eq(0) .file-upload-button").replaceWith("<input class='file-upload-button' type='file' name='comment-attachment' multiple='multiple' />");
     
            gemini_ui.htmlEditorCommand('mceFocus', false, 'comments-wysiwyg-content');

            gemini_sizing.sameWidth("#comments-content .comments-wysiwyg-container .buttons input");
            gemini_item.setContentHeight();
        });

        $('#view-item').on('click', ".comments-wysiwyg-container.comment-editing-mode", function (e) {

            if ($(this).parents(".comments-wysiwyg-container.comment-editing-mode").length > 0) {
                var content = $(this).parents(".comment").attr("alt");
                $(this).parents(".comments-wysiwyg-container").replaceWith(content);
            }
            else {
                $(this).parents(".comments-wysiwyg-container").css("display", "none");
                $(this).parents(".comments-wysiwyg-container").find($("#comments-wysiwyg-content")).val("");
                $(this).parents(".comments-wysiwyg-container").find($(".file-upload-button")).val("");
            }
        });

        $('#view-item').on('click', ".cs-comment-add-save", function (e) {
            if ($(this).parents(".comments-wysiwyg-container").find($(".wysiwyg-container textarea")).val() == "") {
                e.preventDefault();
            }
            else {
                if ($('.comments-wysiwyg-container').length == 1) {
                    gemini_ui.startBusy('#comments-content .comments-wysiwyg-container:eq(0) .cs-comment-add-save');
                }
                else {
                    gemini_ui.startBusy('#comments-content .comments-wysiwyg-container:eq(1) .cs-comment-add-save');
                }
                 e.preventDefault();
                $('.comments-form').submit();
            }
        });

        //When you click on X for comments
        $('#view-item').on('click', "#comments-content .cs-comment-add-close", function (e)
        {
            if ($(this).parents(".comment").hasClass("comment-editing-mode"))
            {
                $(this).parents(".comment").find(".comments-wysiwyg-container").before($(this).parents(".comment").data("content"));
                $(this).parents(".comment").removeClass("comment-editing-mode");
                $(this).parents(".comments-wysiwyg-container").remove();
            }
            else
            {
                $(this).parents(".comments-wysiwyg-container").css("display", "none");
            }
        });

        if (!($("#tabledata").length))
        {
            gemini_ajax.call(csVars.ProjectUrl + "item/" + issueId, "FilterNavigator", function (response) {
                $('#filter-navigator-container').replaceWith(response);
            });
        }
    },

    deleteComment: function (response)
    {  
        if (response.Success) {
            $("#comments-content [data-id='" + response.Result.Data.id + "']").remove();
            var numberOfComments = parseInt($("#comments-section h3").attr('title')) - 1;
            $("#comments-section h3").html($("#comments-section").attr("title") + "&nbsp(" + numberOfComments + ")");
            $("#comments-section h3").attr("title", numberOfComments);
            gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
            gemini_item.replaceContent(response.Result.Data);
            
            $.publish('issue-update', [gemini_item.issueId, gemini_edit.pageType]);
        }
    },

    AttachmentFileUploader: function (element, issueId, temp_dropzone)
    {

        var template = '<li>' +
                '<span class="qq-upload-file"></span>' +
                '<span class="qq-upload-spinner"></span>' +
                '<span class="qq-upload-size"></span>' +
                '<a class="qq-upload-cancel" href="#">[[Cancel]]</a>' +
                '<span class="qq-upload-failed-text">[[Failed]]</span>' +
                '<span class="fonticon-cross"></span>' +
            '</li>';
        

        gemini_commons.translateMessage(template, ['Cancel','Failed'], function (message) {
            gemini_item.attachmentUploader = new qq.FileUploader({
                element: element,
                action: gemini_ajax.getUrl(gemini_item.itemUrl + "Item/" + issueId, "UploadAttachment"),
                debug: false,

                onComplete: function (_id, fileName, responseJSON) {
                    if (responseJSON.success) {
                        if (responseJSON.Result == undefined) {
                            gemini_item.replaceContent(responseJSON);
                        }
                        else {
                            gemini_item.getItemAttachments(issueId);
                        }
                        $("#item-attachments .qq-upload-list .qq-upload-success").hide();
                    }

                    $(".qq-upload-fail .fonticon-cross").click(function() {
                            $(this).parent().remove();
                    });
                },
                taxonomy: {
                    uploadButton: "<a href='#'>Attachments</a>",
                    dropZone: temp_dropzone
                },
                fileTemplate: message
            });
        });
    },

    getItemAttachments: function (issueId) {
        gemini_item.attachmentUploader.setParams({ IssueId: issueId });
        var opts = {
            id: issueId
        };
        gemini_ajax.call(gemini_item.itemUrl + "item/" + issueId, "Attachments", function (response) { gemini_item.replaceContent(response.Result.Data); }, null, opts);
    },

    deleteItemAttachment: function (responseJSON) {
        if (responseJSON.success)  
        {      
            $("#item-attachments .thumbnail[data-id='" + responseJSON.Result.Data.id + "']").remove();
    
            gemini_item.replaceContent(responseJSON.Result.Data);
            gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
        }        
    },

    deleteCommentAttachment: function (responseJSON) {
        if (responseJSON.success) {
            $("#comments-content [data-id='" + responseJSON.Result.Data.id + "']").remove();
        }
        gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
    },

    getAppControlValue: function (issueId, appId, controlId, action, formData) {
        var spinner = gemini_ui.getSpinnerSmall();
        $('#' + appId + '-' + controlId).html(spinner.Markup);
        eval(spinner.JS);
        $.ajax({
            type: 'POST',
            url: csVars.Url + 'issue/apps/submit/popup/' + issueId + '/' + appId + '/' + controlId + '/' + action,
            async: true,
            data: formData,
            success: function (response) {
                if (response.Success) {
                    if (gemini_commons.isEmpty(response.Result.Markup)) {
                        response.Result.Markup = '&nbsp;';
                    }

                    $('#' + appId + '-' + controlId).html(response.Result.Markup);
                }
                else {
                }

            }
        });
    },
    attachCommentsTinyMcEvents: function (issueId, textareaId) {    // Create editor for comments textarea needs to come without # for tinyMCE execCommand. It can only accept ID's no classes and Id's need to come without the #
        gemini_ui.htmlEditor("#" + textareaId, null, gemini_item.setPendingChanges);

        var options = {
            dataType: "json",
            success: function (responseText, statusText, xhr, $form) {                
                if (responseText.success) gemini_item.replaceContent(responseText);
                
                $.publish('issue-update', [gemini_item.issueId, gemini_edit.pageType]);
            } // post-submit callback  
            
        };
        if (textareaId != "comments-wysiwyg-content") gemini_ui.htmlEditorCommand("mceFocus", false, textareaId);
        $(".comments-form").ajaxForm(options);
    },

    commentExpanders: function (container) {

           $(container).on("click", "span.comment-expandedOrcollapsed", function (e) {
               gemini_ui.expandCollapse($(this));
           });
    },

    attachCommentsEditWindowEvents: function (issueId)
    {
        $(".section-content.comments .action-button-edit").unbind('click').click(function () {
            var TargetElem = $(this).parents("div:eq(0)").find(".comment");
            if (!$(TargetElem).hasClass("comment-editing-mode")) {
                var attachments = $(".attachment", $(TargetElem)).detach();
                var comment = $(TargetElem).html();
                var contentIdentifier = $("#comments-content .comments-wysiwyg-container").length + 1;
                var group = 1;
                var currentGroup = $(TargetElem).parent().parent().find(".author-box .control-icon").attr("data-group");
                if (currentGroup == undefined || currentGroup == null) currentGroup = group;
                var visibility = $("#comments-content:eq(0) #visibility").clone().attr("id", "visibility" + contentIdentifier).removeClass("chzn-done").val(currentGroup);

                // add content to div for backup if user cancels 
                $(TargetElem).data("content", comment);

                //add identifier to the comment class to prevent duplicate editors on doubleckl twice
                $(TargetElem).addClass("comment-editing-mode");

                var editor = "<div class='comments-wysiwyg-container'>" +
                                "<form class='comments-form " + contentIdentifier + "' action='" + $(TargetElem).attr("data-url") + "' method='post' enctype='multipart/form-data'>" +
                                    "<div class='wysiwyg-container'><textarea id='comments-wysiwyg-content" + contentIdentifier + "' name='commentsWysiwygContent'>" /*+ comment*/ + "</textarea></div>" +
                                     "<div class='comment-extra-options'>" +
                                        "<div class='option-row'><span class='left comment-label'>[[Attachments]]</span>  <input type='file' class='file-upload-button' name='comment-attachment' multiple='multiple' /></div>" +
                                        "<div class='option-row'><span class='left comment-label'>[[Visibility]]</span></div>" +
                                     "</div>" +
                                     "<div class='cs-comment-wysiwyg-option'>" +
                                         "<div class='buttons'>" +
                                         "<input type='button' value='[[Cancel]]' class='button-secondary button-popup cs-comment-add-close right'>" +
                                            "<input type='submit' value='[[Update]]' class='button-primary button-popup cs-comment-add-save-edit right'>" +                                            
                                        "</div>" +
                                    "</div>" +
                                "</form>" +
                            "</div>";

            
                gemini_commons.translateMessage(editor, ['Update', 'Attachments', 'Visibility', 'Cancel'], function (message) {
                    TargetElem.html(message);
                    TargetElem.append(attachments);
                    TargetElem.find(".comments-wysiwyg-container").css("display", "inline-block");
                    TargetElem.find(".comment-extra-options .option-row:eq(1)").append(visibility);
                    if (TargetElem.find(".comments-wysiwyg-container .option-row:eq(1) select").length == 0)
                       TargetElem.find(".comments-wysiwyg-container .option-row:eq(1)").hide();

                    gemini_ui.chosen("#comments-content .option-row .input-size8");
                    gemini_item.attachCommentsTinyMcEvents(issueId, "comments-wysiwyg-content" + contentIdentifier);
                    gemini_ui.htmlEditorCommand('mceInsertContent', false, comment);
                    gemini_item.setContentHeight();
                    }
                );

                gemini_ui.expand($(this));

            }
        });
    },

    replaceContent: function (response) {
        $("#progress-indicator").addClass('hide');
        $(response.Data).each(function () {
            if (this.Key == 'AssociatedAttachments') {
            
                var attachments = $("#item-attachments");
                $("#item-attachments").replaceWith(this.Value);

                $(".action-add", '#item-attachments').replaceWith($(".action-add", $(attachments)));
                $("#phantom-fileuploader", '#item-attachments').replaceWith($("#phantom-fileuploader", $(attachments)));
            }
            else if (this.Key == "AssociatedHistory") {
                gemini_item.replaceContentContainer('history', this.Value);
            }
            else if (this.Key == "AssociatedComments") {
                gemini_item.replaceContentContainer('comments', this.Value);
                // applies styling to select
                gemini_ui.chosen("#comments-content .option-row .input-size8");
                gemini_item.attachCommentsEditWindowEvents(response.issueId);
                gemini_item.attachCommentsTinyMcEvents(response.issueId, "comments-wysiwyg-content");
                // Attaches hover event to image to display X button
                $("#comments-wysiwyg-content").val("");
                $("#comments-section").click();
            }
            else if (this.Key == 'Title') {
                $('#view-item .item-title').html(this.Value);
            }
            else if (this.Key == 'Description') {
                $(".clear-description-article").remove();
                $(".description-article").replaceWith(this.Value);
            }
            else if (this.Key == 'AssociatedHierarchy') {
                $("#dependency-section").replaceWith(this.Value);         
                gemini_item.attachDependencyEvents(response.issueId);
            }
            else if (this.Key == 'AssociatedLinks') {
                $(".see-also-container").html(this.Value);

                if ($('.see-also-container .see-also-value a').length > 0)
                    $(".see-also-container").attr('class', 'see-also-container margin-top-10 margin-bottom-10');
                else
                    $(".see-also-container").removeClass('margin-top-10 margin-bottom-10');

                gemini_ui.chosen('#links-find-item-container #linktypes');
            }
            else if (this.Key == 'AssociatedWatchers') {
                gemini_item.replaceContentContainer('watchers', this.Value);
            }
            else if (this.Key == 'AssociatedSourceControl') {
                gemini_item.replaceContentContainer('sourcecode', this.Value);
            }
            else if (this.Key == 'AssociatedTime') {
                gemini_item.replaceContentContainer('timelog', this.Value);
            }
            else if (this.Key == 'AttributePane') {
                $('#item-attributes').html(this.Value);
            }
            else if (this.Key == 'EstimatedEffort') {
                $('#view-item .progress-info').replaceWith(this.Value);
            }
            else if (this.Key == 'DateCreated') {
                $('#touch-info-container', '#view-item').html(this.Value);
                gemini_sizing.sameWidth(".touch-info .box", 10);
            }
        });
    },
    replaceContentContainer: function (area, value)
    {
        var isSelected = $("#" + area + "-section").hasClass('selected');

        $("#" + area + "-content").remove();       
        $("#" + area + "-section").replaceWith(value);
        if (isSelected) $("#" + area + "-section").click();
    },
    attachWatchersEvents: function (issueId)
    {
        $("#watchers-find-item-container").hide();

        $("#watchers-find-item-container input").unbind('blur').blur(function (e) {
            $("#watchers-find-item-container").hide();
            $("#watchers-find-item-container input").val("");
        });

        $("#watchers-find-item-container input").unbind('keypress').keypress(function (e) {
            if (e.keyCode == 27) {
                $("#watchers-find-item-container").hide();
                $("#watchers-find-item-container input").val("");
            }
        });
        
        $("#watchers-content .toolbar .add").unbind('click').click(function (e) {
            e.preventDefault();
            var p = $("#watchers-content .add").position();
            $("#watchers-find-item-container").show().css("left", p.left).css("top", p.top + 15);
            $("#watchers-find-item-container input").focus();
        });

        $("#watchers-content .action-button-delete").unbind('click').click(function (e) {
            var id = $(this).parents("tr:eq(0)").attr("data-id");

            gemini_commons.translateMessage("[[Remove]] " + $(this).parents("tr:eq(0)").find("td:eq(0)").html() + "?", ['Remove'], function (message) {
                gemini_popup.modalConfirm(message, null, function () {
                    gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                    gemini_ajax.jsonCall(gemini_item.itemUrl + "item", "deletewatcher/" + issueId + "/" + id,
                        function (response) {
                            if (response.Success)
                            {
                                gemini_item.replaceContent(response.Result.Data);
                                gemini_item.attachWatchersEvents(response.Result.Data.issueId);
                            }
                            gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
                        }, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }
                    );
                }
                );
            });

        });


        $("#watchers-find-item").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: csVars.Url + gemini_item.itemUrl + "account/getusersdropdown",
                    dataType: "json",
                    data: { term: request.term },
                    success: function (data) {
                        var rows = new Array();
                        for (var i = 0; i < data.Result.Data.length; i++) {
                            rows[rows.length] = { label: data.Result.Data[i].label, value: data.Result.Data[i].value };
                        }
                        response(rows);
                    }
                });
            },
            minLength: 2,
            width: 200,
            dataType: "json",
            matchContains: "word",
            autoFill: false,
            select: function (e, data) {
                $("#watchers-find-item").val(data.item.label);
                gemini_ajax.jsonCall(gemini_item.itemUrl + "item", "addwatcher/" + issueId + '/' + data.item.value,
                        function AddWatchersResponse(response) {
                            if (response.Success)
                            {
                                gemini_item.replaceContent(response.Result.Data);
                                gemini_item.attachWatchersEvents(response.Result.Data.issueId);
                                gemini_ui.flashContent("#watchers-content [data-id='" + response.Result.Data.userId + "']");
                            }
                           
                        }
                    );
                return false;
            },
            focus: function (event, ui) {
                this.value = ui.item.label;
                event.preventDefault(); // Prevent the default focus behavior.
            }
        });

    },

    attachDependencyEvents: function (issueId) {

        $("#dependency-section .dependency").hover(
            function (e) {
                if ($(this).hasClass("open")) $(".fonticon-plus:not(.noshow)", $(this)).css("visibility", "visible");
                if (($(this).hasClass("open") || $(this).hasClass("closed")) && !$(this).is(":first-child")) $(".fonticon-cross:not(.noshow)", $(this)).css("visibility", "visible");
                
            },
            function (e) {        
                $(".fonticon-plus:not(.noshow)", $(this)).css("visibility", "hidden");
                $(".fonticon-cross:not(.noshow)", $(this)).css("visibility", "hidden");
            }
        );

        var baseIssueId = false;

        $("#dependency-section .dependency .fonticon-plus").unbind('click').click(function (e) {
            var p = $(this).position();
            $("#dependencies-find-item-container").show().css("left", p.left).css("top", p.top + 15);
            $("#dependencies-find-item-container input").focus();
            baseIssueId = $(this).parent().attr("data-id");
        });

        $("#view-item #add-dependency").unbind('click').click(function (e) {
            e.preventDefault();          

            $("#dependencies-find-item-container").show();
            $("#dependencies-find-item-container").position({
                "my": "right center",
                "at": "left center",
                "of": $('#item-toolbar'),
                "offset": "-5 0",
                "collision": "none"
            });

            $("#dependencies-find-item-container input").focus();
            baseIssueId = issueId;
        });

        $('#view-item #add-new-dependency').unbind('click').click(function (e) {
            gemini_commons.stopClick(e);
            gemini_add.hidePlan = true;
            gemini_add.hideProject = true;
            gemini_add.newItemRenderedCallback = function () {

                var scroll = $(window).scrollTop();
                var popup = $("#cs-popup-add");
                if (scroll > popup.position().top) {
                    popup.css("top", scroll);
                }
                popup.find("form").append("<input type='hidden' value='" + gemini_item.issueId + "' name='ParentItem' id='ParentItem' />");
            };
            gemini_add.newItemCreatedCallback = function (id) {
                gemini_ajax.jsonCall(gemini_item.itemUrl + "items", "renderdependencies/" + issueId,
                            function (response) {
                                if (response.Success) {
                                    gemini_item.replaceContent(response.Result.Data);
                                }
                            }
                        );
            };
            gemini_commons.showAddItem();
        });

        $("#dependency-section .dependency .fonticon-cross").unbind('click').click(function (e) {
            var id = $(this).parent().attr("data-id");

            var itemText = $(this).parents("div:eq(1)").find(".thumbnail-name a").html();
            gemini_commons.translateMessage("[[Remove]] " + $(this).parent().find(".item-links span:first").html() + "?", ['Remove'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.jsonCall(gemini_item.itemUrl + "items", "deletedependency/" + issueId + "/" + id,
                            function (response) {
                                if (response.Success) {
                                    gemini_item.replaceContent(response.Result.Data);                                  
                                }
                                setTimeout(function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }, 1250);                                
                            }
                        );
                    }
                );
            });

        });

        
        $("#dependencies-find-item-container input").unbind('blur').blur(function (e) {
            gemini_item.hideDependencyFindItem();
        });


        gemini_commons.inputKeyHandler("#dependencies-find-item-container input",
            function() {
                gemini_ajax.jsonCall(gemini_item.itemUrl + "items", "adddependency/" + issueId + '/' + baseIssueId + '/' + $("#dependencies-find-item-container input").val(),
                    function AddDependencyResponse(response) {
                        if (response.Result.Data.success) {

                            gemini_item.replaceContent(response.Result.Data);
                            //gemini_item.attachDependencyEvents(response.Result.Data.issueId);
                            gemini_ui.flashContent(".dependencies-article [data-id='" + response.Result.Data.childIssueId + "']");
                        } else {

                            if (response.Result.Data.Message) {
                                gemini_popup.toast(response.Result.Data.Message);
                            } else if (response.Message) {
                                gemini_popup.toast(response.Message);
                            }
                        }
                        gemini_item.hideDependencyFindItem();
                    }
                );


            }, function() { gemini_item.hideDependencyFindItem(); });

        gemini_item.hideDependencyFindItem();

        $("#dependencies-find-item").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: csVars.Url + gemini_item.itemUrl + "item/" + issueId + "/getissuesdropdown",
                    dataType: "json",
                    data: { term: request.term , action: "dependency"},
                    success: function (data) {
                        var rows = new Array();
                        for (var i = 0; i < data.Result.Data.length; i++) {
                            rows[rows.length] = { label: data.Result.Data[i].value + " - " + data.Result.Data[i].label, value: data.Result.Data[i].value };
                        }
                        response(rows);
                    }
                });
            },
            minLength: 2,
            width: 200,
            dataType: "json",
            matchContains: "word",
            autoFill: false,
            select: function (e, data) {
                gemini_ajax.jsonCall(gemini_item.itemUrl + "items", "adddependency/" + issueId + '/' + baseIssueId + '/' + data.item.value, 
                        function AddDependencyResponse(response) {
                            if (response.Success)
                            {
                                gemini_item.replaceContent(response.Result.Data);
                                //gemini_item.attachDependencyEvents(response.Result.Data.issueId);
                                gemini_ui.flashContent("#dependency-section [data-id='" + response.Result.Data.childIssueId + "']");
                            }
                        }
                    );
                gemini_item.hideDependencyFindItem();
            }
        });

    },

    hideDependencyFindItem: function ()
    {
        $("#dependencies-find-item-container").hide();
        $("#dependencies-find-item-container input").val("");
    },

    hideLinkFindItem: function () {
        $("#links-find-item-container").hide();
        $("#links-find-item").val("");
    },

    attachLinksEvents: function (issueId) {
        $("#links-find-item-container .fonticon-cross").unbind('click').click(function (e) {
            gemini_item.hideLinkFindItem();
        });

        $("#link-section #links-find-item-container form").validate();

        $("#view-item #add-link").unbind('click').click(function (e) {
            e.preventDefault();

            $("#links-find-item-container").show();
            $("#links-find-item-container").position({
                "my": "right center",
                "at": "left center",
                "of": $('#item-toolbar'),
                "offset": "-5 0",
                "collision": "none"
            });

            $("#links-find-item-container #links-find-item").focus();
        });

        $("#links-find-item-container").hide();
        $("#links-find-item-container #links-find-item").unbind('keyup').keyup(function () {
            if ($(this).val() == "") $("#links-find-item-id").val("");
        });

        function post_link() {
            if ($("#links-find-item-container #links-find-item").val() != "") {

                if ($("#links-find-item-container #links-find-item-id").val() == '') {
                    $("#links-find-item-container #links-find-item-id").val($("#links-find-item-container #links-find-item").val());
                }

                gemini_ajax.jsonCall(gemini_item.itemUrl + "item/" + issueId, "addlink/" + $("#links-find-item-container #links-find-item-id").val() + '/' + $("#links-find-item-container #linktypes").val(),
                            function AddLinkResponse(response) {
                                if (response.Success) {
                                    gemini_item.replaceContent(response.Result.Data);
                                    gemini_item.attachLinksEvents(response.Result.Data.issueId);
                                    gemini_ui.chosen("#links-find-item-container #linktypes");
                                    $("#links-find-item-container #links-find-item").val("");
                                    $("#links-find-item-container").hide();

                                    gemini_ui.flashContent($(".see-also [data-id='" + response.Result.Data.linkedIssueId + "']").prev());
                                }
                                else {
                                    if (response.Result.Data.Message) {
                                        gemini_popup.toast(response.Result.Data.Message);
                                    }
                                    else if (response.Message) {
                                        gemini_popup.toast(response.Message);
                                    }
                                }
                            }
                        );
            }
            else
                $("#links-find-item-container form").valid();
        }

        $("#links-find-item-container .fonticon-tick").unbind('click').click(function () {
            post_link();
        });

        gemini_commons.inputKeyHandler("#links-find-item-container #links-find-item",
            function() {
                post_link();
            }, function() { gemini_item.hideLinkFindItem(); });

        $(".see-also .delete-link").unbind('click').click(function () {
            var deleteId = $(this).attr("data-id");

            gemini_commons.translateMessage("[[Remove]] [[Link]] " + $(this).prev().text() + "?", ['Remove', 'Link'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.jsonCall(gemini_item.itemUrl + "item/" + issueId, "deletelink/" + deleteId,
                            function DeleteLinkResponse(response) {
                                if (response.Success)
                                {
                                    gemini_item.replaceContent(response.Result.Data);
                                    gemini_item.attachLinksEvents(response.Result.Data.issueId);
                                    gemini_ui.chosen("#link-section #links-find-item-container #linktypes");
                                }
                                gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
                            }, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }
                        );
                    }
                );
            });

        });
        
        $("#links-find-item").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: csVars.Url + gemini_item.itemUrl + "item/" + issueId + "/getissuesdropdown",
                    dataType: "json",
                    data: { term: request.term , action: "link"},
                    success: function (data) {
                        var rows = new Array();
                        for (var i = 0; i < data.Result.Data.length; i++) {
                            rows[rows.length] = { label: data.Result.Data[i].value + " - " + data.Result.Data[i].label, value: data.Result.Data[i].value };
                        }
                        response(rows);
                    }
                });
            },
            minLength: 2,
            width: 200,
            dataType: "json",
            matchContains: "word",
            autoFill: false,
            select: function (e, data) {
                $("#links-find-item-id").val(data.item.value);
                $("#links-find-item").val(data.item.label);
      
                return false;
            }
        });
    },
    switchTab: function (e, elem) {
        var _that = this;
        if (elem != null && elem != undefined) {
            _that = elem;
        }
        $('.tab', '#view-item-content-pane').removeClass('selected').addClass('normal');
        $('.content', '#view-item-content-pane').hide();
        var content = $('#' + $(_that).attr('data-contentid'));
        content.show();
        $("input[type='text']:first", content).focus();
        $(_that).removeClass('normal').addClass('selected');
        gemini_item.setContentHeight();

    },
    setContentHeight: function (customContentHeight)
    {
        var selectedTab = $('#view-item-content-pane .tabs .selected');

        if (selectedTab.length > 0) {
            var contentContainer = $('#' + selectedTab.attr('data-contentid'));

            if (contentContainer.length > 0) {
                var h = $('#contents').css('min-height');
                var contentOffset = contentContainer.offset();
                var contentPos = contentContainer.position();
                var contentHeight = (customContentHeight) ? customContentHeight : contentContainer.height();
                var contentWidth = contentContainer.width();
                var tabsPos = $('#cs-sections .tab:last').position();
                var tabsHeight = $('#cs-sections .tab:last').height();
                var tabsWidth = $('#cs-sections').width();

                if (tabsWidth != 0 && tabsWidth < contentWidth) {
                    contentContainer.css('width', tabsWidth + 'px');
                }

                contentContainer.css('top', (tabsPos.top + tabsHeight + 20) + 'px');

                //don't need this on items pge when in split mode
                if ($('#items-grid #tabledata').length == 0) {
                    contentOffset = contentContainer.offset();

                    h = parseInt(h);
                    if (h < contentOffset.top + contentHeight) {
                        h = contentOffset.top + contentHeight + 20;
                        $('#contents').css('min-height', h + 'px');
                    }
                }
            }
        }
    },
    resizeWindow: function () {
        var tab = $('.tab.selected', '#cs-sections.tabs');
        if (tab && tab.length) {
            tab.click();
        }
    }
};