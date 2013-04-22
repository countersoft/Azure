if (!window.lib) { window.lib = {}; }

var p; // shortcut to reference prototypes

// stage content:
(lib.badge = function() {
	this.initialize();

	// cursor
	this.instance = new lib.cursorIdle();
	this.instance.setTransform(163,242.3,1,1,0,0,0,6,9.5);

	// planner carc
	this.instance_1 = new lib.plannercardIdle();
	this.instance_1.setTransform(586,335,1,1,0,0,0,100.5,60);

	// 10
	this.instance_2 = new lib._10();
	this.instance_2.setTransform(275,200,1,1,0,0,0,275,200);

	// 8
	this.instance_3 = new lib._8();
	this.instance_3.setTransform(275,200,1,1,0,0,0,275,200);

	// 9
	this.instance_4 = new lib._9();
	this.instance_4.setTransform(275,200,1,1,0,0,0,275,200);

	// 7
	this.instance_5 = new lib._7();
	this.instance_5.setTransform(275,200,1,1,0,0,0,275,200);

	// 6
	this.instance_6 = new lib._6();
	this.instance_6.setTransform(275,200,1,1,0,0,0,275,200);

	// 5
	this.instance_7 = new lib._5Idle();
	this.instance_7.setTransform(275,200,1,1,0,0,0,275,200);

	// 4
	this.instance_8 = new lib._4Idle();
	this.instance_8.setTransform(275,200,1,1,0,0,0,275,200);

	// 3
	this.instance_9 = new lib._3Idle();
	this.instance_9.setTransform(275,200,1,1,0,0,0,275,200);

	// 2
	this.instance_10 = new lib._2Idle();
	this.instance_10.setTransform(275,200,1,1,0,0,0,275,200);

	// 1
	this.instance_11 = new lib._1();

	this.addChild(this.instance_11,this.instance_10,this.instance_9,this.instance_8,this.instance_7,this.instance_6,this.instance_5,this.instance_4,this.instance_3,this.instance_2,this.instance_1,this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


// symbols:
(lib.cursorIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.cursor();
	this.instance.setTransform(-28.8,-14.3,1,1,0,0,0,6,9.5);

	this.timeline.addTween(Tween.get(this.instance).wait(14).to({x:162,y:-184.2},20).wait(25).to({x:230,y:-173.2},19).wait(126).to({x:387.5,y:93.5},0).wait(25).to({x:387},0).to({x:179},35).wait(55).to({x:169,y:-182.2},25).wait(106));

}).prototype = p = new MovieClip();
p.nominalBounds = new Rectangle(-34.9,-23.9,12,19);


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


(lib.plannercardIdle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.plannercard();
	this.instance.setTransform(78.6,54.6,1,1,0,0,0,100.5,60);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(204).to({_off:false},0).wait(25).to({y:55.1},0).to({x:-145.2},35).to({_off:true},55).wait(81));

}).prototype = p = new MovieClip();


(lib.plannercard = function() {
	this.initialize();

	// Layer 1
	this.instance = new lib.plannercard_1();

	this.addChild(this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,201,120);


(lib.plannercard_1 = function() {
	this.initialize(images.plannercard_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,201,120);


(lib._10 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._10_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(354).to({_off:false},0).wait(96));

}).prototype = p = new MovieClip();


(lib._10_1 = function() {
	this.initialize(images._10_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._8 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._8_1();
	this.instance.setTransform(200,72.1);
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(204).to({_off:false},0).to({_off:true},115).wait(131));

}).prototype = p = new MovieClip();


(lib._8_1 = function() {
	this.initialize(images._8_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._9 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._9_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(264).to({_off:false},0).wait(186));

}).prototype = p = new MovieClip();


(lib._9_1 = function() {
	this.initialize(images._9_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._7 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._7_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(169).to({_off:false},0).wait(281));

}).prototype = p = new MovieClip();


(lib._7_1 = function() {
	this.initialize(images._7_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._6 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._6_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(129).to({_off:false},0).wait(321));

}).prototype = p = new MovieClip();


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

	this.timeline.addTween(Tween.get(this.instance).wait(98).to({_off:false},0).wait(352));

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

	this.timeline.addTween(Tween.get(this.instance).wait(78).to({_off:false},0).wait(372));

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

	this.timeline.addTween(Tween.get(this.instance).wait(53).to({_off:false},0).wait(397));

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

	this.timeline.addTween(Tween.get(this.instance).wait(33).to({_off:false},0).wait(417));

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