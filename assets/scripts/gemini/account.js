gemini_account = {
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

    initRegister: function () {
        $("#regular-form").validate({ rules: { confirmpassword: { required: true, equalTo: "#regular-password"}} });
        $('#Username').focus();
        if (gemini_commons.isMobile()) $('.right-box').removeClass('right-box');
    },

    initProfile: function (saved)
    {
        $("#regular-form").validate({ rules: { confirmpassword: { equalTo: "#regular-password"}} });
        gemini_ui.fancyInputs('#regular-form .fancy');
        $('#Firstname').focus();

        $("#api-key").click(function(e) {
            gemini_ajax.jsonCall("account", "apikey", function (response) {
                $("#ApiKey").val(response.Result.Data);
            });
        });

        $('.avatar-option').unbind('ifClicked').bind('ifClicked', function (e) {
            if ($(this).attr('id') == 'option-upload') {
                $('#upload-avatar').removeClass('invisible');
               
                if (csVars.IEVersion == -1) $('#upload-avatar #avatar').click();
            }
            else {
                $('#upload-avatar').addClass('invisible');
            }
        });

        if (saved) {
            gemini_popup.toast(saved);
        }
    },

    displayUser: function (user) {
        $.ajax({
            type: "POST",
            url: csVars.Url + "account/registerfb",
            data: { user: user },
            success: function (data, textStatus, XMLHttpRequest) {
                if (data.Message == "Missing") window.location = csVars.Url + "account/profile";
                else window.location = csVars.Url;
            },
            error: function (xhr, status, error) {

            }
        });
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

        if (value) {
            var jText = $("#openid-provider");
            jText.val(value).focus();

            if (autoClick)
                $("#openid-signin").trigger("click");
        }
    }
};