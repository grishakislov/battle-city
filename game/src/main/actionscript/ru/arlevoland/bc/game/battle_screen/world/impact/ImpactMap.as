package ru.arlevoland.bc.game.battle_screen.world.impact {
import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.bcb_model.LevelData;

public class ImpactMap {

    public function ImpactMap(level:LevelData) {
        this.level = level;
        initializeMap();
    }

    private function initializeMap():void {
        map = new Vector.<ImpactEntity>();
        var width:uint = GameSettings.WORLD_WIDTH;
        var height:uint = GameSettings.WORLD_HEIGHT;
        var total:uint = width * height;

        for (var y:uint = 0; y < height; y++) {
            for (var x:uint = 0; x < width; x++) {
                map.push(createEntity(x,y));
            }
        }

    }

    private function createEntity(x:uint, y:uint):ImpactEntity {
        var result:ImpactEntity = new ImpactEntity();
//        level.getDataAt()
        return result;
    }

    //26x26
    private var map:Vector.<ImpactEntity>;

    //13x13
    private var level:LevelData;
}
}
