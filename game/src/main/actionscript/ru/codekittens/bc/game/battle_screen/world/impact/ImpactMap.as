package ru.codekittens.bc.game.battle_screen.world.impact {
import flash.geom.Point;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.settings.model.BigTile;
import ru.codekittens.bc.game.settings.model.FitData;
import ru.codekittens.bc.game.settings.model.ImpactData;
import ru.codekittens.bc.game.settings.model.LevelData;

public class ImpactMap {

    public function ImpactMap(levelId:uint) {
        var level:LevelData = App.levelDataManager.getLevelDataByID(levelId);
        this.level = level;
        this.bigTiles = App.settingsManager.getBigTiles();
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
        map[getIndexFor(x,y)] = entity;
    }

    private function getIndexFor(x:uint, y:uint):uint {
        return y * GameSettings.WORLD_WIDTH * 2 + x;
    }

    public function getEntity(x:uint, y:uint):ImpactEntity {
        return map[getIndexFor(x,y)];
    }

    public function getEntityByPoint(coords:Point):ImpactEntity {
        return map[getIndexFor(coords.x,coords.y)];
    }

    public function getEntities(frontCells:PointPair):ImpactEntityPair {
        return new ImpactEntityPair(getEntityByPoint(frontCells.getFirst()), getEntityByPoint(frontCells.getSecond()));
    }

    private function createEntity(tileName:String):ImpactEntity {
        var impactData:ImpactData = App.settingsManager.getImpactDataByName(tileName);
        var result:ImpactEntity = new ImpactEntity(tileName, impactData.brushIndex);
        return result;
    }

    public function setEntity(ety:ImpactEntity, coords:Point):void {
        storeEntity(coords.x, coords.y, ety);
    }

    //26x26
    private var map:Vector.<ImpactEntity>;

    //13x13
    private var level:LevelData;

    private var bigTiles:Vector.<BigTile>;
}
}
