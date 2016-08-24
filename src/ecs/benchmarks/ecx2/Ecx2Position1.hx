package ecs.benchmarks.ecx2;

import ecx.Entity;
import ecx.storage.AutoComp;
import ecx.storage.ComponentArray;

class Ecx2Position1 extends ComponentArray implements AutoComp<Ecx2PositionData> {

    public function randomize(entity:Entity):Ecx2PositionData {
        var data = get(entity);
        if(data == null) {
            data = create(entity);
        }
        data.x = Math.random();
        data.y = Math.random();
        return data;
    }
}