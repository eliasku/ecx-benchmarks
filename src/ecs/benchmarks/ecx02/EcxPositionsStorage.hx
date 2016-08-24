package ecs.benchmarks.ecx02;

import hotmem.F32Array;
import ecx.Entity;
import ecx.System;

class EcxPositionsStorage extends System {

	public var _position1:F32Array;
	public var _position2:F32Array;
	public var _position3:F32Array;
	public var _position4:F32Array;

	public function new() {}

	override function initialize() {
		var len = world.capacity << 1;
		_position1 = new F32Array(len);
		_position2 = new F32Array(len);
		_position3 = new F32Array(len);
		_position4 = new F32Array(len);
	}

	inline public function position1(entity:Entity):EcxPositionHandle {
		return new EcxPositionHandle(_position1, entity);
	}

	inline public function position2(entity:Entity):EcxPositionHandle {
		return new EcxPositionHandle(_position2, entity);
	}

	inline public function position3(entity:Entity):EcxPositionHandle {
		return new EcxPositionHandle(_position3, entity);
	}

	inline public function position4(entity:Entity):EcxPositionHandle {
		return new EcxPositionHandle(_position4, entity);
	}
}
