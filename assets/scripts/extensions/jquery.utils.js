(function ($, window, undefined)
{
    /*******************************************************/
    /* Enable / disable other control on trigger condition */
    /*******************************************************/
    $.fn.TriggerContol = function (options)
    {
        if (!this.length)
            return;

        if (options.target == '') 
            return;

        $.triggering.change(this, options);

        //* on subsequent change 
        $(this).change(function ()
        {
            $.triggering.change(this, options);
        });

        return this;
    };

    /*******************************/
    /*  Shared triggering function */
    /*******************************/
    $.triggering =
    {
        // internal use only
        change: function (selector, options)
        {
            var itemCount = 0;
            var initVal = $(selector).val();
            var enable = (initVal == options.value) == (options.enable);
            //var hidden = false;
            var count = 0;
            var allValues;

            if (options.value != undefined)
            {
                allValues = options.value.split(";");
                count = allValues.length;

                while (count >= 0)
                {
                    if (initVal == allValues[--count])
                    {
                        enable = options.enable;
                        count = 0;
                    };
                }
            }

            if (options.value == '*' && (initVal.length > 0))
            {
                enable = options.enable;
            }

            if (options.not) enable = !enable;

            if (options.count)
            {
                itemCount = options.count;
            }

            if (enable)
            {
                $(options.target).removeAttr('disabled');
                $(options.label).removeAttr('disabled');
            }
            else
            {
                $(options.target).attr('disabled', 'disabled');
                $(options.label).attr('disabled', 'disabled'); 
            }
        }
    };

})(jQuery, window);
