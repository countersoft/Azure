gemini_notifications =
{
    backgroundImage: '',
    stopEffect: false,
    currentXHR: null,

    init: function ()
    {
        $("#pinned-list i").hoverIntent({
            interval: 250,
            over: function () {
                if (!$('#pinned-list #pinned-panel').is(':visible')) {
                    gemini_notifications.fetch();
                }
            }, out: function() {
                var x = 1;
            }
        });

        $("#pinned-list i").click(function () {
            if (!$('#pinned-list #pinned-panel').is(':visible')) 
            {
                gemini_notifications.fetch();
            }
            else 
            {
                gemini_notifications.hide();
            }
        });

        $("#pinned-panel").on('mouseleave', function () {
            if ($('#pinned-list #pinned-panel').is(':visible')) {
                gemini_notifications.hide();
            }
        });
    },

    fetchLastItem: function () {

        gemini_notifications.currentXHR = gemini_ajax.postCall('notifications', '',
            gemini_notifications.renderLast, null, { mode: 'last-item' });

    },

    renderLast: function (response) {
        if (response.success) {
            $("#workspace-notifications-zone").replaceWith(response.Result.Data.Html);
            $("#workspace-notifications-zone").slideDown();

            setTimeout(function () {
                $("#workspace-notifications-zone").slideUp();
            },
                5000);
        }
    },

    fetch: function () {
        if (gemini_notifications.currentXHR != null) {
            gemini_notifications.currentXHR.abort();
        }
        else {
            // gemini_notifications.backgroundImage = $('.notification', '#appnav-toolbar-notifications').css('background-image');
        }


        gemini_ui.runSpinner('notification', '#pinned-list #spinner', 20, 16);
        //$('.notification', '#appnav-toolbar-notifications').css('background-image', 'none');

        gemini_notifications.currentXHR = gemini_ajax.postCall('notifications', '',
            gemini_notifications.render, null, { mode: '' });
    },

    render: function (response) {
        if (response.success) {
            //ensure the just created notification goes away.
            $("#workspace-notifications-zone").hide();

            $("ul#updated-items").empty();
            if (response.Result.Data.RecentItems != undefined) {
                $.each(response.Result.Data.RecentItems, function (index, item) {
                    var li = "<li>";
                    if (item.ItemId > 0) {
                        li += "<a href=\"" + csVars.Url + item.Url + "\">" +
                            item.Label.replaceAll('<', '&lt;') +
                            "</a>";
                    } else {
                        li += item.Label.replaceAll('<', '&lt;');
                    }
                    li += "</li>";
                    $("ul#updated-items").append(li);
                });
            }
            $("ul#pinned-items").empty();

            if (response.Result.Data.PinnedItems != undefined) {
                $.each(response.Result.Data.PinnedItems, function (index, item) {
                    if (item.ItemId > 0) {
                        $("ul#pinned-items").append("<li class=\"pinned-item\">" +
                            "<i class=\"fad fa-thumbtack\" data-itemid=\"" + item.ItemId + "\"></i>" +
                            "<a href=\"" + csVars.Url + item.Url + "\" title=\"" + item.Label.replaceAll('<', '&lt;') + "\">" +
                            item.Label.replaceAll('<', '&lt;') +
                            "</a>" +
                            "</li>" +
                            "");
                    } else {
                        $("ul#pinned-items").append("<li>" + item.Label.replaceAll('<', '&lt;') + "</li>");
                    }
                });


                $("ul#pinned-items li").hoverIntent({
                    interval: 150,
                    over: function () {
                        var removetitle = $(this).parent().data("remove-pin-title");
                        var addtitle = $(this).parent().data("add-pin-title");
                        var removed = $(this).data("removed") == true;
                        if (removed) {
                            $(this).find("i").removeClass("fa-thumbtack").addClass("fa-plus-square").attr("title", addtitle);
                        } else {
                            $(this).find("i").removeClass("fa-thumbtack").addClass("fa-times").attr("title", removetitle);
                        }

                    },
                    out: function () {
                        $(this).find("i").addClass("fa-thumbtack").removeClass("fa-times").removeClass("fa-plus-square");
                    }
                });

                $("ul#pinned-items li i").click(function () {
                    var itemId = $(this).data("itemid");
                    gemini_items.addRemovePin(itemId);
                    var li = $(this).parent();

                    if (li.data("removed") == true) {
                        li.data("removed", false);
                        li.css("text-decoration", "none");
                    } else {
                        li.data("removed", true);
                        li.css("text-decoration", "line-through");
                    }


                });

                $("#pinned-list .number").html(response.Result.Data.PinnedItems.length);
            }


            gemini_notifications.show();



            /*if (gemini_notifications.stopEffect)
            {
                
            }
            else
            {
                setTimeout(function () { gemini_notifications.show(); }, 200);
            }*/
        }
    },
    
    show: function () {
        $("#pinned-panel").slideDown();
        gemini_notifications.afterShow();
        /*if (gemini_notifications.stopEffect)
        {
            gemini_notifications.stopEffect = false;

            $("#workspace-notifications-zone").show();

            gemini_notifications.afterShow();
        }
        else
        {
            $('#workspace-notifications-zone').show('slide', { direction: 'up' }, 250, function ()
            {
                gemini_notifications.afterShow();
            });
        }*/
    },
    
    afterShow: function ()
    {
        gemini_ui.removeSpinner('notification', '#pinned-list #spinner');

        //$('.notification', '#appnav-toolbar-notifications').css('background-image', gemini_notifications.backgroundImage);
    },
    
    hide: function ()
    {
        $('#pinned-panel').hide('slide', { direction: 'up' }, 250);
    },

    refreshCount: function (count) {
        if (count === 0) {
            $("#zone-header-bar #pinned-list .number").removeClass("shown");
        } else {
            $("#zone-header-bar #pinned-list .number").addClass("shown").html(count);
        }
        
    }
};