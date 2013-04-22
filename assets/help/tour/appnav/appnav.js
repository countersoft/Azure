if (!window.lib) { window.lib = {}; }

var p; // shortcut to reference prototypes

// stage content:
(lib.Tour = function() {
	this.initialize();

	// cursor
	this.instance = new lib.CursorIdle();
	this.instance.setTransform(132,243.3,1,1,0,0,0,6,9.5);

	// pointer
	this.instance_1 = new lib.PointerIdle();
	this.instance_1.setTransform(164.4,243.3,1,1,0,0,0,8.5,11);

	// card
	this.instance_2 = new lib.CardIdle();
	this.instance_2.setTransform(454.5,43.5,1,1,0,0,0,60,22.5);

	// drag
	this.instance_3 = new lib.DragIdle();
	this.instance_3.setTransform(442,117.4,1,1,0,0,0,46.5,18.5);

	// bg
	this.instance_4 = new lib.bg();

	this.addChild(this.instance_4,this.instance_3,this.instance_2,this.instance_1,this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,1248,895);


// symbols:
(lib.CursorIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Idle
	this.instance = new lib.Cursor();
	this.instance.setTransform(6,9.5,1,1,0,0,0,6,9.5);

	this.timeline.addTween(Tween.get(this.instance).to({x:226.5,y:-78.7},16).to({x:230.6,y:-80.3,alpha:0},2).to({x:238.8,y:-83.6},2).to({x:300,y:-108.2},4).wait(126));

}).prototype = p = new MovieClip();
p.nominalBounds = new Rectangle(0,0,12,19);


(lib.Cursor = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib.pointercursor();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,12,19);


(lib.pointercursor = function() {
	this.initialize(images.pointercursor);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,12,19);


(lib.PointerIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Idle
	this.instance = new lib.Pointer();
	this.instance.setTransform(-23.3,11,1,1,0,0,0,8.5,11);
	this.instance.alpha = 0;

	this.timeline.addTween(Tween.get(this.instance).to({x:228.1,y:-86},19).to({x:240.9,y:-91.1,alpha:1},1).to({x:253.1,y:-95.9},2).to({x:269.4,y:-102.4},2).to({x:277.5,y:-105.7},1).to({y:-104.7},14).to({y:-187.7},15).wait(96));

}).prototype = p = new MovieClip();
p.nominalBounds = new Rectangle(-31.9,0,17,22);


(lib.Pointer = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib.linkcursor();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,17,22);


(lib.linkcursor = function() {
	this.initialize(images.linkcursor);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,17,22);


(lib.CardIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Idle
	this.instance = new lib.Card();
	this.instance.setTransform(60,22.5,1,1,0,0,0,60,22.5);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(54).to({_off:false},0).to({y:27.5},5).to({y:17.6},5).to({y:27.5},5).to({y:22.5},5).wait(76));

}).prototype = p = new MovieClip();


(lib.Card = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib.card();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,120,45);


(lib.card = function() {
	this.initialize(images.card);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,120,45);


(lib.DragIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Idle
	this.instance = new lib.Drag();
	this.instance.setTransform(46.5,18.5,1,1,0,0,0,46.5,18.5);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(39).to({_off:false},0).to({y:-41.2},12).to({y:-56.2,alpha:0},3).wait(96));

}).prototype = p = new MovieClip();


(lib.Drag = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib.drag();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,93,37);


(lib.drag = function() {
	this.initialize(images.drag);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,93,37);


(lib.bg = function() {
	this.initialize(images.bg);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,1248,895);