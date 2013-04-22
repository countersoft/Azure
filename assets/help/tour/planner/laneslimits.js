if (!window.lib) { window.lib = {}; }

var p; // shortcut to reference prototypes

// stage content:
(lib.laneslimits = function() {
	this.initialize();

	// cursor
	this.instance = new lib.cursorIdle();
	this.instance.setTransform(390,299.3,1,1,0,0,0,6,9.5);

	// 11
	this.instance_1 = new lib._11();
	this.instance_1.setTransform(275,200,1,1,0,0,0,275,200);

	// 10
	this.instance_2 = new lib._10();
	this.instance_2.setTransform(275,200,1,1,0,0,0,275,200);

	// 9
	this.instance_3 = new lib._9();
	this.instance_3.setTransform(275,200,1,1,0,0,0,275,200);

	// 8
	this.instance_4 = new lib._8();
	this.instance_4.setTransform(275,200,1,1,0,0,0,275,200);

	// 7
	this.instance_5 = new lib._7();
	this.instance_5.setTransform(275,200,1,1,0,0,0,275,200);

	// 6
	this.instance_6 = new lib._6();
	this.instance_6.setTransform(275,200,1,1,0,0,0,275,200);

	// 5
	this.instance_7 = new lib._5();
	this.instance_7.setTransform(275,200,1,1,0,0,0,275,200);

	// 4
	this.instance_8 = new lib._4();
	this.instance_8.setTransform(275,200,1,1,0,0,0,275,200);

	// 3
	this.instance_9 = new lib._3();
	this.instance_9.setTransform(275,200,1,1,0,0,0,275,200);

	// 2
	this.instance_10 = new lib._2();
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
	this.instance.setTransform(6,9.5,1,1,0,0,0,6,9.5);

	this.timeline.addTween(Tween.get(this.instance).wait(14).to({x:146,y:-250.2},15).wait(45).to({x:56,y:-90.2},15).wait(20).to({y:74.5},120).wait(80).to({x:19,y:-150.2},20).wait(121));

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


(lib._11 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._11_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(359).to({_off:false},0).wait(91));

}).prototype = p = new MovieClip();


(lib._11_1 = function() {
	this.initialize(images._11_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._10 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._10_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(329).to({_off:false},0).wait(121));

}).prototype = p = new MovieClip();


(lib._10_1 = function() {
	this.initialize(images._10_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._9 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._9_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(257).to({_off:false},0).wait(193));

}).prototype = p = new MovieClip();


(lib._9_1 = function() {
	this.initialize(images._9_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._8 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._8_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(227).to({_off:false},0).wait(223));

}).prototype = p = new MovieClip();


(lib._8_1 = function() {
	this.initialize(images._8_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._7 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._7_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(204).to({_off:false},0).wait(246));

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

	this.timeline.addTween(Tween.get(this.instance).wait(179).to({_off:false},0).wait(271));

}).prototype = p = new MovieClip();


(lib._6_1 = function() {
	this.initialize(images._6_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._5 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._5_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(157).to({_off:false},0).wait(293));

}).prototype = p = new MovieClip();


(lib._5_1 = function() {
	this.initialize(images._5_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._4 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._4_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(137).to({_off:false},0).wait(313));

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

	this.timeline.addTween(Tween.get(this.instance).wait(104).to({_off:false},0).wait(346));

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

	this.timeline.addTween(Tween.get(this.instance).wait(54).to({_off:false},0).wait(396));

}).prototype = p = new MovieClip();


(lib._2_1 = function() {
	this.initialize(images._2_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._1 = function() {
	this.initialize(images._1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);