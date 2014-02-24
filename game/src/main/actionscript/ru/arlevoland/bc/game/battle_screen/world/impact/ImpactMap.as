package ru.arlevoland.bc.game.battle_screen.world.impact {
import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.settings.model.BigTile;
import ru.arlevoland.bc.game.settings.model.FitData;
import ru.arlevoland.bc.game.settings.model.LevelData;

public class ImpactMap {

    public function ImpactMap(levelId:uint) {
        var level:LevelData = App.levelDataManager.getLevelDataByID(levelId);
        this.level = level;
        this.bigTiles = App.settingsManager.getBigTiles().concat();
        initializeMap();
        if (GameSettings.DEBUG) {
            traceMap();
        }
    }

    private function initializeMap():void {
        var width:uint = GameSettings.WORLD_WIDTH;
        var height:uint = GameSettings.WORLD_HEIGHT;
        var total:uint = width * 2 * height * 2;
        map = new Vector.<ImpactEntity>(total);

        for (var y:uint = 0; y < height; y++) {
            for (var x:uint = 0; x < width; x++) {
                createEntitiesFromBigTile(x,y);
            }
        }
    }

    private function traceMap():void {
        var width:uint = GameSettings.WORLD_WIDTH * 2;
        var height:uint = GameSettings.WORLD_HEIGHT * 2;
        var currentString:String;
        for (var y:uint = 0; y < height; y++) {
            currentString = "";
            for (var x:uint = 0; x < width; x++) {
                currentString += getEntity(x,y).getBrickIndex();
            }
            trace(currentString);
        }
    }

    private function createEntitiesFromBigTile(x:uint, y:uint):void {
        var currentBigTile:BigTile = App.settingsManager.getBigTileById(level.getDataAt(x,y));
        var currentX:uint = x * 2;
        var currentY:uint = y * 2;
        storeEntity(currentX,currentY,createEntity(currentBigTile.tiles[0]));
        storeEntity(currentX,currentY+1,createEntity(currentBigTile.tiles[1]));
        storeEntity(currentX+1,currentY,createEntity(currentBigTile.tiles[2]));
        storeEntity(currentX+1,currentY+1,createEntity(currentBigTile.tiles[3]));
    }

    private function storeEntity(x:uint, y:uint, entity:ImpactEntity):void {
//        var index:uint = getIndexFor(x,y);
//        trace(index + "_" + entity.getTileName());
        map[getIndexFor(x,y)] = entity;
    }

    private function getIndexFor(x:uint, y:uint):uint {
        return y * GameSettings.WORLD_WIDTH * 2 + x;
    }

    public function getEntity(x:uint, y:uint):ImpactEntity {
        return map[getIndexFor(x,y)];
    }

    private function createEntity(tileName:String):ImpactEntity {
        var fitData:FitData = App.settingsManager.getFitDataByName(tileName);
        var isBrick:Boolean = fitData.name == "BRUSH_F";
        var brickIndex:uint = fitData.brushIndex;
        if (brickIndex != 0 && brickIndex != 15) {
            !1;
        }
        var result:ImpactEntity = new ImpactEntity(tileName, isBrick, brickIndex);
        return result;
    }

    //26x26
    private var map:Vector.<ImpactEntity>;

    //13x13
    private var level:LevelData;

    [ArrayElementType("ru.arlevoland.bc.game.settings.model.BigTile")]
    private var bigTiles:Array;
}
}
