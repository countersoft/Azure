if (!window.lib) { window.lib = {}; }

var p; // shortcut to reference prototypes

// stage content:
(lib.Sequencing = function() {
	this.initialize();

	// resize
	this.instance = new lib.resizeIdle();
	this.instance.setTransform(18,175.4,1,1,0,0,0,4.5,11.5);

	// 6
	this.instance_1 = new lib._6();
	this.instance_1.setTransform(275,200,1,1,0,0,0,275,200);

	// drag2
	this.instance_2 = new lib.drag2Idle();
	this.instance_2.setTransform(279,87.9,1,1,0,0,0,271,13);

	// 5
	this.instance_3 = new lib._5Idle();
	this.instance_3.setTransform(275,200,1,1,0,0,0,275,200);

	// 4
	this.instance_4 = new lib._4Idle();
	this.instance_4.setTransform(275,200,1,1,0,0,0,275,200);

	// 2
	this.instance_5 = new lib._3Idle();
	this.instance_5.setTransform(275,200,1,1,0,0,0,275,200);

	// drag
	this.instance_6 = new lib.dragIdle();
	this.instance_6.setTransform(279,174.5,1,1,0,0,0,271,13.5);

	// cursor
	this.instance_7 = new lib.cursorIdle();
	this.instance_7.setTransform(96,181.4,1,1,0,0,0,6,9.5);

	// 1
	this.instance_8 = new lib._2();

	this.addChild(this.instance_8,this.instance_7,this.instance_6,this.instance_5,this.instance_4,this.instance_3,this.instance_2,this.instance_1,this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


// symbols:
(lib.resizeIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.resize();
	this.instance.setTransform(4.5,11.5,1,1,0,0,0,4.5,11.5);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(47).to({_off:false},0).wait(20).to({y:-24.2},20).wait(22).to({y:-75.2},20).wait(30).to({y:34.5},20).wait(91));

}).prototype = p = new MovieClip();


(lib.resize = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib.resize_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,9,23);


(lib.resize_1 = function() {
	this.initialize(images.resize_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,9,23);


(lib._6 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._6Idle();
	this.instance.setTransform(275,200,1,1,0,0,0,275,200);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(179).to({_off:false},0).wait(91));

}).prototype = p = new MovieClip();


(lib._6Idle = function() {
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


(lib.drag2Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.drag2();
	this.instance.setTransform(271,13,1,1,0,0,0,271,13);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(149).to({_off:false},0).wait(10).to({y:125},20).wait(91));

}).prototype = p = new MovieClip();


(lib.drag2 = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib.drag2_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,542,26);


(lib.drag2_1 = function() {
	this.initialize(images.drag2_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,542,26);


(lib._5Idle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._5();
	this.instance.setTransform(275,200,1,1,0,0,0,275,200);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(127).to({_off:false},0).wait(143));

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

	this.timeline.addTween(Tween.get(this.instance).wait(114).to({_off:false},0).wait(156));

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

	this.timeline.addTween(Tween.get(this.instance).wait(87).to({_off:false},0).wait(183));

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


(lib.dragIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.drag();
	this.instance.setTransform(271,13.5,1,1,0,0,0,271,13.5);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(67).to({_off:false},0).to({y:-21.2},20).wait(183));

}).prototype = p = new MovieClip();


(lib.drag = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib.drag_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,542,27);


(lib.drag_1 = function() {
	this.initialize(images.drag_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,542,27);


(lib.cursorIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.cursor();
	this.instance.setTransform(219.5,131.5,1,1,0,0,0,6,9.5);

	this.timeline.addTween(Tween.get(this.instance).wait(19).to({x:219,y:130.5},0).to({x:-64.6,y:11.5},25).to({x:-69.7,y:7.6,alpha:0},2).wait(224));

}).prototype = p = new MovieClip();
p.nominalBounds = new Rectangle(213.5,122,12,19);


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


(lib._2 = function() {
	this.initialize(images._2);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);