package ecs.benchmarks.ecx2hot;

import ecs.benchmarks.ecx2hot.Ecx2HotPositionBase;
import ecx.Family;
import ecx.System;

class Ecx2HotSystem extends System {

	public var entities:Family<Ecx2HotPosition1, Ecx2HotPosition3, Ecx2HotPosition4>;

	public function new() {}
}
