if (!window.lib) { window.lib = {}; }

var p; // shortcut to reference prototypes

// stage content:
(lib.listcolumn = function() {
	this.initialize();

	// cursor
	this.instance = new lib.cursor1();
	this.instance.setTransform(300,346.3,1,1,0,0,0,6,9.5);

	// 6
	this.instance_1 = new lib._6();
	this.instance_1.setTransform(275,200,1,1,0,0,0,275,200);

	// 5
	this.instance_2 = new lib._5();
	this.instance_2.setTransform(275,200,1,1,0,0,0,275,200);

	// 4
	this.instance_3 = new lib._4();
	this.instance_3.setTransform(275,200,1,1,0,0,0,275,200);

	// 3
	this.instance_4 = new lib._3();
	this.instance_4.setTransform(275,200,1,1,0,0,0,275,200);

	// 2
	this.instance_5 = new lib._2();
	this.instance_5.setTransform(275,200,1,1,0,0,0,275,200);

	// 1
	this.instance_6 = new lib._1();

	this.addChild(this.instance_6,this.instance_5,this.instance_4,this.instance_3,this.instance_2,this.instance_1,this.instance);
}).prototype = p = new Container();
p.nominalBounds = new Rectangle(0,0,550,400);


// symbols:
(lib.cursor1 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib.cursor();
	this.instance.setTransform(6,9.5,1,1,0,0,0,6,9.5);

	this.timeline.addTween(Tween.get(this.instance).wait(14).to({x:216,y:-178.2},15).wait(35).to({x:-1.7,y:-58.2},15).wait(25).to({y:-40.2},15).wait(35).to({x:8,y:17.5},15).wait(131));

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


(lib._6 = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{},true);

	// Layer 1
	this.instance = new lib._6_1();
	this.instance._off = true;

	this.timeline.addTween(Tween.get(this.instance).wait(194).to({_off:false},0).wait(106));

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

	this.timeline.addTween(Tween.get(this.instance).wait(169).to({_off:false},0).wait(131));

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

	this.timeline.addTween(Tween.get(this.instance).wait(129).to({_off:false},0).wait(171));

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

	this.timeline.addTween(Tween.get(this.instance).wait(89).to({_off:false},0).wait(211));

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

	this.timeline.addTween(Tween.get(this.instance).wait(49).to({_off:false},0).wait(251));

}).prototype = p = new MovieClip();


(lib._2_1 = function() {
	this.initialize(images._2_1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);


(lib._1 = function() {
	this.initialize(images._1);
}).prototype = new Bitmap();
p.nominalBounds = new Rectangle(0,0,550,400);