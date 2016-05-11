gemini_account = {
    profileTab: null,

    initLogin: function () {
        $("#regular-form").validate({});
        $("#openid-form").validate({});
        $('#forgot-password-form').validate({});
        $('#Username').focus();
        $("#openid-provider-openid").addClass("openid-provider-button-selected");

        $("#openid-signin").click(function (e) {
            if ($("#openid-form").valid()) {
                $('#spinner').spin(gemini_ui.spinnerOptions);
                gemini_account.DisableFormSubmit("openid-form");
            }
        });

        if (window.location.hash.length != 0) {
            accessToken = window.location.hash.substring(1);
            graphUrl = "https://graph.facebook.com/me?" + accessToken + "&callback=gemini_account.displayUser";
            //use JSON-P to call the graph
            var script = document.createElement("script");
            script.src = graphUrl;
            document.body.appendChild(script);
        }

        $('.help-box').click(function (e) {
            e.preventDefault();
            e.stopPropagation();
            var pos = $('.help-box').position();
            $('.help-popup').css('left', pos.left);
            $('.help-popup').css('top', pos.top);
            $('.help-popup').slideDown();
        });
       
        $('#login-page #email').keydown(function () {
            $('#forgot-password').removeClass('button-secondary').addClass('button-primary');
        });

        $('body').click(function (e) {
            if ($(e.target).attr("id") != "email") {
                if ($(e.target).closest("div").hasClass("help-popup")) return;
                $('.help-popup').slideUp();
            }
        });

        gemini_ui.fancyInputs('.fancy');

        if (gemini_commons.isMobile()) $('.right-box').removeClass('right-box');
        /*$("#forgot-password").unbind('click').click(function () {
            if ($("#email").val() != '') {
                gemini_ajax.postCall("account", "forgot-password", null, null, $("#forgot-password-form").serialize());
            }
        });*/
    },

    initLoginWait: function () {
        $('#spinner').spin(gemini_ui.spinnerOptions);
        if (window.location.hash.length != 0) {
            accessToken = window.location.hash.substring(1);
            graphUrl = "https://graph.facebook.com/me?" + accessToken + "&callback=gemini_account.displayUser";
            //use JSON-P to call the graph
            var script = document.createElement("script");
            script.src = graphUrl;
            document.body.appendChild(script);
        }
    },
    initForceNewPassword: function ()
    {
        $('#the-password').focus();
        if (gemini_commons.isMobile()) $('.right-box').removeClass('right-box');
    },
    initRegister: function () {
        $("#regular-form").validate({ rules: { confirmpassword: { required: true, equalTo: "#regular-password"}} });
        $('#Username').focus();
        if (gemini_commons.isMobile()) $('.right-box').removeClass('right-box');
    },

    initProfile: function (saved, error)
    {
        $("#regular-form").validate({ rules: { confirmpassword: { equalTo: "#regular-password"}} });
        gemini_ui.fancyInputs('#regular-form .fancy');
        gemini_ui.chosen("#regular-form select", false, true);

        $('#Firstname').focus();

        $("#api-key").click(function(e) {
            gemini_ajax.jsonCall("account", "apikey", function (response) {
                $("#ApiKey").val(response.Result.Data);
            }, null, null, null, true);
        });

        $('.avatar-option').unbind('ifChecked').bind('ifChecked', function (e) {
            if ($(this).attr('id') == 'option-upload') {
                $('#upload-avatar').removeClass('invisible');
               
                if (csVars.IEVersion == -1) $('#upload-avatar #avatar').click();
            }
            else {
                $('#upload-avatar').addClass('invisible');
            }
        });

        if (saved) {
            var hasError = (error == "True") ? true : false;
            gemini_popup.toast(saved, hasError);
        }
    },

    displayUser: function (user) {
        gemini_ajax.postCall("account", "registerfb",
            function (data)
            {
                if (data.Message == "Missing")
                {
                    window.location = csVars.Url + "account/profile";
                }
                else
                {
                    window.location = csVars.Url;
                }

            }, null, { user: user }, null, true);
    },

    DisableFormSubmit: function (formName) {
        $('#' + formName).submit(function () {
            $('input[type=submit]', this).attr('disabled', 'disabled');
        });
    },

    openIdUrl: function (site) {
        var value = "";
        var autoClick = false;

        $("openid-provider-button").removeClass("openid-provider-button-selected");

        if (site == "openid") {
            value = "<Your Account>.myopenid.com";
            $("openid-provider-openid").addClass("openid-provider-button-selected");
            $("#openid-inputs").show();
        }
        else if (site == "google") {
            value = "https://www.google.com/accounts/o8/id";
            autoClick = true;
            $("openid-provider-google").addClass("openid-provider-button-selected");
        }
        else if (site == "yahoo") {
            value = "https://me.yahoo.com";
            autoClick = true;
        }

        $('#site').val(site);

        if (value) {
            var jText = $("#openid-provider");
            jText.val(value).focus();

            if (autoClick)
                $("#openid-signin").trigger("click");
        }
    },

    personalDashboard: function ()
    {
        $(".table-scroll", "#personal-dashboard").jScrollPane('reinitialise');

        $('#Labels').change(function () {
            var labelId = $(this).val();

            gemini_ajax.jsonCall("dashboard", "getprojectsforlabel", function (response) {
                if (response.success) {
                    $('#workload .right-zone .projects').replaceWith(response.Result.Html);
                }
            }, null, { labelId : labelId}, null, true);
        });
    },
    bindProfile: function ()
    {
        $('.user-options .open-profile').click(function (e) {
            e.preventDefault();

            var availableHeight = gemini_sizing.availableHeight();        
            $("#cs-popup-center-content").css("width", '700px');
            $("#cs-popup-center-content").css("height", '450px');
            
            gemini_commons.translateMessage("[[Save]],[[Cancel]]", ['Save', 'Cancel'], function (message) {
                var translations = message.split(",");
                add = translations[0];
                cancel = translations[1];
                gemini_popup.centerPopup("account", 'profile', null, null, add, cancel, null, null,
                       function (response) {

                           $('#cs-popup-center-content').html(response.Result.Data.html);                       
                           $('#cs-popup-add', '#cs-popup-center-content').show();
                     
                           gemini_account.initProfile();

                           $('.tab', '#cs-popup-center-content').click(function () {
                               $('.tab.selected', '#cs-popup-center-content').removeClass('selected').addClass('normal');
                               $('.cs-popup-tab-content.selected', '#cs-popup-center-content').removeClass('selected');

                               $(this).addClass('selected').removeClass('normal');                           
                               $('#' + $(this).attr('data-tab-id'), '#cs-popup-center-content').addClass('selected');
                           });
                       

                           $("#popup-button-no", "#cs-popup-center").click(function (e) {
                               gemini_popup.popupClose(e);
                           });

                           var options = {
                               url: gemini_ajax.getUrl('account','profile', true),
                               dataType: "json",
                               success: function (responseText, statusText, xhr, $form) {
                                   if (responseText.success) {
                                       gemini_popup.popupClose(e);
                                       if (responseText.Result.Data.refresh) {
                                           location.reload();                                       
                                       }
                                       else if (responseText.Result.Data.updateName)
                                       {
                                           $('.user-options .open-profile').text(responseText.Result.Data.name);

                                           if ($('#filter-form').length > 0)
                                           {
                                               gemini_filter.getFilteredItemsCurrentPage();
                                           }
                                       }
                                       gemini_popup.toast(responseText.Result.Data.saved);
                                   }
                                   else
                                   {
                                       $('#cs-popup-profile-header span[data-tab-id=password]').click();
                                       var errorElement = $('.cs-popup-tab-content.selected .error', '#cs-popup-center-content');
                                       errorElement.removeClass('hide');
                                       $('td:last', errorElement).html(responseText.Message);
                                       $('#the-password').val('');
                                       $('#confirm-password').val('');
                                       $('#current-password').val('');
                                       $('#cs-popup-center .password-meter-bar').attr('class','password-meter-bar password-meter-too-short');
                                   }
                               } // post-submit callback  

                           };
                           $("#cs-profile-view #regular-form").ajaxForm(options);

                           $("#popup-button-yes", "#cs-popup-center").click(function (e) {
                               if ($("#cs-profile-view #regular-form").valid()) {
                                   $("#cs-profile-view #regular-form").submit();                               
                               }
                           });

                           // Fix for browsers (i.e IE9) which don't support placeholder attribute
                           if (!Modernizr.input.placeholder) {
                               $("#edit-appnav-card input[type=text]").each(function () {
                                   gemini_ui.legacyPlaceholder($(this));
                               });
                           }
                       
                           if ($('#cs-popup-center #Firstname').val() == '' || $('#cs-popup-center #Surname').val() == '' || $('#cs-popup-center #Email').val() == '')
                           {
                               $('#cs-popup-center #popup-button-no').hide();
                           }

                           if(gemini_account.profileTab)
                           {
                               $('.tab[data-tab-id=' + gemini_account.profileTab + ']').click();
                               gemini_account.profileTab = null;
                           }

                       }, true);
                });
        });
    }
};