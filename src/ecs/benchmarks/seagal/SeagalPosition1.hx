package ecs.benchmarks.seagal;

import se.salomonsson.seagal.core.IComponent;

class SeagalPosition1 implements IComponent{

	public var x:Float = 0;
	public var y:Float = 0;

	public function new() {}

	public function randomize():SeagalPosition1 {
		x = Math.random();
		y = Math.random();
		return this;
	}
}
