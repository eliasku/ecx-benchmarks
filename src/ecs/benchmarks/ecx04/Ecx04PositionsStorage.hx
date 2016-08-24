package ecs.benchmarks.ecx04;

import hotmem.F32Array;
import ecx.Entity;
import ecx.System;

class Ecx04PositionsStorage extends System {

	public var _position1_x:F32Array;
	public var _position1_y:F32Array;
	public var _position2_x:F32Array;
	public var _position2_y:F32Array;
	public var _position3_x:F32Array;
	public var _position3_y:F32Array;
	public var _position4_x:F32Array;
	public var _position4_y:F32Array;

	public function new() {}

	override function initialize() {
		var len = world.capacity;
		_position1_x = new F32Array(len);
		_position1_y = new F32Array(len);
		_position2_x = new F32Array(len);
		_position2_y = new F32Array(len);
		_position3_x = new F32Array(len);
		_position3_y = new F32Array(len);
		_position4_x = new F32Array(len);
		_position4_y = new F32Array(len);
	}

	inline public function randomize1(entity:Entity) {
		_position1_x[entity.id] = Math.random();
		_position1_y[entity.id] = Math.random();
	}

	inline public function randomize2(entity:Entity) {
		_position2_x[entity.id] = Math.random();
		_position2_y[entity.id] = Math.random();
	}

	inline public function randomize3(entity:Entity) {
		_position3_x[entity.id] = Math.random();
		_position3_y[entity.id] = Math.random();
	}

	inline public function randomize4(entity:Entity) {
		_position4_x[entity.id] = Math.random();
		_position4_y[entity.id] = Math.random();
	}
}
