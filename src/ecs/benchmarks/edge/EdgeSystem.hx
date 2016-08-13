package ecs.benchmarks.edge;

import edge.View;
import edge.ISystem;

class EdgeSystem implements ISystem {
    public var view:View<{
        p1:EdgePosition1,
        p3:EdgePosition3,
        p4:EdgePosition4
    }>;

    function update() {}
}
