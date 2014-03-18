package ru.codekittens.bc.game.settings {
import ru.codekittens.bc.game.settings.model.BigTile;
import ru.codekittens.bc.game.settings.model.BrushMap;
import ru.codekittens.bc.game.settings.model.Coord;
import ru.codekittens.bc.game.settings.model.FitData;
import ru.codekittens.bc.game.settings.model.FrameSpeed;
import ru.codekittens.bc.game.settings.model.ImpactData;
import ru.codekittens.bc.game.settings.model.LevelData;
import ru.codekittens.bc.game.settings.model.TankFitData;

public class Mapper {

    [ArrayElementType("ru.codekittens.bc.game.settings.model.FrameSpeed")]
    public static function mapFrameSpeed(source:Object):Array {
        var result:Array = [];
        var model:FrameSpeed;
        for (var i:int = 0; i < source.length; i++) {
            var object:Object = source[i];
            model = new FrameSpeed();
            model.id = object["id"];
            model.type = object["type"];
            model.pixelsPerFrame = object["pixelsPerFrame"];
            model.sequence = createSequence(object["sequence"]);
            result.push(model);
        }

        function createSequence(o:Object):Vector.<Boolean> {
            var vector:Vector.<Boolean> = new Vector.<Boolean>();
            for (var i:int = 0; i < o.length; i++) {
                vector.push(o[i]);
            }
            return vector;
        }

        return result;
    }

    [ArrayElementType("ru.codekittens.bc.game.settings.model.ImpactData")]
    public static function mapImpactData(source:Object):Array {
        var result:Array = [];
        var model:ImpactData;
        for (var i:int = 0; i < source.length; i++) {
            var object:Object = source[i];
            model = new ImpactData();
            model.name = object["name"];
            model.passable = object["passable"];
            model.brushIndex = object["brushIndex"];
            result.push(model);
        }

        return result;
    }

    [ArrayElementType("ru.codekittens.bc.game.settings.model.FitData")]
    public static function mapFitData(source:Object):Array {
        var result:Array = [];
        var model:FitData;
        for (var i:int = 0; i < source.length; i++) {
            var object:Object = source[i];
            model = new FitData();
            model.name = object["name"];
            model.palette = object["palette"];
            model.tag = object["tag"];
            model.straight  = object["straight"];
            model.coords = readCoords(object["coords"]);
            result.push(model);
        }

        return result;
    }

    [ArrayElementType("ru.codekittens.bc.game.settings.model.BigTile")]
    public static function mapBigTiles(source:Object):Array {
        var result:Array = [];
        var model:BigTile;
        for (var i:int = 0; i < source.length; i++) {
            var object:Object = source[i];
            model = new BigTile();
            model.id = object["id"];
            model.name = object["name"];
            model.tiles = readTiles(object["tiles"]);
            result.push(model);
        }

        function readTiles(o:Object):Vector.<String> {
            var result:Vector.<String> = new Vector.<String>();
            for (var i:int = 0; i < o.length; i++) {
                result.push(o[i]);
            }
            return result;
        }

        return result;
    }

    [ArrayElementType("ru.codekittens.bc.game.settings.model.TankFitData")]
    public static function mapTankFitData(source:Object):Array {
        var result:Array = [];
        var model:TankFitData;
        for (var i:int = 0; i < source.length; i++) {
            var object:Object = source[i];
            model = new TankFitData();
            model.key = object["key"];
            model.coord = createCoord(object["coord"]);
            result.push(model);
        }

        return result;
    }

    [ArrayElementType("ru.codekittens.bc.game.settings.model.BrushMap")]
    public static function mapBrushMaps(source:Object):Array {
        var result:Array = [];
        var model:BrushMap;
        for (var i:int = 0; i < source.length; i++) {
            var object:Object = source[i];
            model = new BrushMap();
            model.name = object["name"];
            model.palette = object["palette"];
            model.width = object["width"];
            model.height = object["height"];
            model.data = object["data"];
            result.push(model);
        }

        return result;
    }

    [ArrayElementType("ru.codekittens.bc.game.settings.model.LevelData")]
    public static function mapLevels(source:Object):Array {
        var result:Array = [];
        var model:LevelData;
        for (var i:int = 0; i < source.length; i++) {
            var object:Object = source[i];
            model = new LevelData();
            model.id = object["id"];
            model.data = object["data"];
            result.push(model);
        }

        return result;
    }

    private static function readCoords(o:Object):Vector.<Coord> {
        var result:Vector.<Coord> = new Vector.<Coord>();
        for (var i:int = 0; i < o.length; i++) {
            result.push(createCoord(o[i]));
        }
        return result;
    }

    private static function createCoord(o:Object):Coord {
        var result:Coord = new Coord();
        result.x = o["x"];
        result.y = o["y"];
        return result;
    }
}
}
