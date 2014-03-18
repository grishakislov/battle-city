package ru.codekittens.bc.game.settings {
import ru.codekittens.bc.game.core.assets.Resources;
import ru.codekittens.bc.game.settings.model.BigTile;
import ru.codekittens.bc.game.settings.model.BrushMap;
import ru.codekittens.bc.game.settings.model.FitData;
import ru.codekittens.bc.game.settings.model.FrameSpeed;
import ru.codekittens.bc.game.settings.model.ImpactData;
import ru.codekittens.bc.game.settings.model.LevelData;
import ru.codekittens.bc.game.settings.model.TankFitData;

public class SettingsManager {

    private var impactDataDictionary:Object;
    private var frameSpeed:Object;
    private var fitData:Vector.<FitData>;
    private var fitDataDictionary:Object;
    private var tankFitData:Vector.<TankFitData>;
    private var brushMaps:Vector.<BrushMap>;
    private var levels:Vector.<LevelData>;
    private var bigTiles:Vector.<BigTile>;
    private var bigTilesIndex:Vector.<BigTile>;

    public function initialize():void {
        frameSpeed = createFrameSpeed();
        impactDataDictionary = createImpactData();
        fitData = createFitData();
        tankFitData = createTankFitData();
        brushMaps = createBrushMaps();
        levels = createLevels();
        bigTiles = createBigTiles();
        indexBigTiles();
        indexFitData();
    }

    private function createFrameSpeed():Object {
        var result:Object = {};
        var json:String = new Resources.FRAME_SPEED;
        var data:Object = JSON.parse(json);
        var array:Array = Mapper.mapFrameSpeed(data);
        for each (var frameSpeed:FrameSpeed in array) {
            result[frameSpeed.id] = frameSpeed;
        }
        return result;
    }

    private function createImpactData():Object {
        var result:Object = {};
        var json:String = new Resources.IMPACT_DATA;
        var data:Object = JSON.parse(json);
        var array:Array = Mapper.mapImpactData(data);
        for each (var impactData:ImpactData in array) {
            result[impactData.name] = impactData;
        }
        return result;
    }

    private function createFitData():Vector.<FitData> {
        var json:String = new Resources.FIT_DATA;
        var data:Object = JSON.parse(json);
        var array:Array = Mapper.mapFitData(data);
        var result:Vector.<FitData> = Vector.<FitData>(array);
        return result;
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

    private function createBigTiles():Vector.<BigTile> {
        var json:String = new Resources.BIG_TILES;
        var data:Object = JSON.parse(json);
        var array:Array = Mapper.mapBigTiles(data);
        var result:Vector.<BigTile> = Vector.<BigTile>(array);
        return result;
    }


    private function createTankFitData():Vector.<TankFitData> {
        var json:String = new Resources.TANK_FIT_DATA;
        var data:Object = JSON.parse(json);
        var array:Array = Mapper.mapTankFitData(data);
        var result:Vector.<TankFitData> = Vector.<TankFitData>(array);
        return result;
    }

    private function createBrushMaps():Vector.<BrushMap> {
        var json:String = new Resources.BRUSH_MAPS;
        var data:Object = JSON.parse(json);
        var array:Array = Mapper.mapBrushMaps(data);
        var result:Vector.<BrushMap> = Vector.<BrushMap>(array);
        return result;
    }

    private function createLevels():Vector.<LevelData> {
        var json:String = new Resources.LEVELS;
        var data:Object = JSON.parse(json);
        var array:Array = Mapper.mapLevels(data);
        var result:Vector.<LevelData> = Vector.<LevelData>(array);
        return result;
    }

    public function getFrameSpeedById(id:String):FrameSpeed {
        return frameSpeed[id];
    }

    public function getImpactDataByName(name:String):ImpactData {
        return impactDataDictionary[name];
    }

    public function getFitDataByName(tileName:String):FitData {
        return fitDataDictionary[tileName];
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
