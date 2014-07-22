/*
 * Jeditable - jQuery in place edit plugin
 *
 * Copyright (c) 2006-2009 Mika Tuupola, Dylan Verheul
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Project home:
 *   http://www.appelsiini.net/projects/jeditable
 *
 * Based on editable by Dylan Verheul <dylan_at_dyve.net>:
 *    http://www.dyve.net/jquery/?editable
 *
 */

/**
  * Version 1.7.2-dev
  *
  * ** means there is basic unit tests for this parameter. 
  *
  * @name  Jeditable
  * @type  jQuery
  * @param String  target             (POST) URL or function to send edited content to **
  * @param Hash    options            additional options 
  * @param String  options[method]    method to use to send edited content (POST or PUT) **
  * @param Function options[callback] Function to run after submitting edited content **
  * @param String  options[name]      POST parameter name of edited content
  * @param String  options[id]        POST parameter name of edited div id
  * @param Hash    options[submitdata] Extra parameters to send when submitting edited content.
  * @param String  options[type]      text, textarea or select (or any 3rd party input type) **
  * @param Integer options[rows]      number of rows if using textarea ** 
  * @param Integer options[cols]      number of columns if using textarea **
  * @param Mixed   options[height]    'auto', 'none' or height in pixels **
  * @param Mixed   options[width]     'auto', 'none' or width in pixels **
  * @param String  options[loadurl]   URL to fetch input content before editing **
  * @param String  options[loadtype]  Request type for load url. Should be GET or POST.
  * @param String  options[loadtext]  Text to display while loading external content.
  * @param Mixed   options[loaddata]  Extra parameters to pass when fetching content before editing.
  * @param Mixed   options[data]      Or content given as paramameter. String or function.**
  * @param String  options[indicator] indicator html to show when saving
  * @param String  options[tooltip]   optional tooltip text via title attribute **
  * @param String  options[event]     jQuery event such as 'click' of 'dblclick' **
  * @param String  options[submit]    submit button value, empty means no button **
  * @param String  options[cancel]    cancel button value, empty means no button **
  * @param String  options[cssclass]  CSS class to apply to input form. 'inherit' to copy from parent. **
  * @param String  options[style]     Style to apply to input form 'inherit' to copy from parent. **
  * @param String  options[select]    true or false, when true text is highlighted ??
  * @param String  options[placeholder] Placeholder text or html to insert when element is empty. **
  * @param String  options[onblur]    'cancel', 'submit', 'ignore' or function ??
  *             
  * @param Function options[onsubmit] function(settings, original) { ... } called before submit
  * @param Function options[onreset]  function(settings, original) { ... } called before reset
  * @param Function options[onerror]  function(settings, original, xhr) { ... } called on error
  *             
  * @param Hash    options[ajaxoptions]  jQuery Ajax options. See docs.jquery.com.
  *             
  */

(function($) {

    $.fn.editable = function(target, options) {
            
        if ('disable' == target) {
            $(this).data('disabled.editable', true);
            return;
        }
        if ('enable' == target) {
            $(this).data('disabled.editable', false);
            return;
        }
        if ('destroy' == target) {
            $(this)
                .unbind($(this).data('event.editable'))
                .removeData('disabled.editable')
                .removeData('event.editable');
            return;
        }
        
        var settings = $.extend({}, $.fn.editable.defaults, {target:target}, options);
        
        /* setup some functions */
        var plugin   = $.editable.types[settings.type].plugin || function() { };
        var submit   = $.editable.types[settings.type].submit || function() { };
        var buttons  = $.editable.types[settings.type].buttons 
                    || $.editable.types['defaults'].buttons;
        var content  = $.editable.types[settings.type].content 
                    || $.editable.types['defaults'].content;
        var element  = $.editable.types[settings.type].element 
                    || $.editable.types['defaults'].element;
        var reset    = $.editable.types[settings.type].reset 
                    || $.editable.types['defaults'].reset;
        var callback = settings.callback || function() { };
        var onedit   = settings.onedit   || function() { }; 
        var onsubmit = settings.onsubmit || function () { settings.submit = null };
        var onreset = settings.onreset || function () { settings.submit = null };
        var onerror  = settings.onerror  || reset;
          
        /* Show tooltip. */
        if (settings.tooltip) {
            $(this).attr('title', settings.tooltip);
        }
        
        settings.autowidth  = 'auto' == settings.width;
        settings.autoheight = 'auto' == settings.height;
        
        return this.each(function() {
                        
            /* Save this to self because this changes when scope changes. */
            var self = this;  
                   
            /* Inlined block elements lose their width and height after first edit. */
            /* Save them for later use as workaround. */
            var savedwidth  = $(self).width();
            var savedheight = $(self).height();

            /* Save so it can be later used by $.editable('destroy') */
            $(this).data('event.editable', settings.event);
            
            /* If element is empty add something clickable (if requested) */
            if (!$.trim($(this).html())) {
                $(this).html(settings.placeholder);
            }
            
            $(this).bind(settings.event, function(e) {
                
                /* Abort if element is disabled. */
                if (true === $(this).data('disabled.editable')) {
                    return;
                }
                
                /* Prevent throwing an exeption if edit field is clicked again. */
                if (self.editing) {
                    return;
                }
                
                /* Abort if onedit hook returns false. */
                if (false === onedit.apply(this, [settings, self])) {
                   return;
                }
                
                /* Prevent default action and bubbling. */
                e.preventDefault();
                e.stopPropagation();
                
                /* Remove tooltip. */
                if (settings.tooltip) {
                    $(self).removeAttr('title');
                }
                
                /* Figure out how wide and tall we are, saved width and height. */
                /* Workaround for http://dev.jquery.com/ticket/2190 */
                if (0 == $(self).width()) {
                    settings.width  = savedwidth;
                    settings.height = savedheight;
                } else {
                    if (settings.width != 'none') {
                        settings.width = 
                            settings.autowidth ? $(self).width()  : settings.width;
                    }
                    if (settings.height != 'none') {
                        settings.height = 
                            settings.autoheight ? $(self).height() : settings.height;
                    }
                }
                
                /* Remove placeholder text, replace is here because of IE. */
                if ($(this).html().toLowerCase().replace(/(;|"|\/)/g, '') == 
                    settings.placeholder.toLowerCase().replace(/(;|"|\/)/g, '')) {
                        $(this).html('');
                }
                                
                self.editing    = true;
                self.revert     = $(self).html();
                $(self).html('');

                /* Create the form object. */
                var form = $('<form />');
                
                /* Apply css or style or both. */
                if (settings.cssclass) {
                    if ('inherit' == settings.cssclass) {
                        form.attr('class', $(self).attr('class'));
                    } else {
                        form.attr('class', settings.cssclass);
                    }
                }

                if (settings.style) {
                    if ('inherit' == settings.style) {
                        form.attr('style', $(self).attr('style'));
                        /* IE needs the second line or display wont be inherited. */
                        form.css('display', $(self).css('display'));                
                    } else {
                        form.attr('style', settings.style);
                    }
                }

                /* Add main input element to form and store it in input. */
                if(settings.detectType != null) {
                    var type = settings.detectType(this);
                    if(type != null && type != undefined && type != '') 
                    {
                        settings.type = type;
                        plugin   = $.editable.types[settings.type].plugin || function() { };
                        submit   = $.editable.types[settings.type].submit || function() { };
                        buttons  = $.editable.types[settings.type].buttons 
                                    || $.editable.types['defaults'].buttons;
                        content  = $.editable.types[settings.type].content 
                                    || $.editable.types['defaults'].content;
                        element  = $.editable.types[settings.type].element 
                                    || $.editable.types['defaults'].element;
                        reset    = $.editable.types[settings.type].reset 
                                    || $.editable.types['defaults'].reset;
                    }
                    else 
                    {
                        // default to textbox
                        settings.type = 'text';
                        plugin   = $.editable.types[settings.type].plugin || function() { };
                        submit   = $.editable.types[settings.type].submit || function() { };
                        buttons  = $.editable.types[settings.type].buttons 
                                    || $.editable.types['defaults'].buttons;
                        content  = $.editable.types[settings.type].content 
                                    || $.editable.types['defaults'].content;
                        element  = $.editable.types[settings.type].element 
                                    || $.editable.types['defaults'].element;
                        reset    = $.editable.types[settings.type].reset 
                                    || $.editable.types['defaults'].reset;
                    }
                }
                var input = element.apply(form, [settings, self]);
                
                // SAAR
                if(settings.validationRequired != null && settings.validationRequired(this)) {
                    input.addClass('required');
                }

                if(settings.validationEmail != null && settings.validationEmail(this)) {
                    input.addClass('email');
                }

                if (settings.validationProgrammaticalNames != null && settings.validationProgrammaticalNames(this)) {
                    input.addClass('programmaticalnames');
                }
                // END SAAR

                /* Set input content via POST, GET, given data or existing value. */
                var input_content;
                
                if (settings.loadurl) {
                    var t = setTimeout(function() {
                        input.disabled = true;
                        content.apply(form, [settings.loadtext, settings, self]);
                    }, 100);

                    var loaddata = {};
                    loaddata[settings.id] = self.id;
                    if ($.isFunction(settings.loaddata)) {
                        $.extend(loaddata, settings.loaddata.apply(self, [self.revert, settings]));
                    } else {
                        $.extend(loaddata, settings.loaddata);
                    }
                    $.ajax({
                       type : settings.loadtype,
                       url  : settings.loadurl,
                       data : loaddata,
                       async : false,
                       success: function(result) {
                          window.clearTimeout(t);
                          input_content = result;
                          input.disabled = false;
                       }
                    });
                } else if (settings.data) {
                    input_content = settings.data;
                    if ($.isFunction(settings.data)) {
                        input_content = settings.data.apply(self, [self.revert, settings]);
                    }
                } else {
                    input_content = self.revert; 
                }
                content.apply(form, [input_content, settings, self]);

                input.attr('name', settings.name);
        
                /* Add buttons to the form. */
                buttons.apply(form, [settings, self]);
         
                /* Add created form to self. */
                $(self).append(form);
         
                /* Attach 3rd party plugin if requested. */
                plugin.apply(form, [settings, self]);

                // SAAR
                form.validate({ignoreTitle: true});
                // END SAAR

                /* Focus to first visible form element. */
                $(':input:visible:enabled:first', form).focus();

                /* Highlight input contents when requested. */
                if (settings.select) {
                    input.select();
                }
        
                /* discard changes if pressing esc */
                input.keydown(function(e) {
                    if (e.keyCode == 27) {
                        e.preventDefault();
                        reset.apply(form, [settings, self]);
                    }
                });

                /* Discard, submit or nothing with changes when clicking outside. */
                /* Do nothing is usable when navigating with tab. */
                var t;
                if ('cancel' == settings.onblur) {
                    input.blur(function(e) {
                        /* Prevent canceling if submit was clicked. */
                        t = setTimeout(function() {
                            reset.apply(form, [settings, self]);
                        }, 500);
                    });
                }
                if ('ignore' == settings.onblur) {
                    input.blur(function (e) {
                        /* Prevent canceling if submit was clicked. */
                        $(this).find('input').datepicker({
                            onSelect: function (dateText) { $(this).hide(); $(form).trigger('submit'); },
                            onClose: function (setTimeout) { reset.apply(form, [settings, self]); }
                        });
                    });
                }else if ('submit' == settings.onblur) {
                    input.blur(function(e) {
                        /* Prevent double submit if submit was clicked. */
                        t = setTimeout(function() {
                            form.submit();
                        }, 200);
                    });
                } else if ($.isFunction(settings.onblur)) {
                    input.blur(function(e) {
                        settings.onblur.apply(self, [input.val(), settings]);
                    });
                } else {
                    input.blur(function(e) {
                      /* TODO: maybe something here */
                    });
                }

                form.submit(function(e) {

                    if (t) { 
                        clearTimeout(t);
                    }

                    /* Do no submit. */
                    e.preventDefault(); 

                    // SAAR
                    if(!$(form).valid()) return false;
                    // END SAAR
            
                    /* Call before submit hook. */
                    /* If it returns false abort submitting. */                    
                    if (false !== onsubmit.apply(form, [settings, self])) { 
                        /* Custom inputs call before submit hook. */
                        /* If it returns false abort submitting. */
                        if (false !== submit.apply(form, [settings, self])) { 

                          /* Check if given target is function */
                          if ($.isFunction(settings.target)) {
                              var str = settings.target.apply(self, [input.val(), settings]);
                              $(self).html(str);
                              self.editing = false;
                              callback.apply(self, [self.innerHTML, settings]);
                              /* TODO: this is not dry */                              
                              if (!$.trim($(self).html())) {
                                  $(self).html(settings.placeholder);
                              }
                          } else {
                              /* Add edited content and id of edited element to POST. */
                              var submitdata = {};
                              submitdata[settings.name] = input.val();
                              submitdata[settings.id] = self.id;
                              /* Add extra data to be POST:ed. */
                              if ($.isFunction(settings.submitdata)) {
                                  $.extend(submitdata, settings.submitdata.apply(self, [self.revert, settings]));
                              } else {
                                  $.extend(submitdata, settings.submitdata);
                              }

                              /* Quick and dirty PUT support. */
                              if ('PUT' == settings.method) {
                                  submitdata['_method'] = 'put';
                              }

                              /* Show the saving indicator. */
                              $(self).html(settings.indicator);
                              
                              /* Defaults for ajaxoptions. */
                              var ajaxoptions = {
                                  type    : 'POST',
                                  data    : submitdata,
                                  dataType: 'html',
                                  url     : settings.target,
                                  success : function(result, status) {
                                      if (ajaxoptions.dataType == 'html') {
                                        $(self).html(result);
                                      }
                                      self.editing = false;
                                      callback.apply(self, [result, settings]);
                                      if (!$.trim($(self).html())) {
                                          $(self).html(settings.placeholder);
                                      }
                                      // SAAR
                                      if(settings.type == 'color') $(self).click();
                                      // END SAAR
                                  },
                                  error   : function(xhr, status, error) {
                                      onerror.apply(form, [settings, self, xhr]);
                                  }
                              };
                              
                              /* Override with what is given in settings.ajaxoptions. */
                              $.extend(ajaxoptions, settings.ajaxoptions);   
                              $.ajax(ajaxoptions);          
                              
                            }
                        }
                    }
                    
                    /* Show tooltip again. */
                    $(self).attr('title', settings.tooltip);
                    
                    return false;
                });
            });
            
            /* Privileged methods */
            this.reset = function(form) {
                /* Prevent calling reset twice when blurring. */
                if (this.editing) {
                    /* Before reset hook, if it returns false abort reseting. */
                    if (false !== onreset.apply(form, [settings, self])) { 
                        $(self).html(self.revert);
                        self.editing   = false;
                        if (!$.trim($(self).html())) {
                            $(self).html(settings.placeholder);
                        }
                        /* Show tooltip again. */
                        if (settings.tooltip) {
                            $(self).attr('title', settings.tooltip);                
                        }
                    }                    
                }
            };            
        });

    };


    $.editable = {
        types: {
            defaults: {
                element : function(settings, original) {
                    var input = $('<input type="hidden"></input>');                
                    $(this).append(input);
                    return(input);
                },
                content : function(string, settings, original) {
                    $(':input:first', this).val(string);
                },
                reset : function(settings, original) {
                  original.reset(this);
                },
                buttons : function(settings, original) {
                    var form = this;
                    if (settings.submit) {
                        /* If given html string use that. */
                        if (settings.submit.match(/>$/)) {
                            var submit = $(settings.submit).click(function() {
                                if (submit.attr("type") != "submit") {
                                    form.submit();
                                }
                            });
                        /* Otherwise use button with given string as text. */
                        } else {
                            var submit = $('<button type="submit" />');
                            submit.html(settings.submit);                            
                        }
                        $(this).append(submit);
                    }
                    if (settings.cancel) {
                        /* If given html string use that. */
                        if (settings.cancel.match(/>$/)) {
                            var cancel = $(settings.cancel);
                        /* otherwise use button with given string as text */
                        } else {
                            var cancel = $('<button type="cancel" />');
                            cancel.html(settings.cancel);
                        }
                        $(this).append(cancel);

                        $(cancel).click(function(event) {
                            if ($.isFunction($.editable.types[settings.type].reset)) {
                                var reset = $.editable.types[settings.type].reset;                                                                
                            } else {
                                var reset = $.editable.types['defaults'].reset;                                
                            }
                            reset.apply(form, [settings, original]);
                            return false;
                        });
                    }
                }
            },
            text: {
                element : function(settings, original) {
                    var input = $('<input style="width:99%;"/>');
                    
                    if (settings.width  != 'none') { input.attr('width', settings.width);  }
                    if (settings.height != 'none') { input.attr('height', settings.height ); }
                    
                    /* https://bugzilla.mozilla.org/show_bug.cgi?id=236791 */
                    //input[0].setAttribute('autocomplete','off');
                    input.attr('autocomplete','off');
                    $(this).append(input);
                    return(input);
                }
            },
            masktext: {
                element: function (settings, original) {
                    var input = $('<input style="width:99%;"/>');

                    if (settings.width != 'none') { input.attr('width', settings.width); }
                    if (settings.height != 'none') { input.attr('height', settings.height); }

                    /* https://bugzilla.mozilla.org/show_bug.cgi?id=236791 */
                    //input[0].setAttribute('autocomplete','off');
                    input.attr('autocomplete', 'off');
                    $(this).append(input);
                    input.mask('99:99');
                    return (input);
                }
            },
            masktext32: {
                element: function (settings, original) {
                    var input = $('<input style="width:99%;"/>');

                    if (settings.width != 'none') { input.attr('width', settings.width); }
                    if (settings.height != 'none') { input.attr('height', settings.height); }

                    /* https://bugzilla.mozilla.org/show_bug.cgi?id=236791 */
                    //input[0].setAttribute('autocomplete','off');
                    input.attr('autocomplete', 'off');
                    $(this).append(input);
                    input.mask('999:99');
                    return (input);
                }
            },
            textarea: {
                element : function(settings, original) {
                    var textarea = $('<textarea />');
                    if (settings.rows) {
                        textarea.attr('rows', settings.rows);
                    } else if (settings.height != "none") {
                        textarea.height(settings.height);
                    }
                    if (settings.cols) {
                        textarea.attr('cols', settings.cols);
                    } else if (settings.width != "none") {
                        textarea.width(settings.width);
                    }
                    $(this).append(textarea);

                    settings.submit = "<button type='submit' class='button-primary'>OK</button>";
                    return(textarea);
                }
            },
            select: {
               element : function(settings, original) {
                    var select = $('<select />');
                    $(this).append(select);
                    return(select);
                },
                content : function(data, settings, original) {
                    /* If it is string assume it is json. */
                    if (String == data.constructor) {      
                        eval ('var u = ' + data);
                    } else {
                    /* Otherwise assume it is a hash already. */
                        var u = data;
                    }
                    for (var key in u) {
                        if (!u.hasOwnProperty(key)) {
                            continue;
                        }
                        if ('selected' == key) {
                            continue;
                        } 
                        var option = $('<option />').val(key).append(u[key]);
                        $('select', this).append(option);    
                    }                    
                    /* Loop option again to set selected. IE needed this... */ 
                    $('select', this).children().each(function() {
                        if ($(this).val() == u['selected'] || 
                            $(this).text() == $.trim(original.revert)) {
                                $(this).prop('selected', 'selected');
                        }
                    });
                    /* Submit on change if no submit button defined. */
                    if (!settings.submit) {
                        var form = this;
                        $('select', this).change(function() {
                            form.submit();
                        });
                    }
                }
            },
            /*
            chosen: {
                element: function (settings, original) {
                    var select = $('<select />');
                    $(this).append(select);
                    
                    return (select);
                },
                plugin:  function(settings, original) {        
                    $('select', this).chosen({ stay_open: true, topmost_container: null, fix_popup: false });
                    $('select > div', this).blur(function () { alert(1); });
                },
                content: function (data, settings, original) {
                    // If it is string assume it is json. 
                    if (String == data.constructor) {
                        eval('var json = ' + data);
                    } else {
                        // Otherwise assume it is a hash already. 
                        var json = data;
                    }
                    for (var key in json) {
                        if (!json.hasOwnProperty(key)) {
                            continue;
                        }
                        if ('selected' == key) {
                            continue;
                        }
                        var option = $('<option />').val(key).append(json[key]);
                        $('select', this).append(option);
                    }
                    // Loop option again to set selected. IE needed this... 
                    $('select', this).children().each(function () {
                        if ($(this).val() == json['selected'] ||
                            $(this).text() == $.trim(original.revert)) {
                            $(this).attr('selected', 'selected');
                        }
                    });
                    // Submit on change if no submit button defined. 
                    if (!settings.submit) {
                        var form = this;
                        $('select', this).change(function () {
                            form.submit();
                        });
                    }
                }
            },*/
            checkbox: {
                element: function(data, settings, original) {
                    var input = $("<input type='checkbox' />");
                    $(this).append(input);
                    return(input);
                },
                content: function(data, settings, original) {
                    if(data == 'true' || data == 'True') {
                        $('input[type="checkbox"]', this).prop('checked','checked');
                    }
                    
                    /* Submit on change if no submit button defined. */
                    if (!settings.submit) {
                        var form = this;
                        $('input[type="checkbox"]', this).change(function() {
                            if($(this).is(':checked')) {
                                $(this).val('true');
                            }
                            else {
                                $(this).val('false');
                            }
                            form.submit();
                        });
                    }
                }
            },
            date: {
                element: function (data, settings, orginal) {
                    settings.onblur = "ignore";
                    var input = $("<input id='inline-datepicker' type='text' class='datepicker'/>");
                    $(this).append(input);
                    return (input);
                },
                content: function (data, settings, original) {
                    var format = '';
                    settings.onblur = 'nothing';
                    if (settings.dateFormat != null) {
                        format = settings.dateFormat(original);
                        $(this.find("#inline-datepicker")).attr('data-date-format', format);
                        $(this.find("#inline-datepicker")).addClass('dateFormatted');
                    }

                    settings.type = "date";
                    $("#inline-datepicker", this).val(data);
                    $("#inline-datepicker", this).prop("value", data);
                    var form = this;
                    gemini_ui.datePicker(form.find("#inline-datepicker"), function () {
                        form.submit();
                        settings.onblur = 'cancel';
                    }, function () {
                        settings.onblur = 'cancel';
                        original.reset(form);
                    });
                    setTimeout(function() { form.find("#inline-datepicker").DatePickerShow()}, 250);
                }
            }
            ,
            color: {
                element: function (data, settings, original) {
                    var theData=data;
                    var input = $('<input type="hidden"/><div id="colorSelector"><div style="background-color: #ffffff"></div></div>');
                    $(this).append(input);
                    var _this = this;
                    $('#colorSelector', this).ColorPicker({
                    onChange: function (hsb, hex, rgb) {
                            $('#colorSelector div', _this).css('backgroundColor', '#' + hex);
                            $('#ColorCode', _this).val('#' + hex);
                        },
                    onSubmit: function (hsb, hex, rgb, el) {
                        theData.type = 'color';
		                $(el).val(hex);
		                $(el).ColorPickerHide();
                        $('input[type="hidden"]', _this).val('#'+hex);
                        $('input[type="hidden"]', _this).change();

	                }
                    });
                    
                    return(input);
                },
                content: function (data, settings, original) {
                    settings.type = 'color';
                    $('#colorSelector', this).ColorPickerSetColor(data);
                    $('#colorSelector div', this).css('backgroundColor', data);
                    var form = this;
                    $('input[type="hidden"]', this).change(function() {
                        form.submit();
                    });
                }
            }
        },

        /* Add new input type */
        addInputType: function(name, input) {
            $.editable.types[name] = input;
        }
    };

    /* Publicly accessible defaults. */
    $.fn.editable.defaults = {
        name       : 'value',
        id         : 'id',
        type       : 'text',
        width      : 'auto',
        height     : 'auto',
        event      : 'click.editable',
        onblur     : 'cancel',
        loadtype   : 'GET',
        loadtext   : 'Loading...',
        placeholder: 'Click to edit',
        loaddata   : {},
        submitdata : {},
        ajaxoptions: {},
        detectType: null,
        dateFormat: null,
        validationRequired: null,
        validationEmail: null,
        validationProgrammaticalNames: null,
    };

})(jQuery);

