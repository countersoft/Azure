gemini_chat =
{
    backgroundImage: '',
    stopEffect: false,
    currentXHR: null,

    init: function (response)
    {
        gemini_chat.render(response);
        //setTimeout(function () { gemini_chat.fetch(); }, 1000);
    },

    fetch: function (day)
    {
        if (gemini_chat.currentXHR != null)
        {
            gemini_chat.currentXHR.abort();
        }
        else
        {
            gemini_chat.backgroundImage = $('.chat', '#appnav-toolbar-chat').css('background-image');
        }
        
        gemini_ui.runSpinner('chat', '#appnav-toolbar-chat .chat', 20, 16);
        $('.chat', '#appnav-toolbar-chat').css('background-image', 'none');

        gemini_chat.currentXHR = gemini_ajax.postCall('chat', '', gemini_sidepane.renderTab, null, { cardId: gemini_appnav.pageCard.Id, from: $('.range .go-label', '#side-pane .side-pane-toolbar').attr('data-date'), to: '', day: day });
    },
    
    render: function (response)
    {
        if (response.success)
        {
            //$('#workspace-chat-zone').replaceWith(response.Result.Data.Html);
            $('.content', '#workspace-chat-zone').css('height', ($('#side-pane .contents').height() - $('.footer', '#workspace-chat-zone').height() - 40) + 'px')
            if (gemini_chat.stopEffect)
            {
                gemini_chat.show();
            }
            else
            {
                setTimeout(function () { gemini_chat.show(); }, 200);
            }
        }
    },
    
    show: function ()
    {
        if (gemini_chat.stopEffect)
        {
            gemini_chat.stopEffect = false;

            $("#workspace-chat-zone").show();

            gemini_chat.afterShow();
        }
        else
        {
            $('#workspace-chat-zone').show('slide', { direction: 'down' }, 250, function ()
            {
                gemini_chat.afterShow();
            });
        }

        if ($('.go-forward', '#workspace-chat-zone').is(':visible'))
        {
            $('#workspace-chat-zone-input', '#workspace-chat-zone').attr('disabled', 'disabled');
        }
        else
        {
            $('#workspace-chat-zone-input', '#workspace-chat-zone').removeAttr('disabled');
        }

        $(".content", "#workspace-chat-zone").jScrollPane('reinitialise');
        
        gemini_chat.scrollToLastMessage(true);
    },

    isScrolledToBottom: function()
    {
        var api = $(".content", "#workspace-chat-zone").data('jsp');
        if (api.getContentPositionY() + $('.content', '#workspace-chat-zone').height() < api.getContentHeight()) return false;
        
        return true;
    },
    
    scrollToLastMessage: function(force)
    {
        var api = $(".content", "#workspace-chat-zone").data('jsp');
        var lastChat = $(".chat-box:last-child", "#workspace-chat-zone");
        if (lastChat.length)
        {
            if (!force)
            {
                var prev = lastChat.prev();
                if(prev.length)
                {
                    if (api.getContentPositionY() + $('.content', '#workspace-chat-zone').height() < prev.position().top) return;
                }
                
            }
            api.scrollToBottom();
        }
    },

    renderNewChat: function(response)
    {
        $('.empty-state-chat', '#workspace-chat-zone').hide();
        gemini_ui.removeSpinner('chat', '#appnav-toolbar-chat .chat');
        $('.chat', '#appnav-toolbar-chat').css('background-image', gemini_chat.backgroundImage);
        if (!response.success) return;

        gemini_chat.renderChatMessage(response.Result.Data.Html, true)
        $('#workspace-chat-zone-input', '#workspace-chat-zone').val('');
        $('#workspace-chat-zone-input', '#workspace-chat-zone').focus();
    },

    renderChatMessage: function(chatHtml, forceScroll)
    {
        if (chatHtml == null || chatHtml.length == 0) return;
        $('.empty-state-chat', '#workspace-chat-zone').hide();
        $('.chat-box', '#workspace-chat-zone').remove();
        $('.ui-effects-wrapper', '#workspace-chat-zone').remove();
        var lastMessage = $('.chat-box-placeholder', '#workspace-chat-zone');
        lastMessage.after(chatHtml);
        $(".content", "#workspace-chat-zone").jScrollPane('reinitialise');
        gemini_chat.scrollToLastMessage(forceScroll);
        $('.chat-box.new-chat', '#workspace-chat-zone').each(function () { $(this).removeClass('invisible').addClass('hide'); });
        $('.chat-box.hide', '#workspace-chat-zone').show('slide', { direction: 'down' }, 500);

        if (gemini_chat.isScrolledToBottom())
        {
            gemini_ajax.postCall('action', 'clearchatcount', function (response) {
                if (response.success) {
                    gemini_appnav.pageCard.CardData.Chat.BadgeCount = 0;
                    $('#appnav-toolbar-badge-chat').hide();
                    $('#appnav-toolbar-badge-chat2').hide();
                    //gemini_appnav.refresh();
                }
            }, null, { cardId: gemini_appnav.pageCard.Id });
        }

        setTimeout(function ()
        {
            $('.chat-box.new-chat', '#workspace-chat-zone').each(function () { $(this).removeClass('new-chat'); });
        }, 3000);
    },
    
    afterShow: function ()
    {
        gemini_ui.removeSpinner('chat', '#appnav-toolbar-chat .chat');

        $('.chat', '#appnav-toolbar-chat').css('background-image', gemini_chat.backgroundImage);

        $(".minimize", "#workspace-chat-zone").unbind("click").bind("click", function (e)
        {
            gemini_chat.hide();
        });

        $('#workspace-chat-zone-input', '#workspace-chat-zone').unbind('keydown').keydown(function (e)
        {
            var code = e.keyCode || e.which;
            if (code == $.ui.keyCode.ENTER)
            {
                var val = $('#workspace-chat-zone-input', '#workspace-chat-zone').val();
                e.preventDefault();
                if (val == null || val == undefined || val.length == 0) return;
                gemini_ui.runSpinner('chat', '#appnav-toolbar-chat .chat', 20, 16);
                $('.chat', '#appnav-toolbar-chat').css('background-image', 'none');
                var params = gemini_chat.getPostParameters();
                $.extend(params, { text: val });
                gemini_ajax.postCall('chat', 'add', gemini_chat.renderNewChat, null, params);
                return false;
            }
        });

        $('#workspace-chat-zone-input', '#workspace-chat-zone').focus();

        $('.go-back', '#side-pane .side-pane-toolbar').click(function ()
        {
            gemini_chat.stopEffect = true;
            gemini_chat.fetch(-1);
        });

        $('.go-forward', '#side-pane .side-pane-toolbar').click(function ()
        {
            gemini_chat.stopEffect = true;
            gemini_chat.fetch(1);
        });
    },
    
    hide: function ()
    {
        $('#workspace-chat-zone').hide('slide', { direction: 'down' }, 250);
    },

    getPostParameters: function ()
    {
        var from = $('.range .go-label', '#side-pane .side-pane-toolbar');
        if (from.length) {
            from = from.attr('data-date')
        }
        else {
            from = '';
        }

        var chatIds = $('.chat-box', '#workspace-chat-zone');
        if (chatIds.length) {
            var ids = '';
            chatIds.each(function () {
                ids += $(this).attr('data-id') + '|';
            });
            chatIds = ids;
        }
        else {
            chatIds = '';
        }

        return { chat: $('#workspace-chat-zone').is(':visible'), chatIds: chatIds, from: from, to: '' };
    }
};