package ecs.benchmarks.ecx_hot1;

import hotmem.F32Array;
import ecx.Entity;

@:unreflective
class EcxHot1PositionHandle {

	public var handle:Int;

	@:unreflective
	public var data:F32Array;

	public var x(get, never):Float;
	public var y(get, never):Float;

	@:unreflective
	inline public function new(data:F32Array, entity:Entity) {
		handle = entity.id << 1;
		this.data = data;
	}

	inline public function randomize() {
		data[handle] = Math.random();
		data[handle + 1] = Math.random();
	}

	inline public function get_x():Float {
		return data[handle];
	}

	inline public function get_y():Float {
		return data[handle + 1];
	}
}
