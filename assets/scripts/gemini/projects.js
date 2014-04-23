gemini_projects = {
    initAllProjects: function () {

        $(".projects-list").disableSelection();

        $(".projects-dropdown-toggle").click(function(e) {

            var dropdown = $(this).find(".projects-dropdown-box");

            var toggleImage = $(this).find(".toggle-image");

            if ($(dropdown).is(":visible"))
            {
                $(dropdown).fadeOut('fast');
                $(toggleImage).addClass("fonticon-arrow-right");
                $(toggleImage).removeClass("fonticon-arrow-down");
            }
            else
            {
                $(".toggle-image").each(function ()
                {
                    $(this).removeClass("fonticon-arrow-down");
                    $(this).addClass("fonticon-arrow-right");
                });

                $(toggleImage).removeClass("fonticon-arrow-right");
                $(toggleImage).addClass("fonticon-arrow-down");

                $(".projects-dropdown-box").hide();

                $(dropdown).show();
                $(dropdown).position({
                    "of": this,
                    "my": "left top",
                    "at": "left bottom",
                    "offset": "0 -2",
                    "collision": "none"
                });
                
                $(dropdown).jScrollPane({ autoReinitialise: true, autoReinitialiseDelay: 250 });
            }
        });
    },
    
    initSettings: function (projectId) {
        $(".tab", "#project-administration").unbind('click').click(function(e) {
            gemini_commons.stopClick(e);

            $(".tab", "#project-administration").each(function ()
            {
                $(this).addClass("normal");
                $(this).removeClass("selected");
            });

            $(this).addClass("selected");
            
            if ($(this).attr("data-tab") == "components")
            {
                gemini_projects.settingsComponents(projectId);
            }
            else if ($(this).attr("data-tab") == "versions")
            {
                gemini_projects.settingsVersions(projectId);
            }
            else if ($(this).attr("data-tab") == "defaults") {
                gemini_projects.settingsDefaults(projectId, 0);
            }
            else if ($(this).attr("data-tab") == "cflookup") {
                gemini_projects.settingsCFLookup(projectId, 0);
            }
        });
        
        gemini_ui.chosen('#project-administration #ProjectId');
        $('#project-administration #ProjectId').change(function ()
        {
            gemini_popup.centerPopup("project", "settings", { projectId: $(this).val() }, null, null, 'Close', true);
        });

        $(".tab", "#project-administration").first().click();

        $("#popup-button-no").click(function (e)
        {
            gemini_ui.destroyHtmlEditor('#defaults-form .wysiwyg-editor');
            $('#cs-popup-center-content').empty();
            gemini_popup.popupClose(e);
        });
    },
    
    settingsComponents: function (projectId)
    {
        gemini_ajax.jsonCall("project/" + projectId + "/settings", "components", function (response)
        {
            gemini_ui.destroyHtmlEditor('#defaults-form .wysiwyg-editor');
            $("#setting-zone", "#project-administration").html(response.Result.Html);
            gemini_sizing.stretchWindow();
        }, null, null, null, true);
    },

    settingsVersions: function (projectId)
    {
        gemini_ajax.jsonCall("project/" + projectId + "/settings", "versions", function (response)
        {
            gemini_ui.destroyHtmlEditor('#defaults-form .wysiwyg-editor');
            $("#setting-zone", "#project-administration").html(response.Result.Html);
            gemini_sizing.stretchWindow();
        }, null, null, null, true);
    },

    settingsDefaults: function (projectId, typeId) {
        gemini_ajax.jsonCall("project/" + projectId + "/settings", "defaults", function (response)
        {
            gemini_ui.destroyHtmlEditor('#defaults-form .wysiwyg-editor');
            $("#setting-zone", "#project-administration").empty();
            $("#setting-zone", "#project-administration").html(response.Result.Html);
            gemini_ui.fancyInputs('#defaults-form .fancy');
            gemini_sizing.stretchWindow();
        }, null, { typeId: typeId }, null, true);
    },
    settingsCFLookup: function (projectId, fieldId)
    {
        gemini_ui.destroyHtmlEditor('#defaults-form .wysiwyg-editor');
        gemini_ajax.jsonCall("project/" + projectId + "/settings", "cflookup", function (response) {
            $("#setting-zone", "#project-administration").html(response.Result.Html);
        }, null, { id: fieldId, projectId: projectId }, null, true);
    }
};
