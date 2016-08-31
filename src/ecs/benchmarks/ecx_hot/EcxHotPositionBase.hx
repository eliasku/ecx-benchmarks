package ecs.benchmarks.ecx_hot;

import ecx.types.ComponentType;
import ecx.Service;
import ecx.Component;
import hotmem.F32Array;
import ecx.Entity;

@:base
class EcxHotPositionBase extends Service implements Component<Bool> {

	public var x:F32Array;
	public var y:F32Array;

	override function __allocate() {
		var len = world.capacity;
		x = new F32Array(len);
		y = new F32Array(len);
	}

	inline public function randomize(entity:Entity) {
		x[entity.id] = Math.random();
		y[entity.id] = Math.random();
	}

	inline public function has(entity:Entity):Bool {
		return true;
	}

	inline public function get(entity:Entity):Bool {
		return true;
	}

	inline public function set(entity:Entity, fake:Bool) {}

	inline public function create(entity:Entity):Bool {
		x[entity.id] = 0.0;
		y[entity.id] = 0.0;
		return true;
	}

	inline public function remove(entity:Entity):Void {}
	inline public function copy(source:Entity, destination:Entity) {}
	public function __componentType() {
		return ComponentType.INVALID;
	}
}