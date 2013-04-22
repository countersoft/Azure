var gemini_share = {
    init: function () {

        $('#share-page').click(function () {
            if ($("#share-page").hasClass("selected")) {
                $("#share-page").toggleClass("selected");
                $('#share-dialog').fadeOut('fast');
                return;
            }
            
            gemini_share.showShare("right top", "left bottom", "10 -12", this, 
                gemini_appnav.pageCard.Id, JSON.stringify(gemini_appnav.pageCard));
        });
    },
    EscapeCardDropdowns: function (guid, selector) {
        $(selector).fadeOut('fast');
        gemini_keyboard.unbindEscape(selector);
    },
    showShare: function (my, at, offset, owner, cardId, cardData) {

        $.ajax({
            type: "POST",
            url: csVars.Url + 'share/start/' + cardId,
            data: cardData,
            dataType: "json",
            success: function (response)
            {
                $("#share-page").toggleClass("selected");

                // Render UI                
                $('#share-dialog').html(response.Result.Data);
               
                // Share with someone
                $('#share-submit').click(function () {
                    $.ajax({
                        type: "POST",
                        url: csVars.Url + 'share/submit',
                        data: $('#share-form').serialize(),
                        success: function (response) {
                            $('#share-dialog').fadeOut('fast');
                            $("#share-page").toggleClass("selected");
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                        }
                    });
                });

                $('#share-dialog').fadeIn('fast');
                
                $('#share-dialog').position({
                    "my": my,
                    "at": at,
                    "of": owner,
                    "offset": offset, 
                    "collision": "none"
                });
                gemini_keyboard.bindEscape("#share-dialog", gemini_share.EscapeCardDropdowns);
            },
            error: function (xhr, ajaxOptions, thrownError) {
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
            }
        });
    },
    
    showSubscribe: function (my, at, offset, owner, cardId, cardData)
    {
        $.ajax({
            type: "POST",
            url: csVars.Url + 'subscribe/start/' + cardId,
            data: cardData,
            dataType: "json",
            success: function (response)
            {
                // Render UI                
                $('#subscribe-dialog').html(response.Result.Data);

                // Dismiss dialog 
                /*$('#subscribe-dialog').click(function (e)
                {
                    if ($(e.target).is("input") || $(e.target).is("label")) return;

                    $('#subscribe-dialog').fadeOut('fast');
                });*/

                // Share with someone
                $('#subscribe-submit').click(function ()
                {
                    $.ajax({
                        type: "POST",
                        url: csVars.Url + 'subscribe/submit',
                        data: $('#subscribe-form').serialize(),
                        success: function (response)
                        {
                            $('#subscribe-dialog').fadeOut('fast');
                        }
                    });
                });

                $('#subscribe-dialog').fadeIn('fast');

                $('#subscribe-dialog').position({
                    "my": my,
                    "at": at,
                    "of": owner,
                    "offset": offset,
                    "collision": "none"
                });
                gemini_keyboard.bindEscape("#subscribe-dialog", gemini_share.EscapeCardDropdowns);
            }
        });
    }
};


