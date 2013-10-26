gemini_signalr = {

    init: function () {

        setTimeout(function() {
            var geminiHub = $.connection.geminiHub;

            geminiHub.addMessage = function (value) {
                gemini_diag.log(value);
            };

            geminiHub.appnav = function (value) {
                gemini_diag.log(value);
            };

            $.connection.hub.start();
        }, 5000);
        
       $('#search').click(function() {
           
       
            //geminiHub.sendAppNavBadgeCounts('xxx');
        });
    }

};

