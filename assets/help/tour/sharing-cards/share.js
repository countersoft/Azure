if (!window.lib) { window.lib = {}; }

var p; // shortcut to reference prototypes

// stage content:
(lib.share = function() {
	this.initialize();

	// cursor
	this.instance = new lib.cursorIdle();
	this.instance.setTransform(317,235.3,1,1,0,0,0,6,9.5);

	// 10
	this.instance_1 = new lib.cardIdle();
	this.instance_1.setTransform(379.4,171,1,1,0,0,0,61,18);

	// 9
	this.instance_2 = new lib._9Idle();
	this.instance_2.setTransform(275,200,1,1,0,0,0,275,200);

	// 8
	this.instance_3 = new lib._8_1();
	this.instance_3.setTransform(275,200,1,1,0,0,0,275,200);

	// 7
	this.instance_4 = new lib._7Idle();
	this.instance_4.setTransform(275,200,1,1,0,0,0,275,200);

	// 6
	this.instance_5 = new lib._6Idle();
	this.instance_5.setTransform(275,200,1,1,0,0,0,275,200);

	// 5
	this.instance_6 = new lib._5Idle();
	this.instance_6.setTransform(275,200,1,1,0,0,0,275,200);

	// 4
	this.instance_7 = new lib._4Idle();
	this.instance_7.setTransform(275,200,1,1,0,0,0,275,200);

	// 3
	this.instance_8 = new lib._3Idle();
	this.instance_8.setTransform(275,200,1,1,0,0,0,275,200);

	// 2
	this.instance_9 = new lib._2Idle();
	this.instance_9.setTransform(275,200,1,1,0,0,0,275,200);

	// 1
	this.instance_10 = new lib._1();

	this.addChild(this.instance_10,this.instance_9,this.instance_8,this.instance_7,this.instance_6,this.instance_5,this.instance_4,this.instance_3,this.instance_2,this.instance_1,this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


// symbols:
(lib.cursorIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.cursor();
	this.instance.setTransform(6,9.5,1,1,0,0,0,6,9.5);

	this.timeline.addTween(Tween.get(this.instance).wait(14).to({y:-177.2},19).wait(31).to({x:63,y:-158.2},9).wait(21).to({y:-139.2},5).wait(25).to({x:-26.7,y:-115.2},15).wait(15).to({y:-55.2},15).wait(131));

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


(lib.cardIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.card();
	this.instance.setTransform(83,16.1,1,1,0,0,0,61,18);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(209).to({_off:false},0).to({y:19},5).to({y:13.1},5).to({y:19},5).to({y:16.1},5).wait(71));

}).prototype = p = new MovieClip();


(lib.card = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib.card_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,122,36);


(lib.card_1 = function() {
	this.initialize(images.card_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,122,36);


(lib._9Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._9();
	this.instance.setTransform(275,200,1,1,0,0,0,275,200);
	this.instance.alpha = 0;
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(199).to({_off:false},0).to({alpha:1},10).wait(91));

}).prototype = p = new MovieClip();


(lib._9 = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib._8();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._8 = function() {
	this.initialize(images._8);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._8_1 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(184).to({_off:false},0).wait(116));

}).prototype = p = new MovieClip();


(lib._1 = function() {
	this.initialize(images._1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._7Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._7();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(149).to({_off:false},0).wait(151));

}).prototype = p = new MovieClip();


(lib._7 = function() {
	this.initialize(images._7);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._6Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._6();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(119).to({_off:false},0).wait(181));

}).prototype = p = new MovieClip();


(lib._6 = function() {
	this.initialize(images._6);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._5Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._5();
	this.instance.setTransform(275,200,1,1,0,0,0,275,200);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(99).to({_off:false},0).wait(201));

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

	this.timeline.addTween(Tween.get(this.instance).wait(73).to({_off:false},0).wait(227));

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

	this.timeline.addTween(Tween.get(this.instance).wait(53).to({_off:false},0).wait(247));

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

	this.timeline.addTween(Tween.get(this.instance).wait(31).to({_off:false},0).wait(269));

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