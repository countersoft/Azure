var gemini_help = {
    initTour: function () {
        $(window).ready(function (e) {

            gemini_help.setView($(".topic:first", "#tour-box"));

            $(".topic", "#tour-box").click(function (e)
            {
                gemini_help.setView($(this));

                $(".topic", "#tour-box").each(function (e) {
                    $(this).removeClass("selected-topic");
                });

                $(this).addClass("selected-topic");
            });

            $(".topic", "#tour-box").first().addClass("selected-topic");
            
            $("#hide-tour-popup").click(function (e)
            {
                if($(this).is(":checked")) {
                    gemini_ajax.postCall("account", "hidetour");
                }
            });
        });
    },
    
    setView: function(item)
    {
        var url = item.data("url");

        if (gemini_commons.isIe7or8())
        {
            url = item.data("url").replace(".html", "IE.html");
        }

        $("iframe", "#tour-box").attr("src", url);
    }
};


