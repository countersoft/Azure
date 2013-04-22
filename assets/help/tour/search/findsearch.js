if (!window.lib) { window.lib = {}; }

var p; // shortcut to reference prototypes

// stage content:
(lib.findsearch = function() {
	this.initialize();

	// cursor
	this.instance = new lib.cursorIdle();
	this.instance.setTransform(223,238.3,1,1,0,0,0,6,9.5);

	// 4
	this.instance_1 = new lib._4();
	this.instance_1.setTransform(275,200,1,1,0,0,0,275,200);

	// 3
	this.instance_2 = new lib._3();
	this.instance_2.setTransform(275,200,1,1,0,0,0,275,200);

	// 2
	this.instance_3 = new lib._2();
	this.instance_3.setTransform(275,200,1,1,0,0,0,275,200);

	// 1
	this.instance_4 = new lib._1();

	this.addChild(this.instance_4,this.instance_3,this.instance_2,this.instance_1,this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


// symbols:
(lib.cursorIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.cursor();
	this.instance.setTransform(6,9.5,1,1,0,0,0,6,9.5);

	this.timeline.addTween(Tween.get(this.instance).wait(19).to({x:228,y:-157.2},25).wait(176));

}).prototype = p = new MovieClip();
p.nominalBounds = new Rectangle(0,0,12,19);


(lib.cursor = function() {
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


(lib._4 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._4_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(134).to({_off:false},0).wait(86));

}).prototype = p = new MovieClip();


(lib._4_1 = function() {
	this.initialize(images._4_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._3 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._3_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(94).to({_off:false},0).wait(126));

}).prototype = p = new MovieClip();


(lib._3_1 = function() {
	this.initialize(images._3_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._2 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._2_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(59).to({_off:false},0).wait(161));

}).prototype = p = new MovieClip();


(lib._2_1 = function() {
	this.initialize(images._2_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._1 = function() {
	this.initialize(images._1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);