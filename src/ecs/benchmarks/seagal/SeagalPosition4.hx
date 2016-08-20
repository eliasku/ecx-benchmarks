package ecs.benchmarks.seagal;

import se.salomonsson.seagal.core.IComponent;

class SeagalPosition4 implements IComponent{

	public var x:Float = 0;
	public var y:Float = 0;

	public function new() {}

	public function randomize():SeagalPosition4 {
		x = Math.random();
		y = Math.random();
		return this;
	}
}
