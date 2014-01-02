package ru.arlevoland.bc.game.bcb.model {
import flash.geom.Point;

public class TankFitData {

    public function TankFitData(name:String, coord:Point) {
        //TODO: Неплохо бы передавать сразу палитру по умолчанию
        _name = name;
        _coords = coord;
    }


    public function getName():String {
        return _name;
    }

    public function getCoords():Point {
        return _coords;
    }

    private var _name:String;
    private var _coords:Point;
}
}
