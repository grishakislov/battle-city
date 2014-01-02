package ru.arlevoland.bc.game.bcb.model {
import flash.geom.Point;

public class FitData {


    public function FitData(name:String, palette:String, tilesNumber:int) {
        _name = name;
        _palette = palette;
        if (tilesNumber < 0) {
            _tilesNumber = Math.abs(tilesNumber);
            _horizontalOrder = true;
        } else {
            _tilesNumber = Math.abs(tilesNumber);
            _horizontalOrder = false;
        }

    }

    public function pushCoordinate(p:Point):void {
        _coords.push(p);
    }

    public function getAllCoords():Array {
        return _coords;
    }

    public function getCoordAt(index:uint):Point {
        return _coords[index];
    }

    public function getName():String {
        return _name;
    }

    public function getTilesNumber():uint {
        return _tilesNumber;
    }


    public function isHorizontalOrder():Boolean {
        return _horizontalOrder;
    }

    public function getPalette():String {
        return _palette;
    }

    private var _palette:String;
    private var _horizontalOrder:Boolean;
    private var _name:String;
    private var _tilesNumber:int;
    [ArrayElementType("flash.geom.Point")]
    private var _coords:Array = [];
}
}
