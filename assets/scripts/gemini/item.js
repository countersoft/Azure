gemini_item = {

    pageType: 0,
    pendingChanges: false,
    editingMode: false,
    issueId: 0,
    triggerXHR: null,
    initItem: function (projectCode, issueId, pageType, canEdit,temp_dropzone, temp_delete) {

        gemini_item.pageType = pageType;

        gemini_item.issueId = issueId;
      
        if (canEdit) {
            gemini_edit.initEdit(issueId, pageType, '#cs-popup', '#cs-popup-content', '#item-attributes');
            gemini_edit.initEdit(issueId, pageType, '#cs-popup', '#cs-popup-content', '#view-item-content-pane');
        }
        //$('#item-attributes').on("click", '.attribute', gemini_item.initEditing);
 
        // Attachments
        $('.widget-header').each(function () {
            gemini_item.getAppControlValue(gemini_item.issueId, $(this).data('gemini-app-id'), $(this).data('gemini-control-id'), 'value', '');
        });
        $('.item-content-widget').each(function () {
            gemini_item.getAppControlValue(gemini_item.issueId, $(this).data('gemini-app-id'), $(this).data('gemini-control-id'), 'value', '');
        });
        
        gemini_ui.expanders('#cs-sections');
        gemini_ui.collapseStarting('section-widget-', 'test-', 'history-', 'watchers-section', 'link-section', 'attachments-section', 'additional-section', 'dependencies-section', 'sourcecode-section', 'timelog-section', 'watchers-section');
        gemini_ui.expand($('.expander', '#cs-sections').first().parent());

        $('.item-nav a').click(function () {
            gemini_ui.expand($($(this).attr('href') + '-section', '#cs-sections'));
            $('.item-nav a').removeClass('selected');
            $(this).addClass('selected');
        });

        //Clears out not needed click logic for Display Item ID app
        if ($("#cs-sections article[data-gemini-app-id='9C12B8ED-D0FD-4975-A317-614EFF97AAF2']").length != 0)
        {
            if ($("#cs-sections article[data-gemini-app-id='9C12B8ED-D0FD-4975-A317-614EFF97AAF2'] .fonticon-arrow-down").length > 0)
                $("#cs-sections article[data-gemini-app-id='9C12B8ED-D0FD-4975-A317-614EFF97AAF2'] .expander").click();

            $("#cs-sections article[data-gemini-app-id='9C12B8ED-D0FD-4975-A317-614EFF97AAF2'] .expander").remove();
            $("#cs-sections article[data-gemini-app-id='9C12B8ED-D0FD-4975-A317-614EFF97AAF2'] h3").click(function (e) {
                e.stopPropagation();
            });

        }

        // Dependencies events
        gemini_item.attachDependencyEvents(issueId);

        gemini_item.attachLinksEvents(issueId);

        gemini_item.attachWatchersEvents(issueId);


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
        
        $(document).on('click', ".attachment-article span.thumbnail-close-image", function (e) {
            e.preventDefault();
            var id = $(this).attr("data-id");
            if ($(this).parents("div:eq(3)").hasClass("section-header")) {
                
                var itemText = $(this).parents("div:eq(1)").find(".thumbnail-name a").html();
                gemini_commons.translateMessage("[[Delete]] " + itemText + "?", ['Delete'], function (message) {

                    gemini_popup.modalConfirm(message, null,
                        function () {
                            gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                            gemini_ajax.call(csVars.ProjectUrl + "item/" + issueId, "deleteattachment", gemini_item.deleteItemAttachment, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }, { attachmentId: id });
                        }
                    );
                });
            }
        });

 
        // Issue Action type events
        $(document).on('click', "#item-action-types .action-button-delete", function (e) {
            gemini_commons.translateMessage("[[Delete]]? ", ['Delete'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.call(csVars.ProjectUrl + "item", "deleteissue/" + issueId + '/0' , function (response) {
                            if (response.Success)
                            {
                                window.location.href = response.Result.Data.redirecturl;
                            }
                        }, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }, null);
                    }
                );
            });
        });
        
        $(document).on('click', "#item-action-types .action-button-edit", function (e) {
            $("#item-attributes .attribute:eq(0)").click();
        });

        $(document).on('click', "#item-action-types .action-button-move", function (e) {
            gemini_edit.setProjectFieldDisplay(true);
            $("#item-attributes .project.attribute").click();
        });
        

        $(document).on('click', "#item-action-types .action-button-copy", function (e) {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "405px");
            $("#cs-popup-center-content").css("height", "125px");
            gemini_commons.translateMessage("[[Copy]]", ['Copy'], function (message) {
                gemini_popup.centerPopup(csVars.ProjectUrl + "item/" + issueId + "/copyissue", "popup/0", null, null, message);
            });
        });
        
        $(document).on('click', "#item-action-types .action-button-vote", function (e) {
            gemini_ajax.call(csVars.ProjectUrl + "item/" + issueId, "voteissue", function (response) {
                if (response.Success) {
                    $('#item-attributes').html(response.Result.Data.Html);
                    $("#item-action-types .action-button-vote").hide();
                    gemini_popup.toast(response.Result.Data.Voted);
                }
            });
        });

        $(document).on('click', "#item-action-types #action-follow-unfollow", function (e) {
            gemini_ajax.call(csVars.ProjectUrl + "item/addwatcher/" + issueId, "/0", function (response) {
                if (response.Success) {
                    var title = $("#action-follow-unfollow", "#item-action-types").attr('title');
                    var altTitle = $("#action-follow-unfollow", "#item-action-types").attr('data-alt-title');
                    if ($("#action-follow-unfollow", "#item-action-types").hasClass('color-gold')) {
                        $("#action-follow-unfollow", "#item-action-types").removeClass('color-gold');
                    }
                    else {
                        $("#action-follow-unfollow", "#item-action-types").addClass('color-gold');
                    }
                    $("#action-follow-unfollow", "#item-action-types").attr('title', altTitle);
                    $("#action-follow-unfollow", "#item-action-types").attr('data-alt-title', title);
                    gemini_item.replaceContent(response.Result.Data);
                    gemini_item.attachWatchersEvents(response.Result.Data.issueId);
                }
            });
        });
        
        // COMMENTS events
        // Attaches hover event to image to display X button
        gemini_item.attachDelteXHover();
        // initialize tinyMC editor for comments
        gemini_item.attachCommentsEditWindowEvents(issueId);
        gemini_item.attachCommentsTinyMcEvents(issueId, "comments-wysiwyg-content");
      

        $(document).on('click', ".comments-article span.delete", function (e) {
            e.preventDefault();

            var id = $(this).attr("data-id");
            gemini_commons.translateMessage("[[Delete]] [[Comment]]? ", ['Delete','Comment'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.call(csVars.ProjectUrl + "item/" + issueId, "deletecomment", gemini_item.deleteComment, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }, { commentId: id });
                    }
                );
            });
         });

        $(document).on('click', ".comments-article span.thumbnail-close-image", function (e) {
            e.preventDefault();            
            var id = $(this).attr("data-id");
            
            gemini_commons.translateMessage("[[Remove]] " + $(this).parents(".thumbnail").find(".thumbnail-name a").html() + "?", ['Remove'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.jsonCall(csVars.ProjectUrl + "item/" + issueId, "deleteattachment", gemini_item.deleteCommentAttachment, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }, { attachmentId: id });
                    }
                );         
            });
        });  

        $(document).on("click", ".description-article .fonticon-edit", function (e) {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "725px");
            $("#cs-popup-center-content").css("height", "380px");
            gemini_popup.centerPopup(csVars.ProjectUrl + "item/" + issueId + "/editdescription", "popup", null);
    
        });

        $(document).on("click", ".source-control-article .fonticon-plus", function (e) {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "420px");
            $("#cs-popup-center-content").css("height", "100px");
            gemini_popup.centerPopup(csVars.ProjectUrl + "item/" + issueId + "/editsourcecontrol", "popup", null);

        });

        $(document).on("click", ".issue-time-entries-article .fonticon-plus", function (e) {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "500px");
            $("#cs-popup-center-content").css("height", "350px");
            gemini_popup.centerPopup(csVars.ProjectUrl + "item/" + issueId + "/edittimeentry", "popup/", { timeid: 0 });
        });

        $(document).on("click", ".issue-time-entries-article .action-button-edit", function (e) {
            gemini_commons.stopClick(e);
            $("#cs-popup-center-content").css("width", "350px");
            $("#cs-popup-center-content").css("height", "250px");
            gemini_popup.centerPopup(csVars.ProjectUrl + "item/" + issueId + "/edittimeentry", "popup/", { timeid: $(this).parents("tr:eq(0)").attr("data-id") } );
        });

        $(document).on("click", ".source-control-article .action-button-delete", function (e) {
            var id = $(this).parents("tr:eq(0)").attr("data-id");

            gemini_commons.translateMessage("[[Delete]] " + $(this).parents("tr:eq(0)").find("td:eq(0)").html() + "?", ['Delete'], function (message) {
                gemini_popup.modalConfirm(message, null,
                     function () {
                         gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                         gemini_ajax.call(csVars.ProjectUrl + "item/" + issueId, "deletesourcecontrol/" + id,
                            function (response) {
                                if (response.Success) gemini_item.replaceContent(response.Result.Data);
                                gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
                            }
                         ), function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); };
                     }
                );
            });
        });

        $(document).on("click", ".issue-time-entries-article .action-button-delete", function (e) {
            var id = $(this).parents("tr:eq(0)").attr("data-id");
            var message = "[[Delete]] " + $(this).parents("tr:eq(0)").find("td:eq(0)").text() + " - " + $(this).parents("tr:eq(0)").find("td:eq(3)").html() + " " + $(this).parents("tr:eq(0)").find("td:eq(4)").html() + "?";
            gemini_commons.translateMessage(message, ['Delete'], function (message) {
                gemini_popup.modalConfirm(message, null,
                     function () {
                         gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                         gemini_ajax.call(csVars.ProjectUrl + "item/" + issueId, "deletetimeentry/" + id,
                            function (response) {
                                if (response.Success)
                                {
                                    var isCollapsed = $('.dependencies-article .fonticon-arrow-right').length;
                                    gemini_item.replaceContent(response.Result.Data);
                                    if (isCollapsed) gemini_ui.expandCollapse($('.expander', '.dependencies-article').first().parent());
                                }
                                gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
                            }, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }
                         );
                     }
                );
            });
        });

        $(document).on('click', ".comments-article .toolbar .button", function (e) {
            e.preventDefault();

            if ($(".comments-wysiwyg-container").is(':visible')) {
                $('.comments-article .cs-comment-add-close').click();
                return;
            }

            gemini_ui.expand("#comments-section");

            $(".comments-wysiwyg-container").css("display", "inline-block");
            
            // resetting main editors input fields
            $("#comments-wysiwyg-content").val("");
            var t = $("#comments-wysiwyg-content").parents("form:eq(0)").attr("class");
            var s = $("#comments-wysiwyg-content").parents("form:eq(0)").find(".option-row:eq(0) .file-upload-button").val();

            $("#comments-wysiwyg-content").parents("form:eq(0)").find(".option-row:eq(0) .file-upload-button").replaceWith("<input class='file-upload-button' type='file' name='comment-attachment' multiple='multiple' />");
     
            tinyMCE.execCommand('mceFocus', false, 'comments-wysiwyg-content');
            
            if ( $(".comments-article .comments-wysiwyg-container .buttons .button-secondary").width() != $(".comments-article .comments-wysiwyg-container .buttons .button-primary").width())
                gemini_sizing.sameWidth(".comments-article .comments-wysiwyg-container .buttons input", 50);
        });

        $(document).on('click', ".comments-wysiwyg-container.comment-editing-mode", function (e) {

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

        $(document).on('click', ".cs-comment-add-save", function (e) {
            if ($(this).parents(".comments-wysiwyg-container").find($(".wysiwyg-container textarea")).val() == "") {
                e.preventDefault();
            }
            else {
                if ($('.comments-wysiwyg-container').length == 1) {
                    gemini_ui.startBusy('.comments-article .comments-wysiwyg-container:eq(0) .cs-comment-add-save');
                }
                else {
                    gemini_ui.startBusy('.comments-article .comments-wysiwyg-container:eq(1) .cs-comment-add-save');
                }
                 e.preventDefault();
                $('.comments-form').submit();
            }
        });

        //When you click on X for comments
        $(document).on('click', ".comments-article .cs-comment-add-close", function (e)
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


    },
    deleteComment: function (response)
    {  
        if (response.Success) {
            $(".comments-article [data-id='" + response.Result.Data.id + "']").remove();
            var numberOfComments = parseInt($("#comments-section h3").attr('title')) - 1;
            $("#comments-section h3").html($("#comments-section").attr("title") + "&nbsp(" + numberOfComments + ")");
            $("#comments-section h3").attr("title", numberOfComments);
            gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
            gemini_item.replaceContent(response.Result.Data);
        }
    },
    AttachmentFileUploader: function (element,issueId,temp_dropzone)
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
                action: gemini_ajax.getUrl(csVars.ProjectUrl + "Item/" + issueId, "UploadAttachment"),
                debug: false,

                onComplete: function (_id, fileName, responseJSON) {
                    if (responseJSON.success) {
                        if (responseJSON.Result == undefined) {
                            gemini_item.replaceContent(responseJSON);
                        }
                        else {
                            gemini_item.getItemAttachments(issueId);
                        }
                        $(".attachment-article .qq-upload-list .qq-upload-success").hide();
                    }

                    $(".qq-upload-fail .fonticon-cross").click(function() {
                            $(this).parent().remove();
                    });
                },
                taxonomy: {
                    uploadButton: "+",
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
        gemini_ajax.call(csVars.ProjectUrl + "item/" + issueId, "Attachments", function (response) { gemini_item.replaceContent(response.Result.Data); }, null, opts);
    },
    deleteItemAttachment: function (responseJSON) {
        if (responseJSON.success)  
        {      
            $(".attachments [data-id='" + responseJSON.Result.Data.id + "']").remove();
            var numberOfAttachments = parseInt($("#attachments-section h3").attr('title')) - 1;
            $("#attachments-section h3").html($("#attachments-section").attr("title") + "&nbsp(" + numberOfAttachments + ")");
            $("#attachments-section h3").attr('title', numberOfAttachments);
    
            gemini_item.replaceContent(responseJSON.Result.Data);
            gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
        }        
    },
    deleteCommentAttachment: function (responseJSON) {
        if (responseJSON.success) {
            $(".comments-article [data-id='" + responseJSON.Result.Data.id + "']").remove();
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
    attachDelteXHover: function () {
        $(".attachment-article .thumbnail, .comments-article .thumbnail").hover(
            function (e) {
                e.stopPropagation(); //make sure comment x hover doesn't come up when hovering over image
                $(".thumbnail-close-image a",$(this)).show();
            },
            function (e) {
                e.stopPropagation();
                $(".thumbnail-close-image a",$(this)).hide();  
            }
        );

        $(".section-content .comment-wrapper ").hover(
             function (e) {
                 $(this).parent().find(".delete a").css("visibility","visible");
                 $(this).parent().find(".action-button-edit").css("visibility", "visible");
             },
             function (e) {
                 $(this).parent().find(".delete a").css("visibility", "hidden");
                 $(this).parent().find(".action-button-edit").css("visibility", "hidden");
             }
        );
    },
    attachCommentsTinyMcEvents: function (issueId,textareaId) {    // Create editor for comments textarea needs to come without # for tinyMCE execCommand. It can only accept ID's no classes and Id's need to come without the #
        gemini_ui.htmlEditor("#" + textareaId, null, gemini_item.setPendingChanges);

        var options = {
            dataType: "json",
            success: function (responseText, statusText, xhr, $form) {                
                if (responseText.success) gemini_item.replaceContent(responseText);                  

            } // post-submit callback  
            
        };
        if (textareaId != "comments-wysiwyg-content") tinyMCE.execCommand("mceFocus", false, textareaId);
        $(".comments-form").ajaxForm(options);
    },
    attachCommentsEditWindowEvents: function (issueId)
    {
        $(".comments-article .action-button-edit").click(function () {
            var TargetElem = $(this).parents("div:eq(0)").find(".comment");
            if (!$(TargetElem).hasClass("comment-editing-mode")) {
                var attachments = $(".attachment", $(TargetElem)).detach()
                var comment = $(TargetElem).html();
                var contentIdentifier = $(".comments-article .comments-wysiwyg-container").length + 1;
                var group = 1;
                var currentGroup = $(TargetElem).parent().find(".author-box .control-icon").attr("data-group");
                if (currentGroup == undefined || currentGroup == null) currentGroup = group;
                var visibility = $(".comments-article:eq(0) #visibility").clone().attr("id", "visibility" + contentIdentifier).removeClass("chzn-done").val(currentGroup);

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
                                            "<input type='submit' value='[[Update]]' class='button-primary button-popup cs-comment-add-save right'>" +                                            
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

                    gemini_ui.chosen(".comments-article .option-row .input-size8");
                    gemini_item.attachCommentsTinyMcEvents(issueId, "comments-wysiwyg-content" + contentIdentifier);
                    gemini_item.attachDelteXHover();
                    tinyMCE.execCommand('mceInsertContent',false,comment);
                
                    }
                );



            }
        });
    },
    replaceContent: function (response) {
        $("#progress-indicator").addClass('hide');
        $(response.Data).each(function () {
            if (this.Key == 'AssociatedAttachments') {                
                $(this.Value).insertAfter($(".attachment-article"));
                $(".clear-attachment:eq(0)").remove();
                var attachments = $(".attachment-article");
                $(".toolbar", attachments[1]).replaceWith($(".toolbar", attachments[0]));
                $("#phantom-fileuploader", attachments[1]).replaceWith($("#phantom-fileuploader", attachments[0]));
                $(attachments[0]).remove();
                // Attaches hover event to image to display X button
                gemini_item.attachDelteXHover();
            }
            else if (this.Key == "AssociatedHistory") {
                $(".clear-history-article").remove();
                $(".history-article").replaceWith(this.Value);
                //gemini_ui.collapse($('.expander', '.history-article'));
                gemini_ui.expandCollapse($('.expander', '.history-article').first().parent());
                //co($('.expander', '.history-article').first().parent());

            }
            else if (this.Key == "AssociatedComments") {
                $(".comments-article .qq-upload-list .qq-upload-success").hide();
                $(this.Value).insertAfter($(".clear-comment"));
                $(".clear-comment:eq(0)").remove();

                var comments = $(".comments-article");

                $(".toolbar", comments[0]).replaceWith($(".toolbar", comments[1]));
                $(comments[1]).remove();
                // applies styling to select
                gemini_ui.chosen(".comments-article .option-row .input-size8");
                gemini_item.attachCommentsEditWindowEvents(response.issueId);
                gemini_item.attachCommentsTinyMcEvents(response.issueId, "comments-wysiwyg-content");
                // Attaches hover event to image to display X button
                gemini_item.attachDelteXHover();
                $("#comments-wysiwyg-content").val("");
            }
            else if (this.Key == 'Title') {
                $('h2:last-child', '#content-header-navigation-text').html(this.Value);
            }
            else if (this.Key == 'Description') {
                $(".clear-description-article").remove();
                $(".description-article").replaceWith(this.Value);
            }
            else if (this.Key == 'AssociatedHierarchy') {
                $(".clear-dependencies-article").remove();
                $(".dependencies-article").replaceWith(this.Value);
                gemini_item.attachDependencyEvents(response.issueId);
            }
            else if (this.Key == 'AssociatedLinks') {
                $(".clear-links-article").remove();
                $(".links-article").replaceWith(this.Value);
            }
            else if (this.Key == 'AssociatedWatchers') {
                $(".clear-watchers-article").remove();
                $(".watchers-article").replaceWith(this.Value);
            }
            else if (this.Key == 'AssociatedSourceControl') {
                $(".clear-source-control-article").remove();
                $(".source-control-article").replaceWith(this.Value);
            }
            else if (this.Key == 'AssociatedTime') {
                $(".clear-issue-time-entries-article").remove();
                $(".issue-time-entries-article").replaceWith(this.Value);
            }
            else if (this.Key == 'AttributePane') {
                $('#item-attributes').html(this.Value);
            }
            else if (this.Key == 'ItemNav') {
                $('#view-item .item-nav').html(this.Value);
            }
        });
    },
    attachWatchersEvents: function (issueId)
    {
        $("#watchers-find-item-container").hide();

        $("#watchers-find-item-container input").blur(function (e) {
            $("#watchers-find-item-container").hide();
            $("#watchers-find-item-container input").val("");
        });

        $("#watchers-find-item-container input").keypress(function (e) {
            if (e.keyCode == 27) {
                $("#watchers-find-item-container").hide();
                $("#watchers-find-item-container input").val("");
            }
        });
        
        $(".watchers-article .toolbar .fonticon-plus").click(function (e) {
            e.preventDefault();
            var p = $(".watchers-article .expander").position();
            $("#watchers-find-item-container").show().css("left", p.left).css("top", p.top + 15);
            $("#watchers-find-item-container input").focus();
        });

        $(".watchers-article .section-content .action-button-delete").click(function (e) {
            var id = $(this).parents("tr:eq(0)").attr("data-id");

            gemini_commons.translateMessage("[[Remove]] " + $(this).parents("tr:eq(0)").find("td:eq(0)").html() + "?", ['Remove'], function (message) {
                gemini_popup.modalConfirm(message, null, function () {
                    gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                    gemini_ajax.jsonCall(csVars.ProjectUrl + "item", "deletewatcher/" + issueId + "/" + id,
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
                    url: csVars.Url + csVars.ProjectUrl + "account/getusersdropdown",
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
                gemini_ajax.jsonCall(csVars.ProjectUrl + "item", "addwatcher/" + issueId + '/' + data.item.value,
                        function AddWatchersResponse(response) {
                            if (response.Success)
                            {
                                gemini_item.replaceContent(response.Result.Data);
                                gemini_item.attachWatchersEvents(response.Result.Data.issueId);
                                gemini_ui.flashContent(".watchers-article [data-id='" + response.Result.Data.userId + "']");
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

        $(".dependencies-article .dependency").hover(
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

        $(".dependencies-article .dependency .fonticon-plus").click(function (e) {
            var p = $(this).position();
            $("#dependencies-find-item-container").show().css("left", p.left).css("top", p.top + 15);
            $("#dependencies-find-item-container input").focus();
            baseIssueId = $(this).parent().attr("data-id");
        });

        $(".dependencies-article .toolbar .fonticon-plus").click(function (e) {
            e.preventDefault();
            var p = $(".dependencies-article .expander").position();
            $("#dependencies-find-item-container").show().css("left", p.left).css("top", p.top + 15);
            $("#dependencies-find-item-container input").focus();
            baseIssueId = issueId;
        });

        $(".dependencies-article .dependency .fonticon-cross").click(function (e) {
            var id = $(this).parent().attr("data-id");

            var itemText = $(this).parents("div:eq(1)").find(".thumbnail-name a").html();
            gemini_commons.translateMessage("[[Remove]] " + $(this).parent().find(".item-links span:first").html() + "?", ['Remove'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.jsonCall(csVars.ProjectUrl + "items", "deletedependency/" + issueId + "/" + id,
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

        
        $("#dependencies-find-item-container input").blur(function (e) {
            gemini_item.hideDependencyFindItem();
        });

   
        gemini_commons.inputKeyHandler("#dependencies-find-item-container input", 
            function() 
            {                
                gemini_ajax.jsonCall(csVars.ProjectUrl + "items", "adddependency/" + issueId + '/' + baseIssueId + '/' + $("#dependencies-find-item-container input").val(),
                   function AddDependencyResponse(response) {                       
                       if (response.Result.Data.success) {
                           
                           gemini_item.replaceContent(response.Result.Data);
                           //gemini_item.attachDependencyEvents(response.Result.Data.issueId);
                           gemini_ui.flashContent(".dependencies-article [data-id='" + response.Result.Data.childIssueId + "']");
                       }
                       else {
                           
                           if (response.Result.Data.Message) {                           
                               gemini_popup.toast(response.Result.Data.Message);
                           }
                           else if (response.Message) {                              
                               gemini_popup.toast(response.Message);
                           }
                       }
                       gemini_item.hideDependencyFindItem();
                    }
                );
              

            }, function () {gemini_item.hideDependencyFindItem();})

        gemini_item.hideDependencyFindItem();

        $("#dependencies-find-item").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: csVars.Url + csVars.ProjectUrl + "item/" + issueId + "/getissuesdropdown",
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
                gemini_ajax.jsonCall(csVars.ProjectUrl + "items", "adddependency/" + issueId + '/' + baseIssueId + '/' + data.item.value, 
                        function AddDependencyResponse(response) {
                            if (response.Success)
                            {
                                gemini_item.replaceContent(response.Result.Data);
                                //gemini_item.attachDependencyEvents(response.Result.Data.issueId);
                                gemini_ui.flashContent(".dependencies-article [data-id='" + response.Result.Data.childIssueId + "']");
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

        $(".links-article #links-find-item-container .fonticon-cross").click(function (e) {
            gemini_item.hideLinkFindItem();
        });

        $(".links-article #links-find-item-container form").validate();

        $(".links-article .toolbar .fonticon-plus").click(function (e) {
            e.preventDefault();
            var p = $(".links-article .expander").position();
            $("#links-find-item-container").show().css("left", p.left).css("top", p.top + 15);
            $("#links-find-item-container #links-find-item").focus();

        });

        $("#links-find-item-container").hide();
        $("#links-find-item").keyup(function () {
            if ($(this).val() == "") $("#links-find-item-id").val("");
        });

        function post_link() {
            if ($("#links-find-item").val() != "") {

                if ($("#links-find-item-id").val() == '') {
                    $("#links-find-item-id").val($("#links-find-item").val());
                }

                gemini_ajax.jsonCall(csVars.ProjectUrl + "item/" + issueId, "addlink/" + $("#links-find-item-id").val() + '/' + $(".links-article #linktypes").val(),
                            function AddLinkResponse(response) {
                                if (response.Success) {
                                    gemini_item.replaceContent(response.Result.Data);
                                    gemini_item.attachLinksEvents(response.Result.Data.issueId);
                                    gemini_ui.chosen(".links-article #links-find-item-container #linktypes");
                                    $("#links-find-item-container #links-find-item").val("");
                                    $("#links-find-item-container").hide();

                                    gemini_ui.flashContent(".links-article [data-id='" + response.Result.Data.linkedIssueId + "']");
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
                $(".links-article #links-find-item-container form").valid();
        }

        $(".links-article .fonticon-tick").click(function () {
            post_link();
        });

        gemini_commons.inputKeyHandler(".links-article #links-find-item",
            function () {
                post_link();
            }, function () { gemini_item.hideLinkFindItem(); })

        $(".links-article .section-content .action-button-delete").click(function () {
            var title = $(this).parents("tr:eq(0)").attr("data-id");

            gemini_commons.translateMessage("[[Remove]] [[Link]] " + $(this).parents("tr:eq(0)").find("td:eq(1) a").html() + "?", ['Remove', 'Link'], function (message) {
                gemini_popup.modalConfirm(message, null,
                    function () {
                        gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                        gemini_ajax.jsonCall(csVars.ProjectUrl + "item/" + issueId, "deletelink/" + title,
                            function DeleteLinkResponse(response) {
                                if (response.Success)
                                {
                                    gemini_item.replaceContent(response.Result.Data);
                                    gemini_item.attachLinksEvents(response.Result.Data.issueId);
                                    gemini_ui.chosen(".links-article #links-find-item-container #linktypes");
                                }
                                gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
                            }, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }
                        );
                    }
                );
            });

        });

        $("#links-find-item").keypress(function (e) {
            if (e.keyCode == 27) $(".links-article #links-find-item-container .fonticon-cross").click();
        });

        $("#links-find-item").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: csVars.Url + csVars.ProjectUrl + "item/" + issueId + "/getissuesdropdown",
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
    }
};