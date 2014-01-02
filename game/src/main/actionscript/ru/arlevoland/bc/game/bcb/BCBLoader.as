/**
 * @author arlechin
 * Date: 15.06.12
 * Time: 1:29
 */
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
        _dataFile = new Resources.DATA();
//        _dataFile.uncompress();
        loadBCB(_dataFile.readByte());
    }

    private function loadBCB(modelsInFile:uint):Array {
        var result:Array = [];

        for (var i:uint = 0; i < modelsInFile; i++) {
            readData();
        }

        return result;
    }

    private function readData():void {
        switch (_dataFile.readUTF()) {
            case BCBDataMarker.FIT_DATA:
                _fitData = loadFitData(_dataFile.readByte());
                break;
            case BCBDataMarker.TANK_FIT_DATA:
                _tankFitData = loadTankFitData(_dataFile.readByte());
                break;
            case BCBDataMarker.BRUSH_MAP:
                _brushMaps = loadBrushMaps(_dataFile.readByte());
                break;
            case BCBDataMarker.LEVEL_DATA:
                _levels = loadLevels(_dataFile.readByte());
                break;
        }

    }

    [ArrayElementType("ru.arlevoland.bc.game.bcb.model.FitData")]
    private function loadFitData(length:uint):Array {
        var result:Array = [];
        var model:FitData;
        for (var i:uint = 0; i < length; i++) {
            model = new FitData(_dataFile.readUTF(), _dataFile.readUTF(), _dataFile.readByte());

            for (var n:uint = 0; n < model.getTilesNumber(); n++) {
                model.pushCoordinate(new Point(_dataFile.readByte(), _dataFile.readByte()))
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
            model = new TankFitData(_dataFile.readUTF(), new Point(_dataFile.readByte(), _dataFile.readByte()));
            result.push(model);
        }

        return result;
    }

    [ArrayElementType("ru.arlevoland.bc.game.bcb.model.BrushMap")]
    private function loadBrushMaps(length:uint):Array {
        var result:Array = [];
        var model:BrushMap;
        for (var i:uint = 0; i < length; i++) {
            model = new BrushMap(_dataFile.readUTF(), _dataFile.readUTF(), _dataFile.readByte(), _dataFile.readByte());
            for (var j:uint = 0; j < model.width * model.height; j++) {
                model.brushMap.push(_dataFile.readByte());
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
            model = new LevelData(_dataFile.readByte());
            for (var j:uint = 0; j < GameSettings.WORLD_WIDTH * GameSettings.WORLD_HEIGHT; j++) {
                model.levelData.push(_dataFile.readByte());
            }
            result.push(model);
        }
        return result;
    }


    public function get fitData():Array {
        return _fitData;
    }

    public function get tankFitData():Array {
        return _tankFitData;
    }

    public function get brushMaps():Array {
        return _brushMaps;
    }

    public function get levels():Array {
        return _levels;
    }

    private var _dataFile:ByteArray;

    private var _fitData:Array;
    private var _tankFitData:Array;
    private var _brushMaps:Array;
    private var _levels:Array;

}
}
