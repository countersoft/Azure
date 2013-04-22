 /* =============================================================
 * tabledata.js v1.0.0
 * =============================================================
 * Copyright 2012 Steve Saxton.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ============================================================== */
!function ( $ ) {

    "use strict"

    function EventData() 
    {
        var isPropagationStopped = false;
        var isImmediatePropagationStopped = false;

        // Stops event from propagating up the DOM tree.
        // @method stopPropagation
        this.stopPropagation = function () 
        {
            isPropagationStopped = true;
        };

        // Returns whether stopPropagation was called on this event object.
        // @method isPropagationStopped
        // @return {Boolean}
        this.isPropagationStopped = function () 
        {
            return isPropagationStopped;
        };

        // Prevents the rest of the handlers from being executed.
        // @method stopImmediatePropagation
        this.stopImmediatePropagation = function () 
        {
            isImmediatePropagationStopped = true;
        };

        // Returns whether stopImmediatePropagation was called on this event object.\
        // @method isImmediatePropagationStopped
        // @return {Boolean}
        this.isImmediatePropagationStopped = function () 
        {
            return isImmediatePropagationStopped;
        }
    }    
    
    // A simple publisher-subscriber implementation.
    function Event() 
    {
        var handlers = [];

        // Adds an event handler to be called when the event is fired.
        // <p>Event handler will receive two arguments - an <code>EventData</code> and the <code>data</code>
        // object the event was fired with.<p>
        // @method subscribe
        // @param fn {Function} Event handler.
        this.subscribe = function (fn) 
        {
            handlers.push(fn);
        };

        // Removes an event handler added with <code>subscribe(fn)</code>.
        // @method unsubscribe
        // @param fn {Function} Event handler to be removed.
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

        // Fires an event notifying all subscribers.
        // @method notify
        // @param args {Object} Additional data object to be passed to all handlers.
        // @param e {EventData}
        //      Optional.
        //      An <code>EventData</code> object to be passed to all handlers.
        //      For DOM events, an existing W3C/jQuery event object can be passed in.
        // @param scope {Object}
        //      Optional.
        //      The scope ("this") within which the handler will be executed.
        //      If not specified, the scope will be set to the <code>Event</code> instance.
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

    function EventHandler() 
    {
        var handlers = [];

        this.subscribe = function (event, handler) 
        {
            handlers.push({ event: event, handler: handler });
            event.subscribe(handler);
        };

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
    
    // TableData - Class 
    // =================================================
    var TableData = function(element, columns, options) 
    {
        // extend the options and columns as required 
        var columns = columns
        var options = $.extend({}, $.fn.tabledata.defaults, options)
        
        // reference important table elements 
        var table = element
        var tableBody = table.tBodies[0]  
        var headerRow = table.tHead
        var header$ = $(table.tHead).find('th')
        var tableRow$ = $(element).find('tr:gt(0)')
        
        // Caching for later
        var rowsCache = {};
        var columnsById = {};
        var index = {};               // find data, speed improvements - index items by id
        
        // proxy the trigger method
        //var trigger = $.proxy(this.trigger, this);
        //var process = $.proxy(this.process, this);
        //var $element = $(element).is('body') ? $(window) : $(element);
        //this.$scrollElement = $element.on('scroll.scroll.data-api', process)
        //this.selector = (this.options.target || $(element).attr('href') || '') + ' .nav li > a';
        //this.$body = $('body').on('click.scroll.data-api', this.selector, process);

        bindEvents()
        //setStyles();
        setHeaders()
        
        // Set-up functions
        // =========================================================
        
        function bindEvents() {

            //table
            //    .addClass('tableData table-bordered')
            //    .on("resize.tabledata", this, this.handle); 
            header$
                .on("click.tabledata", handleHeaderClick); 
            //    .on("contextmenu.tabledata", this, this.handleHeaderContextMenu);
            //headerRow
            //    .on("keydown.tabledata", this, this.handleKeyDown)
            //    .on("click.tabledata", this, this.handleClick)
            //    .on("dblclick.tabledata", this, this.handleDblClick)
            //    .on("contextmenu.tabledata", this, this.handleContextMenu)
            //    .on("draginit", this, this.handleDragInit)
            //    .on("dragstart", this, this.handleDragStart)
            //    .on("drag", this, this.handleDrag)
            //    .on("dragend", this, this.handleDragEnd)
            //    .on("mouseenter", '.cell', this, this.handleMouseEnter)
            //    .on("mouseleave", '.cell', this, this.handleMouseLeave);        
        }
        
        function setHeaders() 
        {
            function hoverBegin()
            {
                $(this).addClass("hover");
            }
            function hoverEnd()
            {
                $(this).removeClass("hover");
            }        
        
            //var headers = this.$headers;
            var firstResizable, lastResizable;
            var height = 0;
        
            //var m = columns[i] = $.extend({}, $.fn.tabledata.columnDefaults, columns[i]);
            //headers.find("resizable").remove();
            header$.each(function (i,e) 
            {
                var m = columns[i] = $.extend({}, $.fn.tabledata.columnDefaults, columns[i]);
                
                var elem = $(e)
                    .attr('id',m.field)
                    .attr('title', m.name);
                
                if (m.resizable)
                {
                    if (firstResizable === undefined)
                    {
                        firstResizable = i;
                    }
                    lastResizable = i;
                    elem.addClass("fluid");
                }
                else
                {
                    elem.addClass("fixed");
                }
                
                // Add preferred user styles
                if ( m.headerCssClass )
                {
                    elem.addClass(m.headerCssClass);
                }
                
                if ( m.sortable )
                {
                    switch(m.sortDirection)
                    {
                        case 1:
                            elem.addClass("sorted-asc");
                            break;
                        case -1:
                            elem.addClass("sorted-desc");
                            break;
                        default:
                            elem.addClass("sortable");
                            break;
                    }
                }
                
                height = Math.max(height, this.clientHeight || this.offsetHeight );

                if (options.enableColumnReorder || m.sortable)
                {
                    elem.hover(hoverBegin, hoverEnd);
                }
            })
            
            if (firstResizable === undefined)
            {
                return;
            }
            
            header$.each(function (i,e) 
            {
                var elem = $(e)
                
                // Should reallly use the space for the grip to include the sortable markers 
                //
                //  grip:sortable
                //  grip:sorted-asc
                //  grip:sorted-desc
                //  grip:notsortable
                //  nogrip:sorted-asc
                //  nogrip:sorted-desc
                //  nogrip:sortable
                //  empty space
                
                if ( columns[i].resizable )
                {
                    $('<span class="grip" />')

                    //.height(height)
                    .appendTo(e)
                    .on("dragstart", function (e, dd)
                        {
                            //
                            $(this).parent().addClass("resizing");

                            //header$.each(function (i, e)
                            //{
                            //    columns[i].previousWidth = elem.outerWidth();
                            //});                    
                        })
                    
                    .on("drag", function (e, dd)
                        {
                            //
                        })
                
                    .on("dragend", function (e, dd)
                        {
                            //
                            $(this).parent().removeClass("resizing");
                        })
                }
                else
                {
                    $("<span class='nogrip' />")
                    //.height(height)
                    .appendTo(e)
                }
            })
        }
        
        // Support functions
        // =========================================================
        function getColumnIndex(id)
        {
            return columnsById[id];
        }
        
        // Handlers functions
        // =========================================================
        function handleHeaderClick(e)
        {
            //var container = e.data.$container;
            //var header$ = $(e.target);
            var data = header$.data("fieldId")
        
            var column = header$ && columns[getColumnIndex()];
        
            //var $header = $(e.target).closest(".slick-header-column", ".slick-header-columns");
            //var column = $header && columns[self.getColumnIndex($header.data("fieldId"))];
             trigger(element.onHeaderClick, { column: column }, e);
        }
    }
       
    // Prototype
    // =================================================
    TableData.prototype = {

        constructor: TableData,

        /*
        handleHeaderContextMenu: function(e) 
        {
            var $header = $(e.target).closest(".slick-header-column", ".slick-header-columns");
            var column = $header && columns[self.getColumnIndex($header.data("fieldId"))];
            trigger(self.onHeaderContextMenu, { column: column }, e);
        },

        //////////////////////////////////////////////////////////////////////////////////////////////
        // Interactivity
        // handle function
        handle: function () 
        {
            this.targets = this.$body.find(this.selector);
        },
        
        handleKeyDown: function(e)
        {
            trigger(self.onKeyDown, {}, e);
            var handled = e.isImmediatePropagationStopped();

            if (!handled)
            {
                if (!e.shiftKey && !e.altKey && !e.ctrlKey)
                {
                    if (e.which == 27)
                    {
                        if (!getEditorLock().isActive())
                        {
                            return; // no editing mode to cancel, allow bubbling and default processing (exit without cancelling the event)
                        }
                        cancelEditAndSetFocus();
                    } else if (e.which == 37)
                    {
                        navigateLeft();
                    } else if (e.which == 39)
                    {
                        navigateRight();
                    } else if (e.which == 38)
                    {
                        navigateUp();
                    } else if (e.which == 40)
                    {
                        navigateDown();
                    } else if (e.which == 9)
                    {
                        navigateNext();
                    } else if (e.which == 13)
                    {
                        if (options.editable)
                        {
                            if (currentEditor)
                            {
                                // adding new row
                                if (activeRow === numberOfRows)
                                {
                                    navigateDown();
                                }
                                else
                                {
                                    commitEditAndSetFocus();
                                }
                            } else
                            {
                                if (getEditorLock().commitCurrentEdit())
                                {
                                    makeActiveCellEditable();
                                }
                            }
                        }
                    } else
                    {
                        return;
                    }
                } else if (e.which == 9 && e.shiftKey && !e.ctrlKey && !e.altKey)
                {
                    navigatePrev();
                } else
                {
                    return;
                }
            }

            // the event has been handled so don't let parent element (bubbling/propagation) or browser (default) handle it
            e.stopPropagation();
            e.preventDefault();
            try
            {
                e.originalEvent.keyCode = 0; // prevent default behaviour for special keys in IE browsers (F3, F5, etc.)
            }
            // ignore exceptions - setting the original event's keycode throws access denied exception for "Ctrl"
            // (hitting control key only, nothing else), "Shift" (maybe others)
            catch (error)
            {
            }
        },

        handleClick: function(e)
        {
            var cell = getCellFromEvent(e);
            if (!cell || (currentEditor !== null && activeRow == cell.row && activeCell == cell.cell))
            {
                return;
            }

            trigger(self.onClick, { row: cell.row, cell: cell.cell }, e);
            if (e.isImmediatePropagationStopped())
            {
                return;
            }

            if (canCellBeActive(cell.row, cell.cell))
            {
                if (!getEditorLock().isActive() || getEditorLock().commitCurrentEdit())
                {
                    //scrollRowIntoView(cell.row, false);
                    setActiveCellInternal(getCellNode(cell.row, cell.cell), (cell.row === numberOfRows) || options.autoEdit);
                }
            }
        },

        handleContextMenu: function(e)
        {
            var $cell = $(e.target).closest(".slick-cell", $canvas);
            if ($cell.length === 0)
            {
                return;
            }

            // are we editing this cell?
            if (activeCellNode === $cell[0] && currentEditor !== null)
            {
                return;
            }

            trigger(self.onContextMenu, {}, e);
        },

        handleDblClick: function(e)
        {
            var cell = getCellFromEvent(e);
            if (!cell || (currentEditor !== null && activeRow == cell.row && activeCell == cell.cell))
            {
                return;
            }

            trigger(self.onDblClick, { row: cell.row, cell: cell.cell }, e);
            if (e.isImmediatePropagationStopped())
            {
                return;
            }

            if (options.editable)
            {
                gotoCell(cell.row, cell.cell, true);
            }
        },

        handleDragInit: function(e, dd)
        {
            var cell = getCellFromEvent(e);
            if (!cell || !cellExists(cell.row, cell.cell))
            {
                return false;
            }

            retval = trigger(self.onDragInit, dd, e);
            if (e.isImmediatePropagationStopped())
            {
                return retval;
            }

            // if nobody claims to be handling drag'n'drop by stopping immediate propagation,
            // cancel out of it
            return false;
        },

        handleDragStart: function(e, dd)
        {
            var cell = getCellFromEvent(e);
            if (!cell || !cellExists(cell.row, cell.cell))
            {
                return false;
            }

            var retval = trigger(self.onDragStart, dd, e);
            if (e.isImmediatePropagationStopped())
            {
                return retval;
            }

            return false;
        },

        handleDrag: function(e, dd)
        {
            return trigger(self.onDrag, dd, e);
        },

        handleDragEnd: function(e, dd)
        {
            trigger(self.onDragEnd, dd, e);
        },
        
        handleMouseEnter: function(e)
        {
            trigger(self.onMouseEnter, {}, e);
        },

        handleMouseLeave: function(e)
        {
            trigger(self.onMouseLeave, {}, e);
        },
        
        // ====================================================================
        
        // refresh function
        refresh: function () {
        
            this.targets = this.$body
                .find(this.selector)
                .map(function () {
                    var href = $(this).attr('href')
                    return /^#\w/.test(href) && $(href).length ? href : null
                })

            this.offsets = $.map(this.targets, function (id) {
                return $(id).position().top
            })
        },

        // process
        process: function () {
        
            var scrollTop = this.$scrollElement.scrollTop() + this.options.offset,
                offsets = this.offsets,
                targets = this.targets,
                activeTarget = this.activeTarget,
                i

            for (i = offsets.length; i--;) {
                activeTarget != targets[i]
                && scrollTop >= offsets[i]
                && (!offsets[i + 1] || scrollTop <= offsets[i + 1])
                && this.activate( targets[i] )
            }
        },

        // activate
        activate: function (target) {
            var active

            this.activeTarget = target
            this.$body
                .find(this.selector).parent('.active')
                .removeClass('active')

            active = this.$body
                .find(this.selector + '[href="' + target + '"]')
                .parent('li')
                .addClass('active')

            if ( active.parent('.dropdown-menu') )  {
                active.closest('li.dropdown').addClass('active')
            }
        }
        */
    }

    
    // =================================================
    // TableData - this is the 'Plugin' definition
    // =================================================
    $.fn.tabledata = function ( columns, options ) {
        
        // options meta data expansion
        var opts = $.extend({}, $.fn.tabledata.defaults, options);
        
        return this.each(function () {

            // get the Parent element
            var $this = $(this);

            // attach events and public properties to each element
            // use $this if you wish to attach to variable in page
            applyEventsAndMethods(this);
            
            var data = $this.data('tabledata');
            
            //var newOptions = typeof opts == 'object' && opts;
            //var o = $meta ? $.extend({}, opts, this.data()) : opts;
            
            if (!data) 
                $this.data('tabledata', (data = new TableData(this, columns, opts)))
              
            //if (typeof opts == 'string') 
            //    data[opts]()
        })
    }
    
    $.fn.tabledata.Constructor = TableData

    $.fn.tabledata.defaults = 
    {
        explicitInitialization: false,
        autoEdit: true,
        editable: false,
        enableCellNavigation: true,
        enableColumnReorder: true,
        asyncEditorLoading: false,
        enableAsyncPostRender: false,
        enableTextSelectionOnCells: false,
        fullWidthRows: false,
        multiSelect: true,
        headerHeight: 25,
        rowHeight: 25,
        defaultColumnWidth: 80,
        asyncEditorLoadDelay: 100,
        asyncPostRenderDelay: 60,
        cellFlashingCssClass: "flashing",
        selectedCellCssClass: "selected",
        dataItemColumnValueExtractor: null,
        formatterFactory: null,
        editorFactory: null,
//        editorLock: Slick.GlobalEditorLock,
        idProperty: "id"                        // a property holding a unique row id
    }

    $.fn.tabledata.columnDefaults = 
    {
        name: "",                   // no name by default
        hidden: false,              // do not skip column when rendering
        resizable: true,            // can be resized
        rerenderOnResize: false,    // don't re-render on resize
        sortable: true,             // sortable
        sortDirection: 0,           // not sorted by default *** (1, 0, -1) allowed
        minWidth: 32,               // never smaller than 32px
        headerCssClass: null,       // no user specific style should be applied to header
        dataCssClass: null          // no user specific style should be applied to data
    }

    function trigger(evt, args, e)
    {
        e = e || new EventData();
        args = args || {};
        args.grid = self;
        return evt.notify(args, e, self);
    }

    function applyEventsAndMethods(obj)
    {
        $.extend( obj, {
        
            "version": "1.0a1",
            "aardvark": true,

            // Events
            "onSort": new Event(),
            "onHeaderContextMenu": new Event(),
            "onHeaderClick": new Event(),
            "onMouseEnter": new Event(),
            "onMouseLeave": new Event(),
            "onClick": new Event(),
            "onDblClick": new Event(),
            "onContextMenu": new Event(),
            "onKeyDown": new Event(),
            "onAddNewRow": new Event(),
            "onValidationError": new Event(),
            "onViewportChanged": new Event(),
            "onColumnsReordered": new Event(),
            "onColumnsResized": new Event(),
            "onCellChange": new Event(),
            "onBeforeEditCell": new Event(),
            "onBeforeCellEditorDestroy": new Event(),
            "onBeforeDestroy": new Event(),
            "onActiveCellChanged": new Event(),
            "onActiveCellPositionChanged": new Event(),
            "onDragInit": new Event(),
            "onDragStart": new Event(),
            "onDrag": new Event(),
            "onDragEnd": new Event(),
            "onSelectedRowsChanged": new Event(),
            "onRenderComplete": new Event(),                 
            "onInitComplete": new Event(),
            "onFinalizeComplete": new Event(),
            
            // Methods
            //"registerPlugin": registerPlugin,
            //"unregisterPlugin": unregisterPlugin,
            //"getColumns": getColumns,
            //"setColumns": setColumns,
            //"getColumnIndex": getColumnIndex,
            //"updateColumnHeader": updateColumnHeader,
            //"setSortColumn": setSortColumn,
            //"getOptions": getOptions,
            //"setOptions": setOptions,
            //"getData": getData,
            ////"getDataLength": getDataLength,
            //"getDataLength": getNumberOfRows,
            //"getDataItem": getDataItem,
            //"setData": setData,
            //"getSelectionModel": getSelectionModel,
            //"setSelectionModel": setSelectionModel,
            //"getSelectedRows": getSelectedRows,
            //"setSelectedRows": setSelectedRows,

            //"render": render,
            //"invalidate": invalidate,
            //"invalidateRow": invalidateRow,
            //"invalidateRows": invalidateRows,
            //"invalidateAllRows": invalidateAllRows,
            //"updateCell": updateCell,
            //"updateRow": updateRow,
            //"getRenderedRange": getRenderedRange,
            //"resizeCanvas": resizeCanvas,
            //"updateRowCount": updateRowCount,
            //"getCanvasNode": getCanvasNode,

            //"getCellFromPoint": getCellFromPoint,
            //"getCellFromEvent": getCellFromEvent,
            //"getActiveCell": getActiveCell,
            //"setActiveCell": setActiveCell,
            //"getActiveCellNode": getActiveCellNode,
            //"getActiveCellPosition": getActiveCellPosition,
            //"resetActiveCell": resetActiveCell,
            //"editActiveCell": makeActiveCellEditable,
            //"getCellEditor": getCellEditor,
            //"getCellNode": getCellNode,
            //"getCellNodeBox": getCellNodeBox,
            //"canCellBeSelected": canCellBeSelected,
            //"canCellBeActive": canCellBeActive,
            //"navigatePrev": navigatePrev,
            //"navigateNext": navigateNext,
            //"navigateUp": navigateUp,
            //"navigateDown": navigateDown,
            //"navigateLeft": navigateLeft,
            //"navigateRight": navigateRight,
            //"gotoCell": gotoCell,
            //"getGridPosition": getGridPosition,
            //"flashCell": flashCell,
            //"addCellCssStyles": addCellCssStyles,
            //"setCellCssStyles": setCellCssStyles,
            //"removeCellCssStyles": removeCellCssStyles,

            // Sbs - Hook more events

            // Sbs - Support Methods
            //"beginUpdate": beginUpdate,
            //"endUpdate": endUpdate,
            //"refresh": resizeCanvas,                
            //"setIndex": setIndexProperty,
            //"updateIndex": updateIndex,
            //"getIndexById": getIndexById,
            //"getItemById": getItemById,
            //"initialize": init,
            //"finalize": finishInitialization,
            //"destroy": destroy,

            // IEditor implementation
            //"getEditorLock": getEditorLock,
            //"getEditController": getEditController            
        })
    }

}( window.jQuery )

