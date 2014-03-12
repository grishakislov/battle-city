package ru.codekittens.bc.game.settings {
import ru.codekittens.bc.game.core.assets.Resources;
import ru.codekittens.bc.game.settings.model.BigTile;
import ru.codekittens.bc.game.settings.model.BrushMap;
import ru.codekittens.bc.game.settings.model.FitData;
import ru.codekittens.bc.game.settings.model.LevelData;
import ru.codekittens.bc.game.settings.model.TankFitData;

public class SettingsManager {

    private var fitData:Vector.<FitData>;
    private var fitDataDictionary:Object;
    private var tankFitData:Vector.<TankFitData>;
    private var brushMaps:Vector.<BrushMap>;
    private var levels:Vector.<LevelData>;
    private var bigTiles:Vector.<BigTile>;
    private var bigTilesIndex:Vector.<BigTile>;

    public function initialize():void {
        fitData = createFitData();
        tankFitData = createTankFitData();
        brushMaps = createBrushMaps();
        levels = createLevels();
        bigTiles = createBigTiles();
        indexBigTiles();
        indexFitData();
    }

    private function indexBigTiles():void {
        bigTilesIndex = new Vector.<BigTile>(bigTiles.length);
        for each (var b:BigTile in bigTiles) {
            bigTilesIndex[b.id] = b;
        }
    }

    private function indexFitData():void {
        fitDataDictionary = {};
        for each (var d:FitData in fitData) {
            fitDataDictionary[d.name] = d;
        }
    }

    public function getFitDataByName(tileName:String):FitData {
        return fitDataDictionary[tileName];
    }

    private function createBigTiles():Vector.<BigTile> {
        var data:String = new Resources.BIG_TILES;
        var array:Array = JSONHelper.readList(BigTile, data);
        var result:Vector.<BigTile> = Vector.<BigTile>(array);
        return result;
    }

    private function createFitData():Vector.<FitData> {
        var data:String = new Resources.FIT_DATA;
        var array:Array = JSONHelper.readList(FitData, data);
        var result:Vector.<FitData> = Vector.<FitData>(array);
        return result;
    }

    private function createTankFitData():Vector.<TankFitData> {
        var data:String = new Resources.TANK_FIT_DATA;
        var array:Array = JSONHelper.readList(TankFitData, data);
        var result:Vector.<TankFitData> = Vector.<TankFitData>(array);
        return result;
    }

    private function createBrushMaps():Vector.<BrushMap> {
        var data:String = new Resources.BRUSH_MAPS;
        var array:Array = JSONHelper.readList(BrushMap, data);
        var result:Vector.<BrushMap> = Vector.<BrushMap>(array);
        return result;
    }

    private function createLevels():Vector.<LevelData> {
        var data:String = new Resources.LEVELS;
        var array:Array = JSONHelper.readList(LevelData, data);
        var result:Vector.<LevelData> = Vector.<LevelData>(array);
        return result;
    }

    public function getBigTileById(id:int):BigTile {
        return bigTilesIndex[id];
    }

    public function getFitData():Vector.<FitData> {
        return fitData;
    }

    public function getTankFitData():Vector.<TankFitData> {
        return tankFitData;
    }

    public function getBrushMaps():Vector.<BrushMap> {
        return brushMaps;
    }

    public function getLevels():Vector.<LevelData> {
        return levels;
    }

    public function getBigTiles():Vector.<BigTile> {
        return bigTiles;
    }
}
}
