package ru.arlevoland.bc.game.bcb {
import flash.geom.Point;
import flash.utils.ByteArray;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.core.assets.Resources;
import ru.arlevoland.bc.game.bcb.model.BrushMap;
import ru.arlevoland.bc.game.bcb.model.FitData;
import ru.arlevoland.bc.game.bcb.model.LevelData;
import ru.arlevoland.bc.game.bcb.model.TankFitData;

public class BCBLoader {

    public function initialize():void {
        dataFile = new Resources.DATA();
//        _dataFile.uncompress();
        loadBCB(dataFile.readByte());
    }

    private function loadBCB(modelsInFile:uint):Array {
        var result:Array = [];

        for (var i:uint = 0; i < modelsInFile; i++) {
            readData();
        }

        return result;
    }

    private function readData():void {
        switch (dataFile.readUTF()) {
            case BCBDataMarker.FIT_DATA:
                fitData = loadFitData(dataFile.readByte());
                break;
            case BCBDataMarker.TANK_FIT_DATA:
                tankFitData = loadTankFitData(dataFile.readByte());
                break;
            case BCBDataMarker.BRUSH_MAP:
                brushMaps = loadBrushMaps(dataFile.readByte());
                break;
            case BCBDataMarker.LEVEL_DATA:
                levels = loadLevels(dataFile.readByte());
                break;
        }

    }

    [ArrayElementType("ru.arlevoland.bc.game.bcb.model.FitData")]
    private function loadFitData(length:uint):Array {
        var result:Array = [];
        var model:FitData;
        for (var i:uint = 0; i < length; i++) {
            model = new FitData(dataFile.readUTF(), dataFile.readUTF(), dataFile.readByte());

            for (var n:uint = 0; n < model.getTilesNumber(); n++) {
                model.pushCoordinate(new Point(dataFile.readByte(), dataFile.readByte()))
            }
            result.push(model);
        }

        return result;
    }

    [ArrayElementType("ru.arlevoland.bc.game.bcb.model.TankFitData")]
    private function loadTankFitData(length:uint):Array {
        var result:Array = [];
        var model:TankFitData;

        for (var i:uint = 0; i < length; i++) {
            model = new TankFitData(dataFile.readUTF(), new Point(dataFile.readByte(), dataFile.readByte()));
            result.push(model);
        }

        return result;
    }

    [ArrayElementType("ru.arlevoland.bc.game.bcb.model.BrushMap")]
    private function loadBrushMaps(length:uint):Array {
        var result:Array = [];
        var model:BrushMap;
        for (var i:uint = 0; i < length; i++) {
            model = new BrushMap(dataFile.readUTF(), dataFile.readUTF(), dataFile.readByte(), dataFile.readByte());
            for (var j:uint = 0; j < model.width * model.height; j++) {
                model.brushMap.push(dataFile.readByte());
            }
            result.push(model);
        }

        return result;
    }

    [ArrayElementType("ru.arlevoland.bc.game.bcb.model.LevelData")]
    private function loadLevels(length:uint):Array {
        var result:Array = [];
        var model:LevelData;

        for (var i:uint = 0; i < length; i++) {
            model = new LevelData(dataFile.readByte());
            for (var j:uint = 0; j < GameSettings.WORLD_WIDTH * GameSettings.WORLD_HEIGHT; j++) {
                model.getLevelData().push(dataFile.readByte());
            }
            result.push(model);
        }
        return result;
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

    private var dataFile:ByteArray;

    private var fitData:Array;
    private var tankFitData:Array;
    private var brushMaps:Array;
    private var levels:Array;

}
}
