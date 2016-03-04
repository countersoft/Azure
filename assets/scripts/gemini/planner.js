planner =
{
    settings:
    {
        container: '#planner ul',
        itemSelector: '.plan-card',
        placeholder: 'drag-placeholder'
    },

    readOnly: false,
    currentDraggedCard: null,
    animations: [],
    selectedContextCard: null,
    pageEffect: 'helix', // choose from => 'none', 'flip, 'flip-back', 'fly', 'fly-out', 'fly-reverse', 'helix', 'helix-out' 'slide', 'slide-right', 'fan', 'tilt', 'curl', 'zipper'
    jscrollPaneApi: null,
    escapeDropdowns: function (guid, selector) {
        $(selector).hide();
        gemini_keyboard.unbindEscape(guid);
    },

    initialize: function (readOnly)
    {
        planner.readOnly = readOnly;
        gemini_edit.initEdit(0, 1, '#cs-popup', '#cs-popup-content', '#data', planner.refreshPlannerLaner);
        
        planner.initOptions();

        $(window).resize(function ()
        {
            planner.adjustScrollBars();
            return false;
        });

        // Initialise the sort direction arrows
        planner.addSortDirections();
                
        planner.showInfoTip();
        planner.bindCardTitleChange();
        planner.addArrowDownEvents();
        // make the first call
        planner.saveData();

        gemini_master.currentRefreshFunction = planner.saveData;

        return false;
    },

    highlight: function (hightlight) {
        var index;
        for (index = 0; index < hightlight.length; ++index) {
            $('#' + hightlight[index], '#planner-box').addClass('view-issue-highlight');
        }
    },

    removeHighlight: function (hightlight) {
        if (!$('#planner-box').length) return;
        var index;
        for (index = 0; index < hightlight.length; ++index) {
            $('#' + hightlight[index], '#planner-box').removeClass('view-issue-highlight');
        }
    },

    initOptions: function()
    {
        if (!planner.readOnly)
        {
            $('#AxisFlipped').click(function ()
            {
                var axis1Selected = $('#Axis1Selected option:selected', '#planner-control-box').val();
                var axis2Selected = $('#Axis2Selected option:selected', '#planner-control-box').val();

                // Setting the selected value in the list for the chosen controls.
                $('#Axis1Selected', '#planner-control-box').val(axis2Selected);
                $('#Axis2Selected', '#planner-control-box').val(axis1Selected);

                // Chosens need updating too !!!
                gemini_ui.chosenUpdate($("#Axis1Selected"));
                gemini_ui.chosenUpdate($("#Axis2Selected"));

                planner.saveData();
                return false;
            });

            // Make the popup box appear / disappear (such as the group by selector, colour picker etc...).
            $('.control-icon', '#planner-control-box').click(function ()
            {
                var _this = $(this);
                var options = _this.find('+ .options');

                if (options.is(":visible"))
                {
                    options.hide();
                    gemini_keyboard.unbindEscape("#page-options-box .options");
                }
                else
                {
                    _this.parent().parent().find(".options").each(function ()
                    {
                        if ($(this).is(":visible"))
                        {
                            $(this).hide();
                        }
                    });

                    options.show();
                    gemini_keyboard.bindEscape("#page-options-box .options", planner.escapeDropdowns);
                    $("input[type='text']:first", options).focus();
                }

                options.position({
                    "of": _this,
                    "my": "right top",
                    "at": "right bottom",
                    "offset": "0 0",
                    "collision": "none"
                });
            });
        }

        // replace click on #planner levels
        $('#PlannerLevel', '#planner-control-box').click(function (evt)
        {
            var xpos = 0;
            if (evt.offsetX == undefined)   // Firefox
            {
                var parentOffset = $(this).parent().offset();
                //xpos = evt.pageX - parentOffset.left;
                xpos = evt.clientX - parentOffset.left;
            }
            else
            {
                xpos = evt.offsetX;
            }

            var level = Math.floor(xpos / 28);

            if (level == undefined) level = 2;
            if (level < 0) level = 0;

            // No level 0
            level++;

            if (level > 4) level = 4;

            var _this = $(this);
            _this.removeClass('level-0 level-1 level-2 level-3 level-4').addClass('level-' + level);

            planner.saveData();
            return false;
        });

        if (!planner.readOnly)
        {
            // Bind only one listener for all div.sort clicks
            $('#planner-control-box div.sort').click(function ()
            {
                var _this = $(this);
                var ascending = _this.hasClass('asc');

                if (ascending)
                {
                    _this.removeClass('asc').addClass('desc');   // could just toggleClass('desc') and detect that
                    _this.removeClass('fonticon-ahead-arrow').addClass('fonticon-behind-arrow');
                }
                else
                {
                    _this.removeClass('desc').addClass('asc');   // could just toggleClass('desc') and detect that
                    _this.removeClass('fonticon-behind-arrow').addClass('fonticon-ahead-arrow');
                }

                planner.saveData();
                return false;
            });

            $('#planner-control-box').on('change', 'input,select', function ()
            {
                planner.saveData();
                return false;
            });
        }
    },
    
    refreshPlannerLaner: function (response, issueId)
    {
        var item = $("#" + issueId).parent();
        
        // not processed, so it did not move between cells 
        // so the card has only moved inside the same cell 
        var thisCard = item.find(".plan-card");
        var allCards = item.parent().find(".plan-card");

        cardId = parseInt(thisCard[0].id);
        oldId = newId = parseInt(item.parents("ul:eq(0)").attr("id").replace('cell_', ''));
        dropIndex = allCards.index(thisCard);

        processedMove = allCards.length > 1 ? true : false; // Card was let go at the same place, nothing to do.

        // Send it all back to the Controller
        planner.currentDraggedCard = $(this);

        // Inform the server about the moved card
        planner.postDragData({ id: cardId, oldCellId: oldId, newCellId: newId, index: dropIndex, clone: false, shift: false });

        setTimeout("planner.completeUpdateCall()", 50);
    },
    
    allowEffects: function ()
    {
        $('#planner').addClass(planner.pageEffect);
    },

    disableEffects: function ()
    {
        $('#planner').removeClass(planner.pageEffect);
    },

    waitCursor: function ()
    {
        $('#planner-box').css({ cursor: 'wait' });
    },

    normalCursor: function ()
    {
        $('#planner-box').css({ cursor: 'default' });
    },

    post: function (method, callback, args)
    {
        planner.waitCursor();
        
        if (method != 'pagecell') gemini_ui.visualProgressStart('#planner');

        var controller;
        /*if (args.projectId != 'undefined' && args.projectId > 0) {
            controller = "project/" + args.projectId + '/board';
        }
        else {*/
            controller = 'board';
        //}
        
        var screenHeight = planner.availableHeight();
        var screenWidth = $(window).width();
        var selectedView = $('#SaveViewSelected').val();

        args = $.extend(args, { height: screenHeight, width: screenWidth, viewId: parseInt(selectedView) });
        var badcall = planner.updateError;

        gemini_ajax.postCall(controller, method, callback, badcall, args/*, null, args.projectId != 'undefined' && args.projectId > 0*/);

        return false;
    },
    
    // Any changes to config of the options 
    postData: function (jsonStr)
    {
        planner.animations = [];
        planner.post('update', planner.updatePlanner, { changes: jsonStr });
        return false;
    },

    // Paging a cell
    postPageData: function (cellId, pageUp)
    {
        planner.animations = [];
        planner.post('pagecell', planner.updateCell, { cell: cellId, pageUp: pageUp });
        return false;
    },

    // New item / dragged an item to the cell that is already there (clone / shift).
    postAddCardData: function (args)
    {
        planner.animations = [];
        planner.post('add', planner.updateCell, args);
        return false;
    },

    // Main dragging call.
    postDragData: function (args)
    {
        planner.animations = [];
        planner.post('resequence', planner.updateAllCells, args);
 
        $.publish('issue-update', [args]);
        return false;
    },

    // Delete an item
    postDelete: function (args)
    {
        planner.animations = [];
        planner.post('delete', planner.updateAllCells, args);
        
        $.publish('issue-delete', [args]);
        return false;
    },

    updateError: function ()
    {
        planner.allowEffects();
        planner.normalCursor();
        gemini_ui.visualProgressFinish('#planner');

        if(planner.currentDraggedCard != null) {
            planner.currentDraggedCard.sortable('cancel');
            planner.currentDraggedCard = null;
        }

        return false;
    },

    // Called when options are change as the whole planner needs repainting.
    updatePlanner: function (markup)
    {
        // Detach any existing scrollers before update
        var api = $('#planner-box').data('jsp');
        if (api != undefined) api.destroy();

        var plannerBox = $('#planner-box');
        plannerBox.html(markup);

        planner.bindPagingEvents('#planner');

        // For performance reasons we need to "finish" the planner setup later.
        setTimeout("planner.completeUpdateCall()", 50);

        planner.contextMenu('.plan-card');
        planner.addToSwimlane();
        
        gemini_ui.visualProgressFinish('#planner');

        return false;
    },

    updateAllCells: function (markup)
    {
        if (markup == 'error') {
            planner.updateError();
        }
        else if(markup.indexOf('ERROR-PLANNER: ') != -1) {
            gemini_popup.toast(markup.replace('ERROR-PLANNER: ',''), true);
            planner.updateError();
        }
        else {

            var values = markup.split('\t');

            var count = values.length;
            for (i = count; i--;) {
                var contents = values[i];
                planner.updateCellMarkup(contents);
            }
            setTimeout(function () { planner.runAnimations(); }, 25);

            planner.bindAllCellMenusAndEvents();
            planner.addArrowDownEvents();
            planner.normalCursor();
            gemini_ui.visualProgressFinish('#planner');
            planner.showInfoTip();
        }

        if(gemini_appnav.pageCard.CardData.HighlightChanges) {
            planner.highlight(gemini_appnav.pageCard.CardData.Badges);
        }
    },

    updateCell: function (markup)
    {
        planner.updateCellMarkup(markup);
        setTimeout(function () { planner.runAnimations(); }, 25);

        planner.bindAllCellMenusAndEvents();
        planner.normalCursor();
        gemini_ui.visualProgressFinish('#planner');
        planner.showInfoTip();

        if(gemini_appnav.pageCard.CardData.HighlightChanges) {
            planner.highlight(gemini_appnav.pageCard.CardData.Badges);
        }
    },

    updateCellMarkup: function (markup)
    {
        // We rely on the id being the 1st attribute in the markup and it is in single quotes.
        var m = markup.match(/'(.*?)'/);
        // Get the id by removing the quotes.
        var id = '#' + m[0].replace("'", "").replace("'", "");
        // invesigate doing $(markup).attr('id') instead.

        // find the cell to be replaced
        var swimlane = $(id, '#planner');
        swimlane.replaceWith(markup);

        gemini_ui.visualProgressFinish('#planner');

        planner.animations.push(id);

        return false;
    },

    completeUpdateCall: function ()
    {
        // Equal height, width for each cell so it fits nicely on the page especiially when there are not enough cards to fill the page height or enough axis' to fill the width / height.
        planner.adjustAllSwimLaneHeights();
        planner.addTriggers();
        planner.adjustScrollBars();

        planner.showInfoTip();
        planner.addArrowDownEvents();

        // Only when NOT read-Only
        /*if (!planner.readOnly)*/ planner.enableCardDrag();

        planner.allowEffects();
        planner.normalCursor();
        gemini_ui.visualProgressFinish('#planner');
        if(gemini_appnav.pageCard.CardData.HighlightChanges) {
            planner.highlight(gemini_appnav.pageCard.CardData.Badges);
        }
        return false;
    },

    runAnimations: function ()
    {
        planner.allowEffects();

        var animations = planner.animations;
        var count = animations.length;

        for (var i = count; i--; )
        {
            // remove the 'future' class on all cards (child li items) which will cause the animation because we change a css property.
            var id = animations[i];
            $(id).find("li").removeClass('future');
        }
    },

    // Re-bind context menu to a cell as it has been repainted.
    bindAllCellMenusAndEvents: function ()
    {
        planner.adjustAllSwimLaneHeights();

        var animations = planner.animations;
        var count = animations.length;

        for (i = count; i--; )
        {
            // get the ID of teh cell
            var id = animations[i];

            // re-attach the context menus this cell
            planner.contextMenu(id + ' .plan-card');

            // re-attach the paging binding to this cell
            planner.bindPagingEvents(id);
        }

        // Only when NOT read-Only
        /*if (!planner.readOnly)
        {*/
            planner.enableCardDrag();

            //re-attach the context menu to just the header cell
            planner.addToSwimlane();
        //}
    },

    // New card, chnage the title from "New" or edit.
    bindCardTitleChange: function ()
    {
        var card = $("#planner-context-popup-new-card");
        gemini_commons.inputKeyHandler("#planner-context-popup-new-card > .card-title",
            function ()
            {
                card.hide();

                // get the LI (not the div that was clicked on)
                var li = planner.selectedContextCard.hasClass("plan-card") ? planner.selectedContextCard.parent() : planner.selectedContextCard;
                var ul = li.parent();

                var projectId = planner.selectedContextCard.attr('data-project-id');
                var newTitle = $(".card-title", card).val();
                var cellId = parseInt(ul.attr("id").replace('cell_', ''));

                // insert it into the Ul with the appropate LI !!!!
                var container = ul.find("li");

                // will add this below the card that was clicked on because the totals is a LI
                var dropIndex = parseInt(container.index(li));

                planner.postAddCardData({ projectId:projectId, cell: cellId, title: newTitle, index: dropIndex });
            },
            function ()
            {
                card.hide();
            }
        );
    },

    bindPagingEvents: function (selector)
    {
        $(selector).off('click', 'div.paging-up');
        $(selector).on('click', 'div.paging-up', function ()
        {
            var swimlane = $(this).parent().parent();
            var cell = parseInt(swimlane[0].id.replace('cell_', ''));
            planner.postPageData(cell, false);  // Next in list
            return false;
        });
        $(selector).off('click', 'div.paging-down');
        $(selector).on('click', 'div.paging-down', function ()
        {
            var swimlane = $(this).parent().parent();
            var cell = parseInt(swimlane[0].id.replace('cell_', ''));
            planner.postPageData(cell, true); // previous in list
            return false;
        });
    },

    // This will make all the columns in a row the same height and distribiute them equally vertically if there is space.
    adjustAllSwimLaneHeights: function ()
    {
        // Find each axis-label
        var rows = $('div.axis-divider', '#planner');
        
        // array to hold all row heights
        var heights = [];
        var total = 0;

        rows.each(function ()
        {
            var axisMax = 0;
            var axis = $(this);

            // For each column in the row find the maximum height of heighest column.
            axis.find("> ul").each(function ()
            {
                var cardHeight, sum = 0;
                var col = $(this);

                // Get the height of the ul by summing up the height of the cards within it.
                col.find('> li').each(function ()
                {
                    cardHeight = $(this).height() + 9;  // there is padding-bottom on each <li>
                    sum += cardHeight;
                });

                sum += 20;                               // Pager => border-top 1px, margin-top: 9px and same on the bottom too !!!

                // add on a single cards worth of space at the end of the stack
                sum += Math.floor(cardHeight);           // remove padding applied to last card

                if (sum > axisMax)
                    axisMax = sum;
            });

            heights.push(axisMax - 20);                  // total height - without any padding for last card
            total += axisMax;
        });

        // calculate the average adjustment required in each row
        var adjust = 0, screenHeight = planner.availableHeight();
        if (total < screenHeight)
        {
            adjust = Math.floor((screenHeight - total) / heights.length) - heights.length * 18;  // there are 9 px at the top and bottom of each row
            if (adjust < 0) adjust = 0;
        }

        // go through the rows applying the heights and ajustment
        var row = 0;
        rows.each(function ()
        {
            var axis = $(this);
            axis.find("> ul").each(function ()
            {
                $(this).css("min-height", heights[row] + adjust);
            });
            row++;
        });
    },

    adjustScrollBars: function ()
    {
        var screenHeight = planner.availableHeight();
        var screenWidth = $('#page-content-zone .layout').width(); //$(window).width();

        $('#planner-box').css('height', screenHeight);
        
        //last number was 25 HSK changed to 92 during 5.2 UX work
        $('#planner-box').css('width', screenWidth - 2 /*- 92 - 400 + 10*/);

        // add a custom scrollbar on the planner-box and vertical scroll
        $('#planner-box').jScrollPane({ verticalDragMinHeight: 50, horizontalDragMinWidth: 50, skipDivWrap: false });

        planner.jscrollPaneApi = $('#planner-box').data('jsp');

        return false;
    },

    addSortDirections: function ()
    {
        planner.toggleSortArrows('#Axis1Sort');
        planner.toggleSortArrows('#Axis2Sort');
        planner.toggleSortArrows('#OrderBySort');
        planner.toggleSortArrows('#ThenBySort');
        return false;
    },

    toggleSortArrows: function (selector)
    {
        var element = $(selector, '#planner-control-box');

        if (planner.isDescending(selector))
        {
            element.removeClass('fonticon-ahead-arrow').addClass('fonticon-behind-arrow');
        }
        else
        {
            element.removeClass('fonticon-behind-arrow').addClass('fonticon-ahead-arrow');
        }
    },

    isDescending: function (selector)
    {
        var element = $(selector, '#planner-control-box');
        return element.hasClass('desc');
    },

    // constrain to #planner-control-box where possible
    addTriggers: function ()
    {
        var axis1Selected = $('#Axis1Selected option:selected').val();
        var axis2Selected = $('#Axis2Selected option:selected').val();

        // Make sure all axis2 values can be seen
        $("#Axis2Selected option").show();
        if (axis1Selected == axis2Selected)
        {
            // If same value thing is selected Axis12 -> reset this to the 'Nothing' option
            $('#Axis2Selected option:first-child', '#planner-control-box').prop("selected", "selected");
            axis2Selected = '';

            gemini_ui.chosenUpdate($("#Axis2Selected")); // Chosen needs updating too !!!
        }

        // Hide the axis option in dropdown list two that has already been selected in list one
        // Before chosen $("#Axis2Selected option[value='" + axis1Selected + "']").hide();
        var index = $("#Axis1Selected option[value=" + axis1Selected + "]").index();  
        $("li[id^=Axis2Selected_chzn_o_]", ".chosen-results").show();
        $("li[id^=Axis2Selected_chzn_o_"+(index+1)+"]", ".chosen-results").hide();  // need to allow for 'Nothing' entry too !!!

        //'DateRangeSelected' - Disable by default and only enable for dates.
        $('#DateRangeSelected', '#planner-control-box').attr("disabled", "disabled");
        $('#lblDateRangeSelected', '#planner-control-box').attr("disabled", "disabled");
        if (axis1Selected == 'DueDate' || axis1Selected == 'StartDate' || axis2Selected == 'DueDate' || axis2Selected == 'StartDate')
        {
            $('#DateRangeSelected', '#planner-control-box').removeAttr("disabled");
            $('#lblDateRangeSelected', '#planner-control-box').removeAttr("disabled");
        }

        // Listen to the axis 2 change event, if the value is blank ('') then disable the Axis2Sort element (arrow)
        $('#Axis2Selected', '#planner-control-box').TriggerContol({ target: '#Axis2Sort', value: '', enable: false });

        var orderBySelected = $('#OrderBySelected option:selected').val();
        var thenBySelected = $('#ThenBySelected option:selected').val();

        // You can only have Thenby if OrderBy has beeen selected
        $('#OrderBySelected', '#planner-control-box').TriggerContol({ target: '#ThenBySelected', label: '#lblThenBySelected', value: '', enable: false });
 
        gemini_ui.chosenUpdate($("#ThenBySelected")); // Chosen needs updating too !!!
        $("#ThenBySelected option").show();
        if (orderBySelected == thenBySelected)
        {
            // If same value thing is selected Axis12 -> reset this to the 'Not Ordered' option
            $('#ThenBySelected option:first-child', '#planner-control-box').prop("selected", "selected");
            thenBySelected = '';

            gemini_ui.chosenUpdate($("#ThenBySelected")); // Chosen needs updating too !!!
        }

        // otherwise hide the axis option in dropdown list two that has already been selected in list one
        //$("#ThenBySelected option[value='" + orderBySelected + "']").hide();
        index = $("#OrderBySelected option[value=" + orderBySelected + "]").index();
        $("li[id^=ThenBySelected_chzn_o_]", ".chosen-results").show();
        $("li[id^=ThenBySelected_chzn_o_" + index + "]", ".chosen-results").hide();  // no need to allow for 'Not Ordered' as both have this entry 
        
        // Enable or disable the sorting options of the various 'ThenBy's based on dropdown values
        $('#Axis2Selected', '#planner-control-box').TriggerContol({ target: '#Axis2Sort', value: '', enable: false });
        $('#ThenBySelected', '#planner-control-box').TriggerContol({ target: '#ThenBySort', value: '', enable: false });

        // Swap is only enabled if a Second axis is selected
        $('#Axis2Selected', '#planner-control-box').TriggerContol({ target: '#AxisFlipped', value: '', enable: false });

        // If maximum cards per planner is selected disable lane limiting
        var limit = $('#AutoLimit', '#planner-control-box').val();
        if (limit > 0)
        {
            $('#SwimLaneLimits', '#planner-control-box').val(0);
        }

        $('#AutoLimit', '#planner-control-box').TriggerContol({ target: '#SwimLaneLimits', value: '0', enable: true });

        // TODO - Add Triggers for TottingMode whenAutoLimit has value != 0 or LaneLimit has value != 0 (eg. how to sum up time, what value to increment in)
        // depends on both values - so there is a multi-trigger required here - to make that work nicely
    },

    availableHeight: function ()
    {
        // Fix the width and height of the plan area
        var screenHeight = $(window).height();
        var header = $("header").height();
        var controls = $("#planner-control-box").height();
        var filter = $("#filter").height();
        var footer = $("footer").height();

        var subtract = header + controls + filter + footer;

        // last number below was 100 but HSK changed to 80 during new 5.2 UI work
        return Math.floor(screenHeight - subtract - 80);   // 80 deals with padding that exists between elements
    },

    enableCardDrag: function ()
    {
        var settings = this.settings;
        var processedMove = false;
        var cloneCard = false;
        var shiftCard = false;
        var thisCard, newCellId, oldCellId, cardId, dropIndex;

        var $sortableItems = (function ()
        {
            return $('> li', settings.container);
        })();

        $('ul', '#planner').sortable(
        {
            connectWith: $(settings.container),
            handle: settings.itemSelector,
            placeholder: settings.placeholder,
            forcePlaceholderSize: true,
            revert: 'invalid',
            revertDuration: 150,
            opacity: 0.7,
            cancel: ".fixed",         // prevent drag of paging controls LI
            containment: '#planner',
            scroll: true,
            change: function (e, ui)
            {
                // When i start to drag this fires!

                // Make sure they cannot drag the item above the cell's header (which is an li).
                var insertindex = $(ui.placeholder).index();
                var parent = $(ui.placeholder).parent();
                var fixed = $(".fixed", parent);

                if (insertindex == 0)
                {
                    fixed.prev().insertAfter(fixed);   // move it up by one position
                }

                // Show the tooltip when dragging.
                planner.showLaneName(e, ui.placeholder);
            },

            // card has moved between cells (just let go of the mouse) eg pre drop. Will not fire intracell
            receive: function (e, ui)
            {
                var item = ui.item;         // the LI that is the draggd card
                var sender = ui.sender;     // The UL that the dragged card came from 

                cloneCard = e.altKey || e.ctrlKey;      // CTRL or ALT => clone card if its there are multiple options
                shiftCard = e.shiftKey;                 // SHIFT =. Shift card

                var thisCard = item.find(settings.itemSelector);
                var allCellCards = item.parent().find(settings.itemSelector);

                cardId = parseInt(thisCard[0].id);
                newId = parseInt(item.context.parentElement.id.replace('cell_', ''));
                oldId = parseInt(sender.context.id.replace('cell_', ''));
                dropIndex = allCellCards.index(thisCard);

                processedMove = true;
            },

            // card has been picked up
            start: function (e, ui)
            {
                var plannerWidth = $('#planner-box').width();
                var plannerHeight = $('#planner-box').height();
                var cardWidth = $('#planner .plan-card:eq(0)').width();
                var cardHeight = $('#planner .plan-card:eq(0)').height();
                var plannerPos = $('#planner-box').position();

                $('#planner').bind('mousemove', function(event) {
                    if ((event.pageX - cardWidth) < 0)  planner.jscrollPaneApi.scrollByX(-300, true) 

                    if ((event.pageX + cardWidth) >= plannerWidth)  planner.jscrollPaneApi.scrollByX(300, true) 

                    if ((event.pageY - cardHeight) < plannerPos.top)  planner.jscrollPaneApi.scrollByY(-300, true) 

                    if (event.pageY >= plannerHeight)  planner.jscrollPaneApi.scrollByY(300, true) 
                });

                // remove the effects as soon as dragging starts
                planner.disableEffects();
                $('body').addClass('dragging');         // used by hover Intent
                $(ui.helper).addClass('dragging');
                updates = {};
                processedMove = false;
            },

            // card has finished moving completely, will fire after any card pickup and drop (once)
            stop: function (e, ui)
            {
                $('#planner').unbind('mousemove');

                var item = ui.item;

                $('body').removeClass('dragging');      // used by hover Intent
                $(ui.item).css({ width: '' }).removeClass('dragging');

                if (!processedMove)
                {
                    // This must be an intra cell drag as receive would have been called otherwise.
                    cloneCard = e.altKey || e.ctrlKey;      // CTRL or ALT => clone card if its there are multiple options
                    shiftCard = e.shiftKey;                 // SHIFT =. Shift card

                    // not processed, so it did not move between cells 
                    // so the card has only moved inside the same cell 
                    var thisCard = item.find(settings.itemSelector);
                    var allCards = item.parent().find(settings.itemSelector);

                    cardId = parseInt(thisCard[0].id);
                    oldId = newId = parseInt(item.context.parentElement.id.replace('cell_', ''));
                    dropIndex = allCards.index(thisCard);

                    processedMove = allCards.length > 1 ? true : false; // Card was let go at the same place, nothing to do.
                }

                // Send it all back to the Controller
                if (processedMove == true)
                {
                    planner.currentDraggedCard = $(this);
                    // Inform the server about the moved card
                    planner.postDragData({ id: cardId, oldCellId: oldId, newCellId: newId, index: dropIndex, clone: cloneCard, shift: shiftCard });
                }

                var tip = $('#dropTip', 'body');
                tip.hide("fast");
            }
        });

        return false;
    },

    // Show the tool tip for the cell.
    showLaneName: function (e, elem)
    {
        var tip = $('#dropTip', 'body');
        var tipText = tip.find('#dropTipText');

        var axis = elem.parent().parent();
        var axisLabel = axis.find('.axis-label');
        var header = $('.axis-label-header', elem.parent());
        var label = header.find('.plan-header');

        var displayText = label.text();
        if (axisLabel.text().length > 0)
        {
            displayText = displayText + ' (' + axisLabel.text() + ')';
        }

        tipText.text(displayText);
        $(tip).fadeIn('fast');

        $(tip).position({
            "of": elem,
            "my": "top",
            "at": "top",
            "offset": "8px 0",
            "collision": "none"
        });

        return false;
    },

    filterChanged: function() 
    {
        gemini_ajax.postCall('board', 'options', function (response)
        {
            $('#page-options-box').html(response);
            gemini_ui.chosen('#page-options-box select:not(.no-chosen)', null);
            planner.initOptions();
            $("#page-options-box .options").click(function (e) { e.stopPropagation(); });
            planner.addSortDirections();
            planner.saveData();
        }, null, { changes: planner.scrapeData() });
        
    },

    scrapeData: function()
    {
        var i, controls, count, items = 0, terms = [];

        controls = $('select', '#planner-control-box');
        count = controls.length;

        for (i = count; i--;) {
            _this = controls[i];
            terms[items++] = _this.id + ':\'' + _this.value + '\'';
        }

        controls = $('input', '#planner-control-box');
        count = controls.length;

        for (i = count; i--;) {
            _this = controls[i];
            if (_this.id != "dummy" && _this.id.length != 0) {
                terms[items++] = _this.id + ':\'' + _this.value + '\'';
            }
        }

        var zoom = $('#PlannerLevel', '#planner-control-box').attr('class');
        var pos = zoom.indexOf('level-');
        if (pos != -1) {
            var digits = zoom.substring(pos + 6, pos + 7);
            var level = parseInt(digits);

            level = (level < 0) ? 0 : (level > 4) ? 4 : level;
            terms[items++] = 'PlannerLevel:' + '\'' + level + '\'';
        }

        terms[items++] = 'Axis1Sort:' + (planner.isDescending('#Axis1Sort') ? '\'desc\'' : '\'asc\'');
        terms[items++] = 'Axis2Sort:' + (planner.isDescending('#Axis2Sort') ? '\'desc\'' : '\'asc\'');
        terms[items++] = 'OrderBySort:' + (planner.isDescending('#OrderBySort') ? '\'desc\'' : '\'asc\'');
        terms[items++] = 'ThenbySort:' + (planner.isDescending('#ThenBySort') ? '\'desc\'' : '\'asc\'');

        return '{' + terms.join(',') + '}';
    },

    // Scrape option from the control box and json it to the server.
    saveData: function ()
    {
        

        planner.postData(planner.scrapeData());
        return false;
    },
    
    addArrowDownEvents: function () {

        $("#planner .plan-card").unbind("mouseenter").unbind("mouseleave");
        $("#planner .plan-card").removeProp('hoverIntent_t');
        $("#planner .plan-card").removeProp('hoverIntent_s');
        $("#planner .card-options-icon span").unbind('click');

        $("#planner .plan-card").hoverIntent({
            interval: 350,
            over: function (e) {
                // used by hover Intent
                $(".card-options-icon", this).show();
            },
            out: function (e) {
                $(".card-options-icon", this).hide();
            }
        });

        $("#planner .card-options-icon span").click(function (e) {
            e.preventDefault();
            e.button = 2;
            $(this).closest('.plan-card').trigger("mousedown", e).trigger("mouseup", [e]);
        });
    },
    
    // When hovering over the headers of rows / columns
    showInfoTip: function ()
    {
        $(".plan-header, .axis-label", "#planner").hoverIntent({ interval: 350,
            over: function (e)
            {
                // used by hover Intent
                var dragging = $('body').hasClass('dragging');

                if (!dragging)
                {
                    var tip = $(this).parent().find(".info-tip:eq(0)");

                    $(tip).fadeIn('fast');

                    $(tip).position({
                        "of": $(this),
                        "my": "left top",
                        "at": "left bottom",
                        "offset": "8px 0",
                        "collision": "none"
                    });
                }
            },
            out: function (e)
            {
                var tip = $(this).parent().find(".info-tip");

                $(tip).hide();
            }
        });
    },

    /* Right click menu */
    contextMenu: function (selector) {
        $(selector, '#planner').contextMenu({ menu: 'planner-context-menu' },
            function (action, el, pos) {
                var elem = planner.selectedContextCard = $(el);
                var cardId = planner.selectedContextCard.attr("id");
                var projectId = planner.selectedContextCard.attr("data-project-id");

                if (action == "view" && !$('#planner-context-menu a[href="#view"]').parent().hasClass('disabled')) {
                    gemini_commons.openIssueUrlInTabProj(cardId, projectId);
                    return;
                }

                if (action == "new") {
                    planner.addNewItem(planner.selectedContextCard);
                    /*var newCard = $("#planner-context-popup-new-card");
                    newCard.width(200);
                    newCard.height(110);
                    newCard.show();

                    var title = $(".card-title", newCard);

                    title.width(newCard.width() - 2);
                    title.height(newCard.height() - 2);
                    title.focus().select();
                    title.val("");

                    newCard.position({
                        "my": "center top",
                        "at": "center middle",
                        "of": elem,
                        "offset": "0 10",
                        "collision": "none"
                    });
                    gemini_keyboard.bindEscape('#planner-context-popup-new-card', planner.escapeDropdowns);*/
                }
                else if (action == "edit" && !$('#planner-context-menu a[href="#edit"]').parent().hasClass('disabled')) {
                    $(el).parent().data("issue-id", cardId);
                    gemini_edit.initEditing(el);
                }
                else if (action == "comment" && !$('#planner-context-menu a[href="#comment"]').parent().hasClass('disabled')) {
                    $("#cs-popup-center-content").css("width", "725px");
                    $("#cs-popup-center-content").css("height", "475px");
                    gemini_popup.centerPopup("item/editcommenteditor", "popup?issueid=" + cardId);
                }
                else if (action == "delete" && !$('#planner-context-menu a[href="#delete"]').parent().hasClass('disabled')) {
                    gemini_commons.translateMessage("[[Delete]] " + elem.find(".title").text() + "?", ['Delete'], function (message) {
                        gemini_popup.modalConfirm(message, null,
                            function () {
                                planner.postDelete({ issueId: cardId });
                            });
                    });
                }
                else if (action == "follow") {
                    gemini_ajax.call("item", "addwatcher?issueid=" + cardId + "&userid=0");
                }
                else if (action == "pin") {
                    gemini_items.pinItem(cardId, false);
                }
                else if (action == "time" && !$('#item-grid-context-menu a[href="#time"]').parent().hasClass('disabled')) {
                    $("#cs-popup-center-content").css("width", "500px");
                    $("#cs-popup-center-content").css("height", "350px");
                    gemini_popup.centerPopup("item/edittimeentry", "popup?issueid=" + cardId, { timeid: 0 });
                }
            },
            function (before) {
                gemini_ajax.call('', "projectpermissions?issueid=" + before.attr('id'), function (response) {
                    if (response.success) {
                        if (response.Result.Data.canview)
                            $('#planner-context-menu').enableContextMenuItems('#view');
                        else
                            $('#planner-context-menu').disableContextMenuItems('#view');

                        if (response.Result.Data.canedit)
                            $('#planner-context-menu').enableContextMenuItems('#edit');
                        else
                            $('#planner-context-menu').disableContextMenuItems('#edit');

                        if (response.Result.Data.candelete)
                            $('#planner-context-menu').enableContextMenuItems('#delete');
                        else
                            $('#planner-context-menu').disableContextMenuItems('#delete');

                        if (response.Result.Data.cancomment)
                            $('#planner-context-menu').enableContextMenuItems('#comment');
                        else
                            $('#planner-context-menu').disableContextMenuItems('#comment');

                        if (response.Result.Data.canaddtime)
                            $('#planner-context-menu').enableContextMenuItems('#time');
                        else
                            $('#planner-context-menu').disableContextMenuItems('#time');
                    }
                }, null, null, null, null, false);
            }
        );

    },
    
    /* Plus sign == create item */
    addToSwimlane: function ()
    {
        /*if (!planner.readOnly)
        {*/
            $(".add-to-swimlane", ".axis-label-header").click(function (e)
            {
                planner.addNewItem(this);
                /*planner.selectedContextCard = $(this).parent();

                var newCard = $("#planner-context-popup-new-card");
                newCard.width(200);
                newCard.height(110);
                newCard.show();

                var title = $(".card-title", newCard);

                title.width(newCard.width() - 2);
                title.height(newCard.height() - 2);
                title.focus().select();
                title.val("");

                newCard.position({
                    "my": "center top",
                    "at": "center middle",
                    "of": $(this).closest(".axis-label-header"),
                    "offset": "0 10",
                    "collision": "none"
                });*/
            });
        /*}
        else
        {
            $(".add-to-swimlane", ".axis-label-header").css('visibility', 'hidden');
        }*/
    },

    addNewItem: function(_that)
    {
        gemini_add.hidePlan = true;
        gemini_add.hideProject = true;
        var li = $(_that).parent();
        var ul = li.parent();
        var cellId = parseInt(ul.attr("id").replace('cell_', ''));
        var container = ul.find("li");
        var dropIndex = parseInt(container.index(li));
        gemini_ajax.postCall('board', 'celldetails', function (response) {
            gemini_add.newItemRenderedCallback = function () {
                var scroll = $(window).scrollTop();
                var popup = $("#cs-popup-add");
                if (scroll > popup.position().top) {
                    popup.css("top", scroll);
                }
            };
            gemini_add.newItemCreatedCallback = function (id) {
                planner.postAddCardData({ projectId: 0, cell: cellId, issueid: id, index: dropIndex });
                //planner.post('refresh', planner.updateCell, { changes: planner.scrapeData(), cell: cellId });
            };

            gemini_add.postData = $.parseJSON(response);

            gemini_commons.showAddItem();
        }, null, { changes: planner.scrapeData(), cellId: cellId, filter: $('#filter-form').serialize() });
    }
};
