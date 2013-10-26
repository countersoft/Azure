gemini_pdf = {
    init: function () {
        $("#pdf-action").click(function (e) {

            var url = $(this).data("pdf");

            if (url.length > 0) {
                window.open(url);
            }
        });
    }
};


