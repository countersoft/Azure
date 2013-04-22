(function ($)
{
    // Register namespace "Gemini" and the functions required
    $.extend(true, window,
    {
        "Gemini":
        {
            "Event": Event,
            "EventData": EventData,
            "EventHandler": EventHandler,
            "Trigger": Trigger
        }
    });

    // An event object for passing data to event handlers and letting them control propagation
    function EventData()
    {
        var isPropagationStopped = false;
        var isImmediatePropagationStopped = false;

        // Stops event from propagating up the DOM tree.
        this.stopPropagation = function ()
        {
            isPropagationStopped = true;
        };

        // Returns whether stopPropagation was called on this event object.
        this.isPropagationStopped = function ()
        {
            return isPropagationStopped;
        };

        // Prevents the rest of the handlers from being executed.
        this.stopImmediatePropagation = function ()
        {
            isImmediatePropagationStopped = true;
        };

        // Returns whether stopImmediatePropagation was called on this event object.
        this.isImmediatePropagationStopped = function ()
        {
            return isImmediatePropagationStopped;
        }
    }

    // A simple publisher-subscriber implementation.
    function Event()
    {
        // keep a list of all 'subscribed' event handelers 
        var handlers = [];

        // Adds an event handler to be called when the event is fired
        this.subscribe = function (fn)
        {
            handlers.push(fn);
        };

        // Removes an event handler added with subscribe
        this.unsubscribe = function (fn)
        {
            for (var i = handlers.length - 1; i >= 0; i--)
            {
                if (handlers[i] === fn)
                {
                    handlers.splice(i, 1);
                }
            }
        };

        /*
          Fires an event notifying all subscribers.
         
          @args     {Object} Additional data object to be passed to all handlers.
          @e        {EventData} Optional.
                   EventData object to be passed to all handlers. For DOM events, an existing W3C/jQuery event object can be passed in.
          @scope    {Object} Optional
                   The scope ("this") within which the handler will be executed.
                   If not specified, the scope will be set to the Event instance. */
        this.notify = function (args, e, scope)
        {
            e = e || new EventData();
            scope = scope || this;

            var returnValue;
            for (var i = 0; i < handlers.length && !(e.isPropagationStopped() || e.isImmediatePropagationStopped()); i++)
            {
                returnValue = handlers[i].call(scope, e, args);
            }

            return returnValue;
        };
    }

    // Event Handler definiton
    function EventHandler()
    {
        var handlers = [];

        // subscribe
        this.subscribe = function (event, handler)
        {
            handlers.push(
            {
                event: event,
                handler: handler
            });
            
            event.subscribe(handler);
        };

        // unsubscribe
        this.unsubscribe = function (event, handler)
        {
            var i = handlers.length;
            while (i--)
            {
                if (handlers[i].event === event && handlers[i].handler === handler)
                {
                    handlers.splice(i, 1);
                    event.unsubscribe(handler);
                    return;
                }
            }
        };

        // unsubscribe all 
        this.unsubscribeAll = function ()
        {
            var i = handlers.length;
            while (i--)
            {
                handlers[i].event.unsubscribe(handlers[i].handler);
            }
            handlers = [];
        }
    }

    // Trigger named event
    function Trigger(evt, args, e)
    {
        e = e || new EventData();
        args = args || {};
        args.caller = self;

        return evt.notify(args, e, self);
    }

})(jQuery);