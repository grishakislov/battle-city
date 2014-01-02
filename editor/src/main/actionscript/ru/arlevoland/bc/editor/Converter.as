/**
 * @author arlechin
 * Date: 12.06.12
 * Time: 15:16
 */
package ru.arlevoland.bc.editor {
import flash.geom.Point;
import flash.net.FileReference;
import flash.utils.ByteArray;

import ru.arlevoland.bc.editor.bcb.model.BrushMap;
import ru.arlevoland.bc.editor.bcb.model.FitData;
import ru.arlevoland.bc.editor.bcb.model.LevelData;
import ru.arlevoland.bc.editor.bcb.model.TankFitData;
import ru.arlevoland.bc.editor.core.assets.AssetHelper;

//TODO: Разделить класс
public class Converter {

    private static const LINE_DELIMITER:String = "\r\n";
    private static const DOUBLE_LINE_DELIMITER:String = "\r\n\r\n";
    private static const WORD_DELIMITER:String = ",";
    private static const COMMENT:String = ";";
    private static const SPACE:String = " ";
    private static const COORDS_INDEX:uint = 3;

    private static const FIT_MODEL_MARKER:String = "#FIT";
    private static const TANK_FIT_MODEL_MARKER:String = "#TFIT";
    private static const BRUSH_MAP_MARKET:String = "#BRUSH";
    private static const LEVEL_DATA_MARKER:String = "#LEVEL";

    public function run():void {
        trace("Converter Started");

        /*
         FitData x --
         TankFitData x 64?
         BrushMaps x 2
         LevelData x 36?
         */

        parseDataFiles();
        prepareByteArray();
        saveToBinary();
    }

    private function parseDataFiles():void {
        var fitDataFile:String = new Resources.TILES_TXT();
        var fitDataLines:Array = fitDataFile.split(LINE_DELIMITER);

        var tankFitDataFile:String = new Resources.TANKS_TXT();
        var tankFitDataLines:Array = tankFitDataFile.split(LINE_DELIMITER);

        var brushMapFile:String = new Resources.BRUSH_TXT();
        var brushMaps:Array = brushMapFile.split(DOUBLE_LINE_DELIMITER);

        var levelDataFile:String = new Resources.LEVELS_TXT();
        var levelDataLines:Array = levelDataFile.split(LINE_DELIMITER);

        _fitData = parseFitData(fitDataLines);
        _tankFitData = parseTankFitData(tankFitDataLines);
        _brushMaps = parseBrushMaps(brushMaps);
        _levelData = parseLevelData(levelDataLines);
    }

    [ArrayElementType("ru.arlechin.battlecity.bcb.model.FitData")]
    private function parseFitData(data:Array):Array {
        var result:Array = [];
        var currentLine:Array;
        var model:FitData;
        var currentCoordIndex:uint;
        for each (var s:String in data) {
            if (s.charAt(0) != COMMENT && s.charAt(0) != SPACE && s != "") {
                currentLine = s.split(WORD_DELIMITER);
                model = new FitData(currentLine[0], currentLine[1], int(currentLine [2]));
                if (model.getTilesNumber() == 1) {
                    model.pushCoordinate(new Point(int(currentLine[3]), int(currentLine[4])));
                } else {
                    for (var i:int = 0; i < model.getTilesNumber(); i++) {
                        currentCoordIndex = COORDS_INDEX + i * 2;
                        model.pushCoordinate(new Point(currentLine[currentCoordIndex], currentLine[currentCoordIndex + 1]));
                    }
                }
                result.push(model);
            }
        }
        return result;
    }

    [ArrayElementType("ru.arlechin.battlecity.bcb.model.TankFitData")]
    private function parseTankFitData(data:Array):Array {
        var result:Array = [];
        var model:TankFitData;
        var currentLine:Array;
        for each (var s:String in data) {
            if (s.charAt(0) != COMMENT && s.charAt(0) != SPACE && s != "") {
                currentLine = s.split(WORD_DELIMITER);
                model = new TankFitData(currentLine[0], new Point(int(currentLine[1]), int(currentLine[2])));
                result.push(model);
            }
        }
        return result;
    }

    [ArrayElementType("ru.arlechin.battlecity.bcb.model.BrushMap")]
    private function parseBrushMaps(data:Array):Array {
        var result:Array = [];
        var model:BrushMap;

        for each (var unparsedBrushMap:String in data) {
            var linesArray:Array = unparsedBrushMap.split(LINE_DELIMITER);
            model = new BrushMap(linesArray.shift(), linesArray.shift(), int(linesArray.shift()), int(linesArray.shift()));

            for each (var s:String in linesArray) {
                for (var i:uint = 0; i < s.length; i++) {
                    model.brushMap.push(AssetHelper.convertStringToHex(s.charAt(i)))
                }
            }
            result.push(model);
        }
        return result;
    }

    private function parseLevelData(data:Array):Array {
        var result:Array = [];
        var model:LevelData;
        var string:String = "";
        var counter:int = 0;
        var models:Array = [];

        for (var i:int = 0; i < data.length; i++) {
            if (data[i].charAt(0) != COMMENT) {
                string += data[i];
                counter++;
                if (counter == 13) {
                    string += WORD_DELIMITER;
                    counter = 0;
                }
            }
        }

        if (string.charAt(string.length - 1) == WORD_DELIMITER) string = string.substr(0, string.length - 1);
        models = string.split(WORD_DELIMITER);
        counter = 1;
        for each (var s:String in models) {
            model = new LevelData(counter);//ID уровней автоматически заполняются при чтении
            for (var i:int = 0; i < s.length; i++) {
                model.levelData.push(AssetHelper.convertStringToHex(s.charAt(i)));
            }
            result.push(model);
            counter++;
        }

        return result;
    }

    private function prepareByteArray():void {
        var fitDataLength:uint = _fitData.length;
        var tankFitDataLength:uint = _tankFitData.length;
        var brushMapsLength:uint = _brushMaps.length;
        var levelDataLength:uint = _levelData.length;
        //TODO: Вообще-то надо проверять количество данных, конечно
//        if (fitDataLength < 256) {
//            byteArray.writeByte(fitDataLength);
//        } else {
//            throw new IllegalOperationError("File too big (" + fitDataLength + "); use Double.")
//        }

        var coords:Array;

        byteArray.writeByte(4); //TODO hardcode количество записанных типов моделей

        byteArray.writeUTF(FIT_MODEL_MARKER);
        byteArray.writeByte(fitDataLength);
        var tilesNumber:int;
        for each (var f:FitData in _fitData) {
            byteArray.writeUTF(f.getName());
            byteArray.writeUTF(f.getPalette());
            tilesNumber = f.isHorizontalOrder() ? -f.getTilesNumber() : f.getTilesNumber();
            byteArray.writeByte(tilesNumber);
            coords = f.getAllCoords().concat();
            for each (var p:Point in coords) {
                byteArray.writeByte(p.x);
                byteArray.writeByte(p.y);
            }
        }

        byteArray.writeUTF(TANK_FIT_MODEL_MARKER);
        byteArray.writeByte(tankFitDataLength);

        for each (var tf:TankFitData in _tankFitData) {
            byteArray.writeUTF(tf.getName());
            byteArray.writeByte(tf.getCoords().x);
            byteArray.writeByte(tf.getCoords().y);
        }

        byteArray.writeUTF(BRUSH_MAP_MARKET);
        byteArray.writeByte(brushMapsLength);

        for each (var bm:BrushMap in _brushMaps) {
            byteArray.writeUTF(bm.name);
            byteArray.writeUTF(bm.palette);
            byteArray.writeByte(bm.width);
            byteArray.writeByte(bm.height);

            for (var i:int = 0; i < bm.brushMap.length; i++) {
                byteArray.writeByte(AssetHelper.convertStringToHex(bm.brushMap[i]));
            }
        }

        byteArray.writeUTF(LEVEL_DATA_MARKER);
        byteArray.writeByte(levelDataLength);

        for each (var ld:LevelData in _levelData) {
            trace(ld.levelId + " " + ld.levelData.length);
            byteArray.writeByte(ld.levelId);
            for (var i:int = 0; i < ld.levelData.length; i++) {
                byteArray.writeByte(ld.levelData[i]);
            }

        }

    }

    private function saveToBinary():void {
//        byteArray.compress();
        file.save(byteArray, "data.bcb");
    }

    var file:FileReference = new FileReference();
    var byteArray:ByteArray = new ByteArray();
    [ArrayElementType("ru.arlechin.battlecity.bcb.model.FitData")]
    private var _fitData:Array = [];
    [ArrayElementType("ru.arlechin.battlecity.bcb.model.TankFitData")]
    private var _tankFitData:Array = [];
    [ArrayElementType("ru.arlechin.battlecity.bcb.model.BrushMap")]
    private var _brushMaps:Array = [];
    [ArrayElementType("ru.arlechin.battlecity.bcb.model.LevelData")]
    private var _levelData:Array = [];
}
}
