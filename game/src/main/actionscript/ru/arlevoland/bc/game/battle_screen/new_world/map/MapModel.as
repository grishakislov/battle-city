package ru.arlevoland.bc.game.battle_screen.new_world.map {
import flash.display.BitmapData;

public class MapModel {

    private var tiles:Vector.<int>;
    private var type:MapType;
    private var bitmapData:BitmapData;
    private var levelId:uint;

    public function setTiles(value:Vector.<int>):void {
        tiles = value;
    }

    public function setType(value:MapType):void {
        type = value;
    }

    public function setBitmapData(value:BitmapData):void {
        bitmapData = value;
    }

    public function getTiles():Vector.<int> {
        return tiles;
    }

    public function getType():MapType {
        return type;
    }

    public function getBitmapData():BitmapData {
        return bitmapData;
    }

    public function getLevelId():uint {
        return levelId;
    }

    public function setLevelId(value:uint):void {
        levelId = value;
    }
}
}
