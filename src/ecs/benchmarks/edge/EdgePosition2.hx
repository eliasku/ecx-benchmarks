package ecs.benchmarks.edge;

import edge.IComponent;

class EdgePosition2 implements IComponent {

    public var x:Float = 0;
    public var y:Float = 0;

    public static function random():EdgePosition2 {
        return new EdgePosition2(Math.random(), Math.random());
    }
}