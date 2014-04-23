gemini_documents = {
    init: function (temp_upload, temp_dropzone, temp_delete, readOnly) {
        $("#tree").dynatree({
            onActivate: function (n) {

                gemini_documents.document_FolderList(n.data.key);

            },
            debugLevel: 0,
            persist: false,
            generateIds: true, //important for inline editing to work
            clickFolderMode: 1,
            fx: { height: "toggle", duration: 200 },
            initAjax: {
                url: gemini_ajax.getUrl(csVars.ProjectUrl + "documents", "LoadTree"),
                data: {}
            },
            onRender: function () {
                if (!readOnly) {
                    gemini_documents.contextMenu(".dynatree-node");
                }
            },
            onPostInit: function (isReloading, isError) {
                var nodeList = $("#tree").dynatree("getRoot").getChildren();

                var node;
                for (var i = 0; i < nodeList.length; i++) {
                    if (!nodeList[i].isStatusNode()) {
                        node = nodeList[i];
                    }
                }
                if (node != null)
                    gemini_documents.document_FolderList(node.data.key);
            }
        });

        $("#folders").resizable({ handles: 'e' });

        $("#DocumentFolderRenamer input").blur(function () {
            $("#DocumentFolderRenamer").fadeOut();
            $('#DocumentFolderRenamer #NewName').removeClass('error');

            var node = $("#tree").dynatree("getTree").selectKey('new');
            if (node) {
                node.remove();
                $('#dynatree-id-new').remove();
            }
        });

        gemini_documents.document_uploader = null;
        if (readOnly) return;

        gemini_commons.inputKeyHandler("#DocumentFolderRenamer input",
                        function () {
                            // return key
                            var id = $("#DocumentFolderRenamer #NodeId").val();
                            var parentId = $("#DocumentFolderRenamer #ParentNodeId").val();
                            var newName = $("#DocumentFolderRenamer #NewName").val();
                            if (newName.length == 0)
                            {
                                $('#DocumentFolderRenamer #NewName').addClass('error');
                                return;
                            }
                            gemini_documents.document_FolderRename(id, newName, parentId);
                            $("#DocumentFolderRenamer").fadeOut();
                        },
                        function () {
                            //escape
                            $("#DocumentFolderRenamer").fadeOut();
                            var node = $("#tree").dynatree("getTree").selectKey("new");
                            if (node)
                                node.remove();
                        }
                    );

        gemini_documents.document_uploader = new qq.FileUploader({
            element: $("#page-documents #fileupload-hit")[0],
            action: gemini_ajax.getUrl(csVars.ProjectUrl + "documents", "UploadFile"),
            debug: false,

            onComplete: function (_id, fileName, responseJSON) {
                // insert image into page
                var id = responseJSON.fileId;
                var folderid = responseJSON.folderId;
                gemini_documents.document_FolderList(folderid);
            },
            taxonomy: {
                uploadButton: temp_upload,
                dropZone: temp_dropzone
            }
        });
        $.extend(gemini_documents.document_taxonomy, {
            uploadButton: temp_upload,
            dropZone: temp_dropzone,
            deleteText: temp_delete
        });

        $(document).on('click', "span.delete-action", function () {
            var id = $(this).attr("data-id");
            var itemText = $(this).closest("tr").children("td:eq(0)").children("a").text();
            gemini_commons.translateMessage("[[Delete]] : " + itemText + "?", ['Delete'], function (message) {
                gemini_popup.modalConfirm(message, null,
                        function () {
                            gemini_ui.startBusy('#modal-confirm #modal-button-yes');
                            gemini_ajax.call(csVars.ProjectUrl + "documents", "DeleteDocument", gemini_documents.document_removeDocument, function () { gemini_ui.stopBusy('#modal-confirm #modal-button-yes'); }, { documentId: id });
                        }
                    );
            });


        });
        $(document).on('click', "span.refresh-action", function () {
            var id = $(this).attr("data-id");

            $(".qq-upload-button input").prop('multiple', '');
            gemini_documents.document_uploader.setParams({ documentId: id });

            $(".qq-upload-button input").click();
            $(".qq-upload-button input").prop('multiple', 'multiple');

        });
        
        $(document).on('click', "span.description-action", function () {
            
            //remove all other textboxes
            var inputs = $(this).closest("table").find("td input:text");

            $.each(inputs, function (index, item) {
                $(item).parent().html($(item).val());
            });

            var id = $(this).attr("data-id");
            var td = $(this).closest("tr").children("td:eq(1)");
            var text = td.text();

            var tb = $("<input type='text' name='document-description' id='document-description' class='width-100' value='" + text + "'></input>");
            tb.bind('blur', function () {
                td.html(text);
            });
            gemini_commons.inputKeyHandler(tb,
                function () {
                    var newtext = $(tb).val();

                    gemini_ajax.postCall(csVars.ProjectUrl + "/documents", "savedescription", function (response) {
                        if (response.Success) {
                        
                            td.empty();
                            td.html(newtext);
                        }
                        else {
                            td.empty();
                        }
                    }, null, {fileId: id, description: newtext});

                },
                function () {
                    td.html(text);
                }
            );
            td.empty().append(tb);
            tb.focus();
        });
    },
    document_taxonomy: {},
    document_removeDocument: function (response) {
        if (response.Success) {
            var id = response.Result.Data.id;
            $("#filelist-container tr[data-id='" + id + "']").remove();
        }
        gemini_ui.stopBusy('#modal-confirm #modal-button-yes');
    },
    document_uploader: null,
    document_FolderListed: function (response) {
        $("#page-documents #filelist-container").html(response);
    },
    document_FolderList: function (key) {
        if (gemini_documents.document_uploader != null) {
            gemini_documents.document_uploader.setParams({ folderId: key });
        }
        var opts = {
            key: key
        };
        gemini_ajax.call(csVars.ProjectUrl + "documents", "GetFolderContents", gemini_documents.document_FolderListed, null, opts);
    },
    document_FolderRename: function (key, newName, parent) {

        //alert("key = " + node.data.key);
        //alert("new name = " + newName);

        /*            $("#DocumentFolderRenamer").fadeOut('slow');*/
        var opts = {
            key: key == "new" ? -1 : key,
            name: newName,
            parent: parent
        };
        if (parent > 0)
            gemini_ajax.call(csVars.ProjectUrl + "documents", "rename", gemini_documents.document_FolderCreated, null, opts);
        else
            gemini_ajax.call(csVars.ProjectUrl + "documents", "rename", gemini_documents.document_FolderRenamed, null, opts);


    },
    document_FolderCreated: function (response) {
        var node = $("#tree").dynatree("getTree").selectKey("new");
        var parentId = response.Result.Data.BaseEntity.ParentDocumentId;
        node.remove();

        node = $("#tree").dynatree("getTree").selectKey(parentId);

        node.addChild({
            title: response.Result.Data.BaseEntity.Name,
            key: response.Result.Data.BaseEntity.Id,
            isFolder: response.Result.Data.BaseEntity.IsFolder,
            expand: false //true if all folders are expanded
        });
    },
    document_FolderRenamed: function (response) {
        var node = $("#tree").dynatree("getTree").selectKey(response.Result.Data.BaseEntity.Id);
        node.data.title = response.Result.Data.BaseEntity.Name;
        node.render();
    },
    document_FolderDeleted: function (key) {
        var node = $("#tree").dynatree("getTree").selectKey(key);
        node.remove();
    },
    document_FolderDeleting: function (node) {
        //alert("Delete " + node.data.title);
        gemini_ajax.call(csVars.ProjectUrl + "documents", "DeleteFolder",
            function () {
                gemini_documents.document_FolderDeleted(node.data.key);
            }, null, { folderId: node.data.key });
    },

    document_menuRenameFolder: function (element, parent) {

        var elem = $(element);
        var id = elem.parent("li").attr("id").replace("dynatree-id-", "");
        var node = $("#tree").dynatree("getTree").selectKey(id);
        var namer = $("#DocumentFolderRenamer");

        namer.show();
        namer.position({
            "my": "left top",
            "at": "left top",
            "of": elem,
            "offset": "+35 -2",
            "collision": "none"
        });
        var folders = $("#folders").width() - elem.position().left - 38;
        namer.css("width", folders);

        namer.children("input").val(node.data.title).focus().select();
        namer.children("#NodeId").val(id);
        namer.children("#ParentNodeId").val(parent);
    
    },
    document_menuCreateFolder: function (element) {
        var elem = $(element);
        var id = elem.parent("li").attr("id").replace("dynatree-id-", "");
        var node = $("#tree").dynatree("getTree").selectKey(id);

        var childNode = node.addChild({
            title: "",
            key: "new",
            isFolder: true
        });
        node.expand();

        var el = $("#dynatree-id-new span");

        gemini_documents.document_menuRenameFolder(el, id);
    },
    document_menuDeleteFolder: function (element) {
        var elem = $(element);
        var id = elem.parent("li").attr("id").replace("dynatree-id-", "");
        var node = $("#tree").dynatree("getTree").selectKey(id);

        gemini_popup.modalConfirm(gemini_documents.document_taxonomy.deleteText + ": " + node.data.title, null,
            function () {
                gemini_documents.document_FolderDeleting(node);
            }
            , null);
    },

    /*****************************************
    *** Right click menu
    *****************************************/
    contextMenu: function (selector) {
        if (true) {
            $(selector, '#page-documents').contextMenu({ menu: 'document-folder-context-menu' },
                function (action, el, pos) {
                    if (action == "view") {
                        // nothing here for now
                    }
                    else if (action == "new") {
                        gemini_documents.document_menuCreateFolder(el);
                    }
                    else if (action == "edit") {
                        gemini_documents.document_menuRenameFolder(el, null);
                    }
                    else if (action == "delete") {
                        gemini_documents.document_menuDeleteFolder(el);
                    }
                },
                function (before) {
                }
            );
        }
    }
};