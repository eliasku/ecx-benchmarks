package ecs.benchmarks.edge;

import edge.IComponent;

class EdgePosition4 implements IComponent {

    public var x:Float = 0;
    public var y:Float = 0;

    public static function random():EdgePosition4 {
        return new EdgePosition4(Math.random(), Math.random());
    }
}