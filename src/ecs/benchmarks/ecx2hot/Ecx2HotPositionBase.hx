package ecs.benchmarks.ecx2hot;

import ecx.storage.ComponentArray;
import hotmem.F32Array;
import ecx.Entity;

@:base
@:components
class Ecx2HotPositionBase extends ComponentArray {

	public var x:F32Array;
	public var y:F32Array;

	override function allocate() {
		var len = world.capacity;
		x = new F32Array(len);
		y = new F32Array(len);
	}

	inline public function randomize(entity:Entity) {
		x[entity.id] = Math.random();
		y[entity.id] = Math.random();
	}

	inline override public function has(entity):Bool {
		return true;
	}
}

class Ecx2HotPosition1 extends Ecx2HotPositionBase {
	public function new() {}
}

class Ecx2HotPosition2 extends Ecx2HotPositionBase {
	public function new() {}
}

class Ecx2HotPosition3 extends Ecx2HotPositionBase {
	public function new() {}
}

class Ecx2HotPosition4 extends Ecx2HotPositionBase {
	public function new() {}
}