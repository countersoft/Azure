/*
 * jQuery UI Nested Sortable
 * v 1.3.4 / 28 apr 2011
 * http://mjsarfatti.com/sandbox/nestedSortable
 *
 * Depends:
 *	 jquery.ui.sortable.js 1.8+
 *
 * License CC BY-SA 3.0
 * Copyright 2010-2011, Manuele J Sarfatti
 */

(function ($) {

    $.widget("ui.nestedSortable", $.extend({}, $.ui.sortable.prototype, {

        options: {
            tabSize: 20,
            disableNesting: 'ui-nestedSortable-no-nesting',
            errorClass: 'ui-nestedSortable-error',
            listType: 'ol',
            maxLevels: 10,
            noJumpFix: 0
        },

        _create: function () {
            if (this.noJumpFix == false)
                this.element.height(this.element.height());
            this.element.data('sortable', this.element.data('nestedSortable'));
            return $.ui.sortable.prototype._create.apply(this, arguments);
        },

        _mouseDrag: function (event) {

            //Compute the helpers position
            this.position = this._generatePosition(event);
            this.positionAbs = this._convertPositionTo("absolute");

            if (!this.lastPositionAbs) {
                this.lastPositionAbs = this.positionAbs;
            }

            //Do scrolling
            if (this.options.scroll) {
                var o = this.options, scrolled = false;
                if (this.scrollParent[0] != document && this.scrollParent[0].tagName != 'HTML') {

                    if ((this.overflowOffset.top + this.scrollParent[0].offsetHeight) - event.pageY < o.scrollSensitivity)
                        this.scrollParent[0].scrollTop = scrolled = this.scrollParent[0].scrollTop + o.scrollSpeed;
                    else if (event.pageY - this.overflowOffset.top < o.scrollSensitivity)
                        this.scrollParent[0].scrollTop = scrolled = this.scrollParent[0].scrollTop - o.scrollSpeed;

                    if ((this.overflowOffset.left + this.scrollParent[0].offsetWidth) - event.pageX < o.scrollSensitivity)
                        this.scrollParent[0].scrollLeft = scrolled = this.scrollParent[0].scrollLeft + o.scrollSpeed;
                    else if (event.pageX - this.overflowOffset.left < o.scrollSensitivity)
                        this.scrollParent[0].scrollLeft = scrolled = this.scrollParent[0].scrollLeft - o.scrollSpeed;

                } else {

                    if (event.pageY - $(document).scrollTop() < o.scrollSensitivity)
                        scrolled = $(document).scrollTop($(document).scrollTop() - o.scrollSpeed);
                    else if ($(window).height() - (event.pageY - $(document).scrollTop()) < o.scrollSensitivity)
                        scrolled = $(document).scrollTop($(document).scrollTop() + o.scrollSpeed);

                    if (event.pageX - $(document).scrollLeft() < o.scrollSensitivity)
                        scrolled = $(document).scrollLeft($(document).scrollLeft() - o.scrollSpeed);
                    else if ($(window).width() - (event.pageX - $(document).scrollLeft()) < o.scrollSensitivity)
                        scrolled = $(document).scrollLeft($(document).scrollLeft() + o.scrollSpeed);

                }

                if (scrolled !== false && $.ui.ddmanager && !o.dropBehaviour)
                    $.ui.ddmanager.prepareOffsets(this, event);
            }

            //Regenerate the absolute position used for position checks
            this.positionAbs = this._convertPositionTo("absolute");

            //Set the helper position
            if (!this.options.axis || this.options.axis != "y") this.helper[0].style.left = this.position.left + 'px';
            if (!this.options.axis || this.options.axis != "x") this.helper[0].style.top = this.position.top + 'px';

            //Rearrange
            for (var i = this.items.length - 1; i >= 0; i--) {

                //Cache variables and intersection, continue if no intersection
                var item = this.items[i], itemElement = item.item[0], intersection = this._intersectsWithPointer(item);
                if (!intersection) continue;

                if (itemElement != this.currentItem[0] //cannot intersect with itself
					&& this.placeholder[intersection == 1 ? "next" : "prev"]()[0] != itemElement //no useless actions that have been done before
					&& !$.contains(this.placeholder[0], itemElement) //no action if the item moved is the parent of the item checked
					&& (this.options.type == 'semi-dynamic' ? !$.contains(this.element[0], itemElement) : true)
                //&& itemElement.parentNode == this.placeholder[0].parentNode // only rearrange items within the same container
				) {

                    this.direction = intersection == 1 ? "down" : "up";

                    if (this.options.tolerance == "pointer" || this._intersectsWithSides(item)) {
                        this._rearrange(event, item);
                    } else {
                        break;
                    }

                    // Clear emtpy ul's/ol's
                    this._clearEmpty(itemElement);

                    this._trigger("change", event, this._uiHash());
                    break;
                }
            }

            var parentItem = (this.placeholder[0].parentNode.parentNode && $(this.placeholder[0].parentNode.parentNode).closest('.ui-sortable').length) ? $(this.placeholder[0].parentNode.parentNode) : null;
            var level = this._getLevel(this.placeholder);
            var childLevels = this._getChildLevels(this.helper);
            var previousItem = this.placeholder[0].previousSibling ? $(this.placeholder[0].previousSibling) : null;
            if (previousItem != null) {
                while (previousItem[0].nodeName.toLowerCase() != 'li' || previousItem[0] == this.currentItem[0]) {

                    if (previousItem[0].previousSibling) {
                        previousItem = $(previousItem[0].previousSibling);
                    } else {
                        previousItem = null;
                        break;
                    }
                }
            }

            newList = document.createElement(o.listType);

            this.beyondMaxLevels = 0;

            // If the item is moved to the left, send it to its parent level
            if (parentItem != null && this.positionAbs.left < parentItem.offset().left) {
                parentItem.after(this.placeholder[0]);
                this._clearEmpty(parentItem[0]);
                this._trigger("change", event, this._uiHash());
            }
            // If the item is below another one and is moved to the right, make it a children of it
            else if (previousItem != null && this.positionAbs.left > previousItem.offset().left + o.tabSize) {
                this._isAllowed(previousItem, level + childLevels + 1);
                if (!previousItem.children(o.listType).length) {
                    previousItem[0].appendChild(newList);
                }
                previousItem.children(o.listType)[0].appendChild(this.placeholder[0]);
                this._trigger("change", event, this._uiHash());
            }
            else {
                this._isAllowed(parentItem, level + childLevels);
            }

            //Post events to containers
            this._contactContainers(event);

            //Interconnect with droppables
            if ($.ui.ddmanager) $.ui.ddmanager.drag(this, event);

            //Call callbacks
            this._trigger('sort', event, this._uiHash());

            this.lastPositionAbs = this.positionAbs;
            return false;

        },

        _mouseStop: function (event, noPropagation) {

            // If the item is in a position not allowed, send it back
            if (this.beyondMaxLevels) {
                var parent = this.placeholder.parent().closest(this.options.items);

                for (var i = this.beyondMaxLevels - 1; i > 0; i--) {
                    parent = parent.parent().closest(this.options.items);
                }

                this.placeholder.removeClass(this.options.errorClass);
                parent.after(this.placeholder);
                this._trigger("change", event, this._uiHash());
            }

            $.ui.sortable.prototype._mouseStop.apply(this, arguments);

        },

        serialize: function (o) {

            var items = this._getItemsAsjQuery(o && o.connected);
            var str = []; o = o || {};

            $(items).each(function () {
                var res = ($(o.item || this).attr(o.attribute || 'id') || '').match(o.expression || (/(.+)[-=_](.+)/));
                var pid = ($(o.item || this).parent(o.listType).parent('li').attr(o.attribute || 'id') || '').match(o.expression || (/(.+)[-=_](.+)/));
                if (res) str.push((o.key || res[1] + '[' + (o.key && o.expression ? res[1] : res[2]) + ']') + '=' + (pid ? (o.key && o.expression ? pid[1] : pid[2]) : 'root'));
            });

            if (!str.length && o.key) {
                str.push(o.key + '=');
            }

            return str.join('&');

        },

        toHierarchy: function (o) {

            o = o || {};
            var sDepth = o.startDepthCount || 0;
            var ret = [];

            $(this.element).children('li').each(function () {
                var level = _recursiveItems($(this));
                ret.push(level);
            });

            return ret;

            function _recursiveItems(li) {
                var id = ($(li).attr(o.attribute || 'id') || '').match(o.expression || (/(.+)[-=_](.+)/));
                if (id != null) {
                    var item = { "id": id[2] };
                    if ($(li).children(o.listType).children('li').length > 0) {
                        item.children = [];
                        $(li).children(o.listType).children('li').each(function () {
                            var level = _recursiveItems($(this));
                            item.children.push(level);
                        });
                    }
                    return item;
                }
            }
        },

        toArray: function (o) {

            o = o || {};
            var sDepth = o.startDepthCount || 0;
            var ret = [];
            var left = 2;

            ret.push({ "item_id": 'root', "parent_id": 'none', "depth": sDepth, "left": '1', "right": ($('li', this.element).length + 1) * 2 });

            $(this.element).children('li').each(function () {
                left = _recursiveArray(this, sDepth + 1, left);
            });

            function _sortByLeft(a, b) {
                return a['left'] - b['left'];
            }
            ret = ret.sort(_sortByLeft);

            return ret;

            function _recursiveArray(item, depth, left) {

                right = left + 1;

                if ($(item).children(o.listType).children('li').length > 0) {
                    depth++;
                    $(item).children(o.listType).children('li').each(function () {
                        right = _recursiveArray($(this), depth, right);
                    });
                    depth--;
                }

                id = ($(item).attr(o.attribute || 'id')).match(o.expression || (/(.+)[-=_](.+)/));

                if (depth === sDepth + 1) pid = 'root';
                else {
                    parentItem = ($(item).parent(o.listType).parent('li').attr('id')).match(o.expression || (/(.+)[-=_](.+)/));
                    pid = parentItem[2];
                }

                if (id != null) {
                    ret.push({ "item_id": id[2], "parent_id": pid, "depth": depth, "left": left, "right": right });
                }

                return left = right + 1;
            }

        },

        destroy: function () {
            //  this.element.removeClass('qs-tagged');

            // if using jQuery UI 1.8.x
            
            // if using jQuery UI 1.9.x
            //this._destroy();

            this.element.removeData('sortable');
            this.element.removeData('nestedSortable');
            $.Widget.prototype.destroy.call(this);
        },

        _clear: function (event, noPropagation) {

            $.ui.sortable.prototype._clear.apply(this, arguments);

            // Clean last empty ul/ol
            for (var i = this.items.length - 1; i >= 0; i--) {
                var item = this.items[i].item[0];
                this._clearEmpty(item);
            }
            return true;

        },

        _clearEmpty: function (item) {

            if (item.children[1] && item.children[1].children.length == 0) {
                item.removeChild(item.children[1]);
            }

        },

        _getLevel: function (item) {

            var level = 1;

            if (this.options.listType) {
                var list = item.closest(this.options.listType);
                
                while (!list.is('.ui-sortable') && level < 100/*this.options.maxLevels*/) {
                    level++;
                    list = list.parent().closest(this.options.listType);
                }
            }

            return level;
        },

        _getChildLevels: function (parent, depth) {
            var self = this,
			    o = this.options,
			    result = 0;
            depth = depth || 0;

            $(parent).children(o.listType).children(o.items).each(function (index, child) {
                result = Math.max(self._getChildLevels(child, depth + 1), result);
            });

            return depth ? result + 1 : result;
        },

        _isAllowed: function (parentItem, levels) {
            var o = this.options;
            // Are we trying to nest under a no-nest or are we nesting too deep?
            if (parentItem == null || !(parentItem.hasClass(o.disableNesting))) {
                if (o.maxLevels < levels && o.maxLevels != 0) {
                    this.placeholder.addClass(o.errorClass);
                    this.beyondMaxLevels = levels - o.maxLevels;
                } else {
                    this.placeholder.removeClass(o.errorClass);
                    this.beyondMaxLevels = 0;
                }
            } else {
                this.placeholder.addClass(o.errorClass);
                if (o.maxLevels < levels && o.maxLevels != 0) {
                    this.beyondMaxLevels = levels - o.maxLevels;
                } else {
                    this.beyondMaxLevels = 1;
                }
            }
        }

    }));

    $.ui.nestedSortable.prototype.options = $.extend({}, $.ui.sortable.prototype.options, $.ui.nestedSortable.prototype.options);
})(jQuery);


(function ($, doc, win) {
    "use strict";

    var _options;
    var methods = {
        init: function (options) {
            var defaults = {
                classes: {
                    textContainer: "limTextContainer"
                },
                debug: false,
                sortableOptions: {
                    disableNesting: 'no-nest',
                    forcePlaceholderSize: true,
                    handle: 'div',
                    helper: 'clone',
                    items: 'li',
                    maxLevels: 5,
                    opacity: .6,
                    placeholder: 'drag-placeholder',
                    revert: 250,
                    tabSize: 25,
                    tolerance: 'pointer',
                    toleranceElement: '> div'
                },
                events : {
                    onAddText : function (){}   
                }
            };
            _options = $.extend(defaults, options);

            $.liManipulator.generate(this);

        },
        destroy: function () {

        },
        data: function () {
            var data = $.liManipulator.data();
            return data;
        },
        reset: function(){
            $.liManipulator.reset();
        }
    };

    $.fn.liManipulator = function (method) {

        // Method calling logic
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.tooltip');
        }
        return this;
    };

    function LiManipulator(settings) {
        this.settings = settings;

    }


    $.liManipulator = {
        generate: function (root) {
            //var ol = $('ol.sortable');
            $.liManipulator.initRoot = root;
            root.empty();
            
            var ol = $("<ol data-key='root' class='sortable'></ol>");
            ol.appendTo(root);

            var li = $("<li id='limItem_1'><div class='" + _options.classes.textContainer + "'>"+$.liManipulator.textHtml()+"</div></li>").appendTo(ol);
            //var li = $("<li id='list_1'><div>Test</div></li>").appendTo(ol);

            //var input = $("<input type='text' class='input-title' />").appendTo(li);

            $("input", li).bind('keydown.additems', function (e) {
                $.liManipulator.keyDown(e, li);
            });

            ol.nestedSortable(_options.sortableOptions);
            $.liManipulator._focus(li);
        },
        initRoot: null,
        reset: function () {
            $.liManipulator.initRoot.empty();
            $.liManipulator.generate($.liManipulator.initRoot);
        },
        nextId: 2 //default node is 1, therefore next is 2
        ,
        //Generating ui functions
        textHtml: function(){
            var s = "<div class='" + _options.classes.textContainer + "'><input type='text' class='input-title width-95' /></div>";
            return s;
        }
        ,
        createNode: function (sibling) {

            if (_options.debug)
                console.info("Create Node", sibling);

            var li = $("<li id='limItem_" + $.liManipulator.nextId +"'>"+ $.liManipulator.textHtml() +"</li>");
            $.liManipulator.nextId++;
            sibling.after(li);
            
            var tb = li.children("div").children("input");

            $.liManipulator._bindTextboxEvents(tb, li);
            tb.focus();
        },
        convertTextbox: function (li) {
            if (_options.debug)
                console.info("Convert Text Box", li);

            var text = $(".input-title", li);

            if (text.val() == "") {
                //Empty, remove li
                if($("ol[data-key='root']").find("li").length > 1) {
                    if (li.find("li").length == 0) {
                        li.remove(); //don't remove the only one there.
                    }
                }
                return false;
            }

            li.children("div").remove();
            li.prepend('<div><span class="fonticon-drag-handle valign-text-bottom margin-right-5" style="color:#C4C4C4;"></span>' + text.val() + '</div>');

            _options.events.onAddText();
            
            li.children("div").bind("click.edititem", function (e) {
                $.liManipulator._edit(li);
                e.preventDefault();
            });
            return true;
        },
        _rebind: function () {
            $("ol[data-key='root']").nestedSortable('destroy');
            $("ol[data-key='root']").nestedSortable(_options.sortableOptions);
        },
        _edit: function (li) {

            if (_options.debug)
                console.info("Edit", li);

            var text = li.children("div").text();
            var textBox = $("<div class='" + _options.classes.textContainer + "'>"+$.liManipulator.textHtml()+"</div>");
            li.children('div').remove();
            li.prepend(textBox);

            var tb = textBox.find("input");
            $.liManipulator._bindTextboxEvents(tb, li);
            tb.val(text).focus();;
            $.liManipulator._focus(li);
            
        },


        //Indenting
        indent: function (li) {
            var prevSibling = li.prev('li');
            if (!prevSibling || prevSibling == "undefined" || prevSibling.length == 0)
                return;

            var ol = prevSibling.children("ol");

            if (!ol || ol == "undefined" || ol.length == 0) {
                prevSibling.append("<ol></ol>");
                ol = prevSibling.children("ol");
            }

            ol.append(li);
            
            //console.info("OL", $("ol[data-key='root']"));
            $.liManipulator._rebind();

            ol.find("input").focus();
            /*$("input", li).focus();*/

            $.liManipulator._focus(li);

        },
        outdent: function (li) {
            var parent = li.parent().closest("li");

            if (!parent || parent == "undefined" || parent.length == 0)
                return;

            parent.after(li);
            $("input", li).focus();
            $.liManipulator._rebind();
            $.liManipulator._focus(li);
        },
        _previous: function (li) {
            //get all nodes
            var root = $("ol[data-key='root']");
            var nodes = root.find("li");
            var $prev = $(nodes[nodes.index(li) - 1]);
            $.liManipulator._edit($prev);
        },
        _next: function (li) {
            //get all nodes
            var root = $("ol[data-key='root']");
            var nodes = root.find("li");
            //check for end of array
            if(nodes.length -1 <= nodes.index(li) )
                return;
            var $prev = $(nodes[nodes.index(li) + 1]);
            $.liManipulator._edit($prev);
        },
        _focus: function (node) {
            node.find("input").focus();
            setTimeout(
                function () {
                    var n = node.find("input");
                    n.focus();
                }
                , 100);
        },

        //Event Functions
        _bindTextboxEvents: function (tb, li) {
            li = tb.closest("li");
            tb.bind('keydown.additems', function (e) {
                $.liManipulator.keyDown(e, li);
            }).bind('blur.additems', function (e) {
                var root = $("ol[data-key='root']");
                if (root.find("input").length > 1) {
                    $.liManipulator.convertTextbox(tb.closest("li"));
                }
            });
        },
        keyDown: function (e, node) {
            switch (e.which) {
                case 13:
                    if($.liManipulator.convertTextbox(node))
                        $.liManipulator.createNode(node);
                    break;
                case 9: //tab
                    if (e.shiftKey)
                        $.liManipulator.outdent(node);
                    else
                        $.liManipulator.indent(node);
                    e.preventDefault();
                    return false;
                    
                case 37://left
                    break;
                case 38: //Up
                    $.liManipulator._previous(node);
                    break;
                case 39: //right
                    break;
                case 40: //down
                    $.liManipulator._next(node);
                    break;
            }
        },

        //Get Data...
        data: function () {
            var root = $("ol[data-key='root']");
            var ret = $.liManipulator._parseRoot(root);
            return ret;
        },
        _parseRoot: function (ol) {
            var ret = [];
            $.each(ol.children("li"), function (i, li) {
                ret.push($.liManipulator._parseNode(li));
            });
            return ret;
        },
        _parseNode: function (li) {
            var root = $(li).children("ol");
            var children = [];
            if (root.length > 0)
                children = $.liManipulator._parseRoot(root);
            var ret = {
                /*id: $(li).attr("id"),*/
                text: $(li).children("div").text(),
                children: children
            };
            return ret;
        }
    };

    //pass jQuery to the function, 
    //So that we will able to use any valid Javascript variable name 
    //to replace "$" SIGN. But, we'll stick to $ (I like dollar sign: ) )       
})(jQuery);


