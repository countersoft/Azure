/* a simple click on the the number style slider 
<div id="your-container-id'>
    <div id="slider">
        <div id="header"><h1>Demo</h1></div>
        <div id="inner">
            <div class='step'> ... the form contents ... </div>
            <div class='step'> ... the form contents ... </div>
            <div class='step'> ... the form contents ... </div>
        </div>
        <ol id="steps"> -- inserted by this script
            <li></li>
        </ol>
    </div>
</div>
*/
(function ($)
{
    $.fn.numberSlider = function (options)
    {
        var defaults = { speed: 500, cssClass: 'step' };
        var options = $.extend(defaults, options);
        
        this.each(function (i)
        {
            var obj = $(this);
            var sel = 'div.step';
            var clickable = true;

            var current = 0;
            var count = $(sel, obj).length;
            var width = $(sel, obj).width();
            var total = count - 1;

            obj.width(width);
            obj.css("overflow", "hidden");

            $("#inner", obj).css('width', count * width);
            $(sel, obj).css('float', 'left');

            // Jump to the initially selcted slide 
            if (options.current != undefined)
                current = options.current;

            // Detect the any selected item that may be already present
            var steps = $(sel, obj);
            steps.each(function (i)
            {
                if ($(this).data('current'))
                {
                    current = i;
                }
            });

            // Need to attach clicks to slider MoveNext
            $('ol li', obj).click(function ()
            {
                if ($(this).hasClass("inactive"))
                    return;
                var link = $(this).find('a');
                var pos = parseInt(link.attr('rel'));
                liteUpCurrent(pos);
                moveToSlide(pos);
            });

            function position()
            {
                return -(current * width);
            };
            function adjust()
            {
                $("#inner", obj).css("margin-left", position());
                liteUpCurrent(current);
                clickable = true;
            };
            function liteUpCurrent(i)
            {
                i = parseInt(i);
                $("li[id^=" + options.cssClass + "]").removeClass("current");
                $("li#" + options.cssClass + "-" + options.info[i].StepId).addClass("current");
            };
            function moveToSlide(next)
            {
                if (clickable && options.info[next].Active)
                {
                    clickable = false;

                    var time = Math.abs(current - next) * options.speed;
                    current = next;

                    $("#inner", obj).animate({ marginLeft: position() }, { queue: false, easing: 'swing', duration: time, complete: adjust });

                    // Is the reset button enabled
                    var hasReset = $($('div.step')[current]).data('reset');
                    if (hasReset)
                    {
                        gemini_ui.enableButton('#run-reset');
                    }
                    else
                    {
                        gemini_ui.disableButton('#run-reset');
                    }
                };
                
            };

            function setState(i, state)
            {
                i = parseInt(i) + 1;
                $("li", "#" + options.cssClass).removeClass("status0 inactive").addClass(state);
            }

            moveToSlide(current);
            liteUpCurrent(current);
        });

        return this;    // allow caller to cache extension
    };

})(jQuery);