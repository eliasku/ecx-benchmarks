package ecs.benchmarks.ecx_hot;

import ecx.types.ComponentType;
import ecx.Service;
import ecx.IComponent;
import hotmem.F32Array;
import ecx.Entity;

@:core
class EcxHotPositionBase extends Service implements IComponent {

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

	inline public function destroy(entity:Entity):Void {}
	inline public function copy(source:Entity, destination:Entity) {}
	public function __componentType() {
		return ComponentType.INVALID;
	}

	inline public function getObjectSize():Int {
		return x.getObjectSize() + y.getObjectSize();
	}
}