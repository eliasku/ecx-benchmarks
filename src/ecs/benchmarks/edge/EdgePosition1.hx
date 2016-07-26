package ecs.benchmarks.edge;

import edge.IComponent;

class EdgePosition1 implements IComponent {

    public var x:Float = 0;
    public var y:Float = 0;

    public static function random():EdgePosition1 {
        return new EdgePosition1(Math.random(), Math.random());
    }
}