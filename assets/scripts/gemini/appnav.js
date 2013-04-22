var gemini_appnav = {
    pageCard: "",

    pinPage: function() {
        var url = csVars.Url;
        var removing = false;

        if ($("#pin-page").hasClass("selected")) {
            url = url + "cards/remove";
            removing = true;
        } else {
            url = url + "cards/add";
        }

        var cardData = JSON.stringify(gemini_appnav.pageCard);

        if (removing) gemini_appnav.removeCardAnimate(gemini_appnav.pageCard.Id);

        $.ajax({
            type: "POST",
            url: url,
            data: cardData,
            dataType: "json",
            success: function(response) {
                $("#pin-page").toggleClass("selected");
                $("#card-holder").html(response.Result.Data);
                gemini_appnav.pageCard = response.Result.PageCard;

                if (removing)
                {
                    gemini_appnav.hidePinnedPageActions();
                } else {
                    gemini_appnav.addCardAnimate();
                    gemini_appnav.showPinnedPageActions();
                }
                gemini_appnav.resizer();
                gemini_appnav.initCardActions();
            },
            error: function(xhr, ajaxOptions, thrownError) {
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
            }
        });
    },

    duplicate: function(cardData) {
        if (cardData == null) return;

        var url = csVars.Url + "cards/duplicate/";

        cardData = JSON.stringify(cardData);

        $.ajax({
            type: "POST",
            url: url,
            data: cardData,
            dataType: "json",
            success: function(response) {
                $("#card-holder").html(response.Result.Data);
                gemini_appnav.resizer();
                gemini_appnav.initCardActions();
                window.location.href = csVars.Url + response.Result.PageCard.Url + "?card=" + response.Result.PageCard.Id;
            },
            error: function(xhr, ajaxOptions, thrownError) {
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
            }
        });
    },

    update: function (cardData)
    {
        if (cardData == null) return;
        cardData = JSON.stringify(cardData);

        $.ajax({
            type: "POST",
            url: csVars.Url + "cards/update/",
            data: cardData,
            dataType: "json",
            success: function (response) {
                gemini_popup.toast(response.Result.Message);
            },
            error: function (xhr, ajaxOptions, thrownError)
            {
                gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
            }
        });
    },
    
    removeCardAnimate: function (cardId)
    {
        $('#card-' + cardId).effect("transfer", { to: $('#contents') }, 650);
    },

    addCardAnimate: function (cardId)
    {
        $('#card-' + gemini_appnav.pageCard.Id).effect("shake", { times: 1, distance: 5, direction: "up" }, 300);
        $('#contents').effect("transfer", { to: $('#card-' + gemini_appnav.pageCard.Id) }, 650);
    },

    showPinnedPageActions: function ()
    {
        $("#repin-pin").show();
        $("#save-pin").show();
        
        $("#repin-pin").unbind('click').bind('click', function (e) {
            if (gemini_appnav.pageCard != null) {
                gemini_appnav.duplicate(gemini_appnav.pageCard);
            }
        });

        $("#save-pin").unbind('click').bind('click', function (e) {
            if (gemini_appnav.pageCard != null) {
                gemini_appnav.update(gemini_appnav.pageCard);
            }
        });
    },

    hidePinnedPageActions: function ()
    {
        $("#repin-pin").hide();
        $("#save-pin").hide();
        
        $("#repin-pin").unbind('click');
        $("#save-pin").unbind('click');
    },

    initCardActions: function ()
    {
        // set up actions on cards EXCLUDING system cards
        $(".card-small:not(.card-system)").each(function ()
        {
            gemini_appnav.hover(this);
            gemini_appnav.contextMenu(this);
        });

        $("#card-" + gemini_appnav.pageCard.Id).addClass("card-small-selected");

        //If card-small is being renamed don't go to link if user clicks on it
        $(".card-small a").click(function (e)
        {
            if ($(".card-title-edit", $(this)).length > 0)
            {
                e.preventDefault();
            }

            if (e.target.className == 'fonticon-arrow-down')
            {
                e.preventDefault();
                e.button = 2;
                $(this).closest('.card-small').trigger("mousedown", e).trigger("mouseup", [e]);
            }
        });
    },

    resizer: function () {
        // figure out max height of playlist
        var maxHeight = 0;

        // 82 is the magic number and represents default height in css of playlist zone
        var defaultPlaylistHeight = 82;

        $("#card-holder").children().each(function () {
            maxHeight = $(this).position().top + $(this).height();
        });

        if (maxHeight > defaultPlaylistHeight) {
            // Need expansion zone

            maxHeight += 10; // Padding at the bottom of the expanded zone

            $('#playlist-more').show();

            $('#playlist-more').unbind("click").bind('click', function () {
                if ($("#playlist").hasClass("playlist-expanded")) {
                    $("#playlist").removeClass("playlist-expanded").animate({ height: defaultPlaylistHeight + "px" }, "fast");
                    $("#playlist-more > span").addClass("fonticon-arrow-down").removeClass("fonticon-arrow-up");
                } else {
                    $("#playlist").addClass("playlist-expanded").animate({ height: maxHeight + "px" }, "fast");
                    $("#playlist-more > span").addClass("fonticon-arrow-up").removeClass("fonticon-arrow-down");

                }
            });
        }
        else {
            // No need for expansion zone
            $("#playlist-more").unbind("click");
            $('#playlist-more').hide();
        }
    },

    manager: function (displayPageActions)
    {
        var delay = csVars.IEVersion == -1 || csVars.IEVersion >= 9 ? 250 : 0;
        
        $("#card-holder").sortable({
            forcePlaceholderSize: true,
            placeholder: "drag-placeholder",
            connectWith: ".card-small",
            items: ".card-small:not(.card-system)",
            delay: delay,
            start: function (event, ui)
            {
                $(ui.helper).addClass("dragging");
            },
            stop: function (event, ui)
            {
                $(ui.item).effect("shake", { times: 1, distance: 5, direction: "up" }, 300);
                $(ui.helper).removeClass("dragging");
            },
            update: function (event, ui)
            {
                var sequenceList = "";

                $("#card-holder").children().each(function () {
                    sequenceList += $(this).data("card-id");
                    sequenceList += "|";
                });

                $.ajax({
                    type: "POST",
                    url: csVars.Url + "cards/sort",
                    data: { sequence: sequenceList },
                    dataType: "json",
                    success: function (response) {},
                    error: function (xhr, ajaxOptions, thrownError)
                    {
                        gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                    }
                });
            }
        });

        gemini_appnav.initCardActions();

        gemini_appnav.callback();

        gemini_appnav.resizer();
        
        if ($("#pin-page").hasClass("selected")) {
            gemini_appnav.showPinnedPageActions();
        } else {
            gemini_appnav.hidePinnedPageActions();
        }

        if (displayPageActions && $('#pin-page').length > 0)
        {
            $("#content-header").draggable(
            {
                cursor: "pointer",
                distance: 30,
                cursorAt: { botom: 5, left: 5 },
                helper: function (event) {
                    return $('<span class="page-ghost-card"/>').text(gemini_appnav.pageCard.Key + " - " + gemini_appnav.pageCard.Title);
                },
                drag: function (event, ui) { }
            });

            $("#header").droppable({
                drop: function (event, ui) {
                    if ($(ui.helper).hasClass("card-small")) return;
                    $("#pin-page").click();
                }
            });
        }
    },

    callback: function ()
    {
        var interval = 10000; // settled on 10 seconds AFTER evaulating SignalR (don't ask!)

        setInterval(function () {
            $.ajax({
                type: "GET",
                url: csVars.Url + 'cards/fetch',
                success: function (response) {
                    if (response.Result == undefined || response.Result == null || response.Result.Data == undefined || response.Result.Data == null) return;
                    var i = 0;
                    for (i = 0; i < response.Result.Data.length; i++) {
                        var id = response.Result.Data[i].Id;
                        var counter = response.Result.Data[i].BadgeCount;
                        if (counter > 0) {
                            var selector = "[data-badge-id='" + id + "']";
                            $(selector).attr("data-counter", counter);
                            $(selector).html(response.Result.Data[i].BadgeCountLabel);
                        }
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                }
            });
        }, interval);
    },

    escapeCardHover: function (guid, selector)
    {
        $('#card-data').fadeOut('fast');
        gemini_keyboard.unbindEscape(selector);
    },
    
    hover: function (card)
    {
        $(card).hoverIntent({ interval: 500,
            over: function () {
                var that = this;
                gemini_keyboard.bindEscape("#card-holder", gemini_appnav.escapeCardHover);
                $(this).find(".card-options-icon").show();

                if ($(card).find(".badge-count").data("counter") == 0) {
                    return;
                }

                $.ajax({
                    type: "GET",
                    url: csVars.Url + 'cards/data/' + $(card).data('card-id'),
                    success: function (response) {
                        if (response.Success) {
                            $('#card-data').html(response.Result.Data);
                            $('#card-data').fadeIn('fast');
                            $('#card-data').position({
                                "of": that,
                                "my": "left top",
                                "at": "left bottom",
                                "offset": "0 -2",
                                "collision": "none"
                            });
                           
                            $('#card-data-clear').click(function () {
                                $.ajax({
                                    type: "POST",
                                    url: csVars.Url + "cards/clearcount",
                                    data: { cardId: $(card).data('card-id') },
                                    dataType: "json",
                                    success: function (response) {
                                        $(that).find('.badge-count').empty();
                                        $(that).find('.badge-count').attr("data-counter", "0");
                                    },
                                    error: function (xhr, ajaxOptions, thrownError) {
                                        //alert('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                                    }
                                });
                            });
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                    }
                });
            },
            out: function () { $(this).find(".card-options-icon").hide(); }
        });
    },

    contextMenu: function (card) {
        $(card).contextMenu({ menu: 'card-context-menu'},
            function (action, el, pos) {
                var title = $(el).find(".card-name");
                var titleText = title.html();
                var titleWidth = title.width();
                var titleHeight = title.height();
                var cardId = $(el).data("card-id");

                // If action rename has been selected an there is no edit button right now
                if (action == "rename" && $(".card-title-edit", el).length == 0) {

                    var control = '<input class="card-title-edit" type="text" style="height:16px; width:85px" value="' + titleText + '"></input>';

                    title.html(control);
                
                    $(".card-title-edit", el).focus().select();

                    gemini_commons.inputKeyHandler("#" + $(el).attr("id") + " .card-title-edit",
                        function () {
                            var newTitle = $(".card-title-edit", el).val();

                            $.ajax({
                                type: "POST",
                                url: csVars.Url + "cards/rename/" + cardId,
                                data: { cardTitle: newTitle },
                                dataType: "json",
                                success: function (response) {
                                    title.html(newTitle);

                                    if (gemini_appnav.pageCard.Id == cardId) {
                                        gemini_appnav.pageCard.Title = newTitle;
                                    }
                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                }
                            });
                        },
                        function () {
                            title.html(titleText);
                        }
                    );
                }

                if (action == "share") {
                    gemini_share.showShare("left top", "left bottom", "0 0", el, cardId, "{}");
                }

                if (action == "subscribe")
                {
                    gemini_share.showSubscribe("left top", "left bottom", "0 0", el, cardId, "{}");
                }

                if (action == "remove") {
                    gemini_appnav.removeCardAnimate(cardId);

                    $.ajax({
                        type: "POST",
                        url: csVars.Url + "cards/delete/" + cardId,
                        data: "{}",
                        dataType: "json",
                        success: function (response) {
                            if (gemini_appnav.pageCard.Id !=0 && gemini_appnav.pageCard.Id == cardId) {
                                $("#pin-page").toggleClass("selected");
                                gemini_appnav.pageCard = response.Result.PageCard;
                            }
                            $("#card-holder").html(response.Result.Data);

                            gemini_appnav.resizer();
                            gemini_appnav.initCardActions();
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            gemini_diag.log('FAILED, Status=' + xhr.status + ' -> ' + thrownError);
                        }
                    });
                }
            },
            function (before) {

            }
        );
    }
};