gemini_import =
{
    init: function(){
        $('#header').on('click', "#menu-import-data", function (e) {
            $("#cs-popup-center-content").css("width", "800px");
            $("#cs-popup-center-content").css("height", "400px");

            gemini_popup.centerPopup("items", "importdatap/popup");
        });
    }
};