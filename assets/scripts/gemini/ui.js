var gemini_ui = {

    showPopOut: function (element) {
        if ($(element).is(":visible")) {
            $(element).fadeOut('fast');
        }
        else {
            $(element).slideDown('fast');
            $(element + " :input:visible:enabled:first").focus();
            $(document).keyup(function (e) {
                if (e.keyCode == 27) { $(element).fadeOut('fast'); }   // esc
            });
        }
    },

    cursorWait: function()
    {
        $("body").css('cursor', 'wait');
    },

    cursorDefault: function()
    {
        $("body").css('cursor', 'default');
    },
    
    visualProgressStart: function (selector)
    {
        $(selector).css('opacity', '0.6');
    },
    visualProgressFinish: function (selector)
    {
        $(selector).css('opacity', '1');
    },

    getSpinner: function (id) {
        if (gemini_commons.isEmpty(id)) id = gemini_commons.guidGenerator();

        return {
            Markup: "<div id='spinner-" + id + "' style='margin-bottom:7px;height:30px;'>&nbsp;</div>",
            JS: "$('#spinner-" + id + "').spin(gemini_ui.spinnerOptions);"
        };
    },

    getSpinnerSmall: function (id) {
        if (gemini_commons.isEmpty(id)) id = gemini_commons.guidGenerator();

        return {
            Markup: "<div id='spinner-" + id + "' style='margin-bottom:4px;height:10px;width:20px;'>&nbsp;</div>",
            JS: "$('#spinner-" + id + "').spin(gemini_ui.spinnerOptionsSmall);"
        };
    },

    getSpinnerProgress: function (id) {
        if (gemini_commons.isEmpty(id)) id = gemini_commons.guidGenerator();

        return {
            Markup: "<div id='spinner-" + id + "' style='margin-bottom:4px;height:10px;width:20px;'>&nbsp;</div>",
            JS: "$('#spinner-" + id + "').spin(gemini_ui.spinnerProgressOptions);"
        };
    },
    
    // Black progress spinner
    getSpinnerProgress2: function (id) {
        if (gemini_commons.isEmpty(id)) id = gemini_commons.guidGenerator();

        return {
            Markup: "<div id='spinner-" + id + "' style='margin-bottom:4px;height:10px;width:20px;'>&nbsp;</div>",
            JS: "$('#spinner-" + id + "').spin(gemini_ui.spinnerProgress2Options);"
        };
    },

    spinnerOptions: {
        lines: 6, // The number of lines to draw
        length: 0, // The length of each line
        width: 7, // The line thickness
        radius: 6, // The radius of the inner circle
        color: '#000', // #rgb or #rrggbb
        speed: 1.3, // Rounds per second
        trail: 60, // Afterglow percentage
        shadow: false // Whether to render a shadow
    },

    spinnerOptionsSmall: {
        lines: 6, // The number of lines to draw
        length: 0, // The length of each line
        width: 4, // The line thickness
        radius: 4, // The radius of the inner circle
        color: '#000', // #rgb or #rrggbb
        speed: 1.3, // Rounds per second
        trail: 60, // Afterglow percentage
        shadow: false // Whether to render a shadow
    },

    // White progress spinner -- used on all BUTTONS
    spinnerProgressOptions: {
        lines: 17, // The number of lines to draw
        length: 1, // The length of each line
        width: 3, // The line thickness
        radius: 7, // The radius of the inner circle
        corners: 0,
        rotate: 47,
        color: '#fff', // #rgb or #rrggbb
        speed: 1.2, // Rounds per second
        trail: 53, // Afterglow percentage
        shadow: false // Whether to render a shadow
    },
    
    // Black progress spinner
    spinnerProgress2Options: {
        lines: 10, // The number of lines to draw
        length: 1, // The length of each line
        width: 3, // The line thickness
        radius: 7, // The radius of the inner circle
        corners: 0,
        rotate: 47,
        color: '#000', // #rgb or #rrggbb
        speed: 1.2, // Rounds per second
        trail: 10, // Afterglow percentage
        shadow: false // Whether to render a shadow
    },

    tinyCounter: function (selector, x, y, size, background, color, count) {
        // Inject a canvas into the container
        var container = $(selector);

        // move the canvas to x, y ???
        var card = $("<canvas />")
            .appendTo(container)
            .css({ position: "absolute", top: y + "px", left: x + "px" })
            .get(0);

        // make the canvas the right size
        card.width = size; card.height = size;

        var middle = size / 2;
        var ctx = card.getContext("2d");
        ctx.width = size;
        ctx.height = size;
        ctx.save();

        ctx.fillStyle = background;
        ctx.beginPath();
        ctx.rect(0, 0, size, size);
        ctx.closePath();
        ctx.fill();

        var txt = "" + count;
        ctx.fillStyle = color;

        ctx.beginPath();
        ctx.font = "8pt Calibri";
        ctx.textAlign = "center";
        ctx.textBaseline = "middle";
        ctx.fillText(txt, middle, middle);
        ctx.closePath();
        ctx.fill();
    },

    tinyPercent: function (selector, value, color, text, speed, offx, offy, limit) {
        var elem = $(selector).get(0);
        var paper = Raphael(elem);

        paper.customAttributes.arc = function (value, thickness, ox, oy, limit) {
            // make sure the arc fits into the space provided by the parent element
            var diameter = this.paper.width > this.paper.height ? this.paper.height : this.paper.width;

            if (diameter > limit)
                diameter = limit;

            var radius = (diameter - thickness) / 2;

            var offx = ox + Math.floor(this.paper.width / 2);
            var offy = oy + Math.floor(this.paper.height / 2) - radius; // The middle of the stroke path

            var alpha = 360 / 100 * value;
            var a = (90 - alpha) * Math.PI / 180;

            var x = radius * Math.cos(a);
            var y = radius * Math.sin(a);
            var path = [["M", offx, offy], ["a", radius, radius, 0, +(alpha > 180), 1, x - 0.0001, radius - y]];

            return { path: path };
        };

        offx = offx || 0; offy = offy || 0;

        var diameter = paper.width > paper.height ? paper.height : paper.width;
        limit = limit || diameter;

        if (diameter > limit)
            diameter = limit;

        var thickness = diameter * 0.15;
        var radius = (diameter - thickness) / 2;

        //var rgbColor = Raphael.color(color);
        var param = { stroke: Raphael.color(color), "stroke-width": thickness };

        // Make it all happen in one go
        var path = paper.path().attr(param).attr({ arc: [0, thickness, offx, offy, limit] });
        path.animate({ arc: [value, thickness, offx, offy, limit] }, speed, ">");

        tx = (paper.width / 2) + offx;
        ty = (paper.height / 2) + offy;

        var txtAttr = { font: "" + (radius - thickness) + "px Helvetica", opacity: 0.75 };
        paper.text(tx, ty, Math.floor(value)).attr(txtAttr).attr({ fill: text });
    },

    datePicker: function (selector, onChange, onHide) {

        if (onHide == null || onHide == undefined) {
            onHide = function () { return true; };
        }
        $(selector).each(function () {

            var format = $(this).data('date-format');
            if (format == undefined) format = 'm/d/Y';
            var value = $(this).prop('value');
            if (value == undefined) value = '';
            var elem = this;

            $(elem).DatePicker({
                format: format,
                setDate: new Date(),
                date: value,
                current: value,
                starts: csVars.FirstDayOfWeek,
                flat: false,
                position: 'right',
                onBeforeShow: function () {
                    var value = $(this).prop('value');
                    if (value == undefined) value = '';
                    $(elem).DatePickerSetDate(value, true);
                    $('.datepicker').addClass('z-index-max');
                },
                onChange: function (formated, dates) {
                    $(elem).val(formated);
                    $(elem).DatePickerHide();
                    if (onChange)
                        onChange(formated);
                },
                onHide: onHide
            });

        });
    },

    expanders: function (container) {
        $(container).on("click", "div.section-header > div:first-child > div:first-child", function (e) {
            gemini_ui.expandCollapse($(this));
        });
    },

    expandCollapse: function () {
        var count = arguments.length;
        for (var i = 0; i < count; i++) {
            elem = $(arguments[i]).parent();
            // toggle the icon on top of the section
            var arrow = $("span.expander", elem);
            arrow.toggleClass("fonticon-arrow-right").toggleClass("fonticon-arrow-down");

            // toggle the icon on top of the section
            var content = $("> div.section-content", elem.parent());
            content.toggleClass("expanded").toggleClass("collapsed");
        }
        return false;
    },

    expand: function () {
        var count = arguments.length;
        for (var i = 0; i < count; i++) {
            elem = $(arguments[i]).parent();
            // toggle the icon on top of the section
            var arrow = $("span.expander", elem);
            arrow.removeClass("fonticon-arrow-right").addClass("fonticon-arrow-down");

            // toggle the icon on top of the section
            var content = $("> div.section-content", elem.parent());
            content.removeClass("collapsed").addClass("expanded");
        }
        return false;
    },

    collapse: function () {
        var count = arguments.length;
        for (var i = 0; i < count; i++) {
            elem = $(arguments[i]).parent();

            // toggle the icon on top of the section
            var arrow = $("span.expander", elem);
            arrow.removeClass("fonticon-arrow-down").addClass("fonticon-arrow-right");

            // toggle the icon on top of the section
            var content = $("> div.section-content", elem.parent());
            content.removeClass("expanded").addClass("collapsed");
        }
        return false;
    },

    collapseStarting: function () {
        var count = arguments.length;
        for (var i = 0; i < count; i++) {
            matching = $('[id^="' + arguments[i] + '"]');
            matching.each(function () {
                var elem = $(this).parent();

                // toggle the icon on top of the section
                var arrow = $("span.expander", elem);
                arrow.removeClass("fonticon-arrow-down").addClass("fonticon-arrow-right");

                // toggle the icon on top of the section
                var content = $("> div.section-content", elem.parent());
                content.removeClass("expanded").addClass("collapsed");
            });
        }
        return false;
    },
    htmlEditor: function (selector, onInit, onChange) {
        //$(selector).tinymce('remove');
        //return;
        $(selector).tinymce({
            // Location of TinyMCE script
            script_url: csVars.AssetsPath + 'scripts/tiny_mce/tiny_mce.js',
            // General options
            theme: "advanced",
            //skin: "cirkuit",
            //skin: "o2k7",
            //skin_variant : "silver",
            plugins: "pdw,autolink,lists,pagebreak,style,layer,table,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist",
            height:'325',
            // Theme options
            theme_advanced_buttons1: "pdw_toggle,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
            theme_advanced_buttons2: "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,|,insertdate,inserttime,preview,|,forecolor,backcolor", // Removed: help,code
            theme_advanced_buttons3: "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
            theme_advanced_buttons4: "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
            theme_advanced_toolbar_location: "top",
            theme_advanced_toolbar_align: "left",
            theme_advanced_statusbar_location: "bottom",
            theme_advanced_resizing: false,
            theme_advanced_path : false,
            oninit: onInit,
            onchange_callback: onChange,
            // Example content CSS (should be your site CSS)
            content_css: csVars.AssetsPath + "scripts/tiny_mce/themes/advanced/skins/default/content.css",

            // Kitchen sink
            pdw_toggle_on: 1,
            pdw_toggle_toolbars: "2,3,4",
            // Drop lists for link/image/media/template dialogs
            template_external_list_url: "lists/template_list.js",
            external_link_list_url: "lists/link_list.js",
            external_image_list_url: "lists/image_list.js",
            media_external_list_url: "lists/media_list.js"
        });
    },
    destroyHtmlEditor: function (selector) {
        //$(selector).tinymce('remove');
        //        tinyMCE.execCommand('mceToggleEditor', '#Description'
        
        $(selector).each(function(){
            tinyMCE.execCommand('mceRemoveControl', false, $(this).attr('id'));
        });
        /*for (var i = 0; i < tinymce.editors.length; i++)
        {
            try
            {
                tinyMCE.execCommand('mceRemoveControl', false, tinymce.editors[i].id);
            }
            catch (err) {
                var x = 0;
            }
        };
        return;*/
    },


    chosen: function (selector, topmostContainer, fix_popup) {
        if (fix_popup == null || fix_popup == undefined) fix_popup = false;
        $(selector).chosen({ stay_open: true, topmost_container: topmostContainer, fix_popup: fix_popup });
    },
    setDropdownValue: function (selector, val) {
        $(selector).val(val).trigger("liszt:updated");
    },
    destroyJScrollPane: function (element) {
        var api = $(element).data('jsp');
        if (api != undefined) {
            api.destroy();
        }
    },
    
    getTableTHForTD: function (td) {
        var jTD = $(td);
        return jTD.closest('table').find('th').eq(jTD.index());
    },
    
    triggerChecked: function (selector, enabledControls, disabledControls)
    {
        $(selector).click(function (e) {

            if ($(selector).is(":checked")) {
                if (enabledControls.length) {
                    $(enabledControls).removeAttr('disabled');
                }
            }
            else {
                if (disabledControls.length) {
                    $(disabledControls).attr('disabled', 'disabled');
                }
            }
        });        
    },
    
    disableButton: function (controls) {
        $(controls).attr('disabled', 'disabled');
        $(controls).attr('disabled', true);
        $(controls).addClass("button-disabled").removeClass("button-primary");
    },

    enableButton: function (controls) {
        $(controls).removeAttr('disabled');
        $(controls).attr('disabled', false);
        $(controls).addClass("button-primary").removeClass("button-disabled");
    },

    togglePageOverlay: function(selector)
    {
        $(selector).toggleClass("page-overlay");
    },
    
    flashContent: function (selector) {
        $(selector).removeClass("cs-flash-remove");
        $(selector).addClass("cs-flash");

        setTimeout(function () {
            $(selector).removeClass("cs-flash");
            $(selector).addClass("cs-flash-remove");
        }, 3000);
    },
    
    toggleCheckbox: function (trigger, checkbox, onCheckedCallback, onUncheckedCallback)
    {
        $(trigger).click(function (e) {

            if ($(this).is(":checked")) {
                $(checkbox).each(function () {
                    $(this).attr("checked", "checked");

                    if (onCheckedCallback) onCheckedCallback(this);
                });
            }
            else {
                $(checkbox).each(function () {
                    $(this).removeAttr("checked");

                    if (onUncheckedCallback) onUncheckedCallback(this);
                });
            }
        });        
    },
    inlineEdit: function (selector, getUrl, saveUrl) {
        
        $(selector).editable(csVars.Url + saveUrl, {
            placeholder: '',
            dateFormat: function (elem) {
                var th = gemini_ui.getTableTHForTD(elem);
                return $(th).attr('data-date-format');
            },
            detectType: function (elem) {
                var th = gemini_ui.getTableTHForTD(elem);
                return $(th).data('edit-type');
            },
            validationRequired: function (elm) {
                var th = gemini_ui.getTableTHForTD(elm);
                return $(th).data('required');
            },
            validationEmail: function (elm) {
                var th = gemini_ui.getTableTHForTD(elm);
                return $(th).data('email');
            },
            loadurl: csVars.Url + getUrl,
            loaddata: function () {
                var th = gemini_ui.getTableTHForTD(this);
                var field = $(th).data('field');
                return {
                    id: $(this).parent().data('id'),
                    property: field
                };
            },
            submitdata: function () {
                var th = gemini_ui.getTableTHForTD(this);
                var field = $(th).data('field');
                return {
                    id: $(this).parent().data('id'),
                    property: field
                };
            },
            /*"callback": function (sValue, y) {
            /// Redraw the table from the new data on the server
            //oTable.fnDraw();
            },*/
            "height": "14px"
        });

    },
    startBusy: function(buttonSelector)
    {        
        $(buttonSelector).attr('disabled', 'disabled');
        var spinner = gemini_ui.getSpinnerProgress();
       
        $("#progress-indicator").html(spinner.Markup);

        var buttonWidth = $(buttonSelector).outerWidth();

        $(buttonSelector).attr("data-progress", $(buttonSelector).val());
        $(buttonSelector).css('width', buttonWidth).val(' ');

        $("#progress-indicator").css('width', buttonWidth).css('z-index', 2147483640);
        $("#progress-indicator > div").css('margin', '0 auto');
        $("#progress-indicator").removeClass('hide');
        $('#progress-indicator').position({
            "of": $(buttonSelector),
            "my": "center center",
            "at": "center center",       
            "offset": "0 0",
            "collision": "none"
        });
        eval(spinner.JS);
    },
    stopBusy: function (buttonSelector)
    {
        $("#progress-indicator").addClass('hide');
        $("#progress-indicator").css('top',-200).css('left',-200);
        $(buttonSelector).val($(buttonSelector).attr("data-progress"));    
        $(buttonSelector).removeAttr('disabled');
    },
    startBusy2: function(buttonSelector, progressContainer)
    {        
        $(buttonSelector).attr('disabled', 'disabled');
        var spinner = gemini_ui.getSpinnerProgress2();
       
        $(progressContainer).html(spinner.Markup);

        var buttonWidth = $(buttonSelector).outerWidth();

        $(buttonSelector).attr("data-progress", $(buttonSelector).val());
        $(buttonSelector).css('width', buttonWidth).val(' ');

        $("#progress-indicator").css('width', buttonWidth).css('z-index', 2147483640);
        $("#progress-indicator > div").css('margin', '0 auto');
        $("#progress-indicator").removeClass('hide');
        $('#progress-indicator').position({
            "of": $(buttonSelector),
            "my": "center center",
            "at": "center center",       
            "offset": "0 0",
            "collision": "none"
        });
        eval(spinner.JS);
    },
stopBusy2: function (buttonSelector)
{
    $("#progress-indicator").addClass('hide');
    $("#progress-indicator").css('top',-200).css('left',-200);
    $(buttonSelector).val($(buttonSelector).attr("data-progress"));    
    $(buttonSelector).removeAttr('disabled');
},

    userAutocomplete: function (selector) {
        $(selector).autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: csVars.Url + csVars.ProjectUrl + "account/getusersdropdown",
                    dataType: "json",
                    data: { term: request.term, returnValue: "FullnameRUsername" },
                    success: function (data) {
                        var rows = new Array();
                        for (var i = 0; i < data.Result.Data.length; i++) {
                            rows[rows.length] = { label: data.Result.Data[i].label, value: data.Result.Data[i].value };
                        }
                        response(rows);
                    }
                });
            },
            minLength: 2,
            width: 200,
            dataType: "json",
            matchContains: "word",
            autoFill: false,
            select: function (e, data) {
                $(this).val(data.item.value);
                return false;
            },
            focus: function (event, ui) {
                this.value = ui.item.label;
                event.preventDefault(); // Prevent the default focus behavior.
            }

        });
    }
};

