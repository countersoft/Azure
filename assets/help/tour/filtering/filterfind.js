if (!window.lib) { window.lib = {}; }

var p; // shortcut to reference prototypes

// stage content:
(lib.filterfind = function() {
	this.initialize();

	// pointer
	this.instance = new lib.cursoridle();
	this.instance.setTransform(105,373.3,1,1,0,0,0,6,9.5);

	// 5
	this.instance_1 = new lib._5();
	this.instance_1.setTransform(275,200,1,1,0,0,0,275,200);

	// 4
	this.instance_2 = new lib._4();
	this.instance_2.setTransform(275,200,1,1,0,0,0,275,200);

	// 3
	this.instance_3 = new lib._3();
	this.instance_3.setTransform(275,200,1,1,0,0,0,275,200);

	// 2
	this.instance_4 = new lib._2();
	this.instance_4.setTransform(275,200,1,1,0,0,0,275,200);

	// 1
	this.instance_5 = new lib._1();

	this.addChild(this.instance_5,this.instance_4,this.instance_3,this.instance_2,this.instance_1,this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


// symbols:
(lib.cursoridle = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.cursor();
	this.instance.setTransform(6,9.5,1,1,0,0,0,6,9.5);

	this.timeline.addTween(Tween.get(this.instance).wait(14).to({x:323,y:-161.2},20).wait(40).to({x:156,y:-0.2},25).wait(50).to({x:325,y:-164.2},25).wait(76));

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


(lib._5 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._5_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(189).to({_off:false},0).wait(61));

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

	this.timeline.addTween(Tween.get(this.instance).wait(119).to({_off:false},0).wait(131));

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

	this.timeline.addTween(Tween.get(this.instance).wait(54).to({_off:false},0).wait(196));

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

	this.timeline.addTween(Tween.get(this.instance).wait(34).to({_off:false},0).wait(216));

}).prototype = p = new MovieClip();


(lib._2_1 = function() {
	this.initialize(images._2_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._1 = function() {
	this.initialize(images._1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);