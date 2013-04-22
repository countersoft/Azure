if (!window.lib) { window.lib = {}; }

var p; // shortcut to reference prototypes

// stage content:
(lib.editingitems = function() {
	this.initialize();

	// cursor
	this.instance = new lib.cursor1();
	this.instance.setTransform(490,105.4,1,1,0,0,0,6,9.5);

	// 12
	this.instance_1 = new lib._12();
	this.instance_1.setTransform(275,200,1,1,0,0,0,275,200);

	// 11
	this.instance_2 = new lib._11();
	this.instance_2.setTransform(275,200,1,1,0,0,0,275,200);

	// 10
	this.instance_3 = new lib._10();
	this.instance_3.setTransform(275,200,1,1,0,0,0,275,200);

	// 9
	this.instance_4 = new lib._9();
	this.instance_4.setTransform(275,200,1,1,0,0,0,275,200);

	// 8
	this.instance_5 = new lib._8();
	this.instance_5.setTransform(275,200,1,1,0,0,0,275,200);

	// 7
	this.instance_6 = new lib._7();
	this.instance_6.setTransform(275,200,1,1,0,0,0,275,200);

	// 6
	this.instance_7 = new lib._6();
	this.instance_7.setTransform(275,200,1,1,0,0,0,275,200);

	// 5
	this.instance_8 = new lib._5();
	this.instance_8.setTransform(275,200,1,1,0,0,0,275,200);

	// 4
	this.instance_9 = new lib._4();
	this.instance_9.setTransform(275,200,1,1,0,0,0,275,200);

	// 3
	this.instance_10 = new lib._3();
	this.instance_10.setTransform(275,200,1,1,0,0,0,275,200);

	// 2
	this.instance_11 = new lib._2();
	this.instance_11.setTransform(275,200,1,1,0,0,0,275,200);

	// 1
	this.instance_12 = new lib._1();

	this.addChild(this.instance_12,this.instance_11,this.instance_10,this.instance_9,this.instance_8,this.instance_7,this.instance_6,this.instance_5,this.instance_4,this.instance_3,this.instance_2,this.instance_1,this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


// symbols:
(lib.cursor1 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.cursor();
	this.instance.setTransform(6,9.5,1,1,0,0,0,6,9.5);

	this.timeline.addTween(Tween.get(this.instance).wait(14).to({x:-274.7,y:173.5},20).wait(40).to({x:-22.7,y:-51.2},20).wait(35).to({y:35.5},30).wait(50).to({y:95.5},20).wait(50).to({x:-190.7,y:140.5},20).wait(101));

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


(lib._12 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._12_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(324).to({_off:false},0).wait(76));

}).prototype = p = new MovieClip();


(lib._12_1 = function() {
	this.initialize(images._12_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._11 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._11_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(297).to({_off:false},0).wait(103));

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

	this.timeline.addTween(Tween.get(this.instance).wait(254).to({_off:false},0).wait(146));

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

	this.timeline.addTween(Tween.get(this.instance).wait(229).to({_off:false},0).wait(171));

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

	this.timeline.addTween(Tween.get(this.instance).wait(199).to({_off:false},0).wait(201));

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

	this.timeline.addTween(Tween.get(this.instance).wait(169).to({_off:false},0).wait(231));

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

	this.timeline.addTween(Tween.get(this.instance).wait(154).to({_off:false},0).wait(246));

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

	this.timeline.addTween(Tween.get(this.instance).wait(146).to({_off:false},0).wait(254));

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

	this.timeline.addTween(Tween.get(this.instance).wait(109).to({_off:false},0).wait(291));

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

	this.timeline.addTween(Tween.get(this.instance).wait(54).to({_off:false},0).wait(346));

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

	this.timeline.addTween(Tween.get(this.instance).wait(34).to({_off:false},0).wait(366));

}).prototype = p = new MovieClip();


(lib._2_1 = function() {
	this.initialize(images._2_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._1 = function() {
	this.initialize(images._1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);