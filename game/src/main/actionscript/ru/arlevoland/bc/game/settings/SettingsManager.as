package ru.arlevoland.bc.game.settings {
import ru.arlevoland.bc.game.core.assets.Resources;
import ru.arlevoland.bc.game.settings.model.BigTile;
import ru.arlevoland.bc.game.settings.model.BrushMap;
import ru.arlevoland.bc.game.settings.model.FitData;
import ru.arlevoland.bc.game.settings.model.LevelData;
import ru.arlevoland.bc.game.settings.model.TankFitData;

public class SettingsManager {

    private var fitData:Array;
    private var tankFitData:Array;
    private var brushMaps:Array;
    private var levels:Array;
    private var bigTiles:Array;
    private var bigTilesIndex:Array;

    public function initialize():void {
        fitData = createFitData();
        tankFitData = createTankFitData();
        brushMaps = createBrushMaps();
        levels = createLevels();
        bigTiles = createBigTiles();
        indexBigTiles();
    }

    private function indexBigTiles():void {
        bigTilesIndex = [];
        for (var i:int = 0; i < bigTiles.length; i++) {
            bigTiles.push(null);
        }

        for each (var b:BigTile in bigTiles) {
            bigTiles[b.id] = b;
        }
    }

    private function createBigTiles():Array {
        var data:String = new Resources.BIG_TILES;
        var result:Array = JSONHelper.readList(BigTile, data);
        return result;
    }

    private function createFitData():Array {
        var data:String = new Resources.FIT_DATA;
        var result:Array = JSONHelper.readList(FitData, data);
        return result;
    }

    private function createTankFitData():Array {
        var data:String = new Resources.TANK_FIT_DATA;
        var result:Array = JSONHelper.readList(TankFitData, data);
        return result;
    }

    private function createBrushMaps():Array {
        var data:String = new Resources.BRUSH_MAPS;
        var result:Array = JSONHelper.readList(BrushMap, data);
        return result;
    }

    private function createLevels():Array {
        var data:String = new Resources.LEVELS;
        var result:Array = JSONHelper.readList(LevelData, data);
        return result;
    }

    public function getBigTileById(id:int):BigTile {
        return bigTilesIndex[id];
    }

    public function getFitData():Array {
        return fitData;
    }

    public function getTankFitData():Array {
        return tankFitData;
    }

    public function getBrushMaps():Array {
        return brushMaps;
    }

    public function getLevels():Array {
        return levels;
    }

    public function getBigTiles():Array {
        return bigTiles;
    }
}
}
