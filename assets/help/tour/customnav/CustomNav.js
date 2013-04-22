if (!window.lib) { window.lib = {}; }

var p; // shortcut to reference prototypes

// stage content:
(lib.CustomNav = function() {
	this.initialize();

	// cursor
	this.instance = new lib.cursorIdle();
	this.instance.setTransform(200.4,77.4,1,1,0,0,0,8.5,11);

	// drag
	this.instance_1 = new lib.cardIdle();
	this.instance_1.setTransform(455.1,42.5,1,1,0,0,0,61,22.5);

	// 7
	this.instance_2 = new lib._7Idle();
	this.instance_2.setTransform(275,200,1,1,0,0,0,275,200);

	// empty
	this.instance_3 = new lib._6Idle();
	this.instance_3.setTransform(275,200,1,1,0,0,0,275,200);

	// 5
	this.instance_4 = new lib._5Idle();
	this.instance_4.setTransform(275,200,1,1,0,0,0,275,200);

	// 4
	this.instance_5 = new lib._4Idle();
	this.instance_5.setTransform(275,200,1,1,0,0,0,275,200);

	// 3
	this.instance_6 = new lib._3Idle();
	this.instance_6.setTransform(275,200,1,1,0,0,0,275,200);

	// 2
	this.instance_7 = new lib._2Idle();
	this.instance_7.setTransform(275,200,1,1,0,0,0,275,200);

	// 1
	this.instance_8 = new lib._1();

	this.addChild(this.instance_8,this.instance_7,this.instance_6,this.instance_5,this.instance_4,this.instance_3,this.instance_2,this.instance_1,this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


// symbols:
(lib.cursorIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.cursor();
	this.instance.setTransform(8.5,11,1,1,0,0,0,8.5,11);

	this.timeline.addTween(Tween.get(this.instance).to({x:149.5,y:-15.7},19).wait(50).to({x:279.5},20).wait(40).to({x:5.6},30).wait(101));

}).prototype = p = new MovieClip();
p.nominalBounds = new Rectangle(0,0,17,22);


(lib.cursor = function() {
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


(lib.cardIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.card();
	this.instance.setTransform(61,22.5,1,1,0,0,0,61,22.5);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(129).to({_off:false},0).to({x:-201.7},30).to({y:25.5},6).to({y:19.6},6).to({y:25.5},6).to({y:22.5},6).wait(77));

}).prototype = p = new MovieClip();


(lib.card = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib.card_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,122,45);


(lib.card_1 = function() {
	this.initialize(images.card_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,122,45);


(lib._7Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._7();
	this.instance.setTransform(275,200,1,1,0,0,0,275,200);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(159).to({_off:false},0).wait(101));

}).prototype = p = new MovieClip();


(lib._7 = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib._7_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._7_1 = function() {
	this.initialize(images._7_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._6Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._6();
	this.instance.setTransform(275,200,1,1,0,0,0,275,200);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(129).to({_off:false},0).wait(131));

}).prototype = p = new MovieClip();


(lib._6 = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib._6_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._6_1 = function() {
	this.initialize(images._6_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._5Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._5();
	this.instance.setTransform(275,200,1,1,0,0,0,275,200);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(99).to({_off:false},0).wait(161));

}).prototype = p = new MovieClip();


(lib._5 = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib._5_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._5_1 = function() {
	this.initialize(images._5_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._4Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._4();
	this.instance.setTransform(275,200,1,1,0,0,0,275,200);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(89).to({_off:false},0).wait(171));

}).prototype = p = new MovieClip();


(lib._4 = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib._4_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._4_1 = function() {
	this.initialize(images._4_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._3Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._3();
	this.instance.setTransform(275,200,1,1,0,0,0,275,200);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(29).to({_off:false},0).wait(231));

}).prototype = p = new MovieClip();


(lib._3 = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib._3_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._3_1 = function() {
	this.initialize(images._3_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._2Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._2();
	this.instance.setTransform(275,200,1,1,0,0,0,275,200);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(19).to({_off:false},0).wait(241));

}).prototype = p = new MovieClip();


(lib._2 = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib._2_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._2_1 = function() {
	this.initialize(images._2_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._1 = function() {
	this.initialize(images._1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);