package ecs.benchmarks.pure_hot;

import hotmem.F32Array;

class PureHotStorage {

	public var _position1_x:F32Array;
	public var _position1_y:F32Array;
	public var _position2_x:F32Array;
	public var _position2_y:F32Array;
	public var _position3_x:F32Array;
	public var _position3_y:F32Array;
	public var _position4_x:F32Array;
	public var _position4_y:F32Array;

	public function new(capacity:Int) {
		_position1_x = new F32Array(capacity);
		_position1_y = new F32Array(capacity);
		_position2_x = new F32Array(capacity);
		_position2_y = new F32Array(capacity);
		_position3_x = new F32Array(capacity);
		_position3_y = new F32Array(capacity);
		_position4_x = new F32Array(capacity);
		_position4_y = new F32Array(capacity);
	}

	inline public function randomize1(index:Int) {
		_position1_x[index] = Math.random();
		_position1_y[index] = Math.random();
	}

	inline public function randomize2(index:Int) {
		_position2_x[index] = Math.random();
		_position2_y[index] = Math.random();
	}

	inline public function randomize3(index:Int) {
		_position3_x[index] = Math.random();
		_position3_y[index] = Math.random();
	}

	inline public function randomize4(index:Int) {
		_position4_x[index] = Math.random();
		_position4_y[index] = Math.random();
	}
}
