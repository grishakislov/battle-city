package ru.codekittens.bc.game.settings.model {
public class TankFitData {

    public var key:String;
    public var coord:Coord;

    public function getLevel():uint {
        return uint (key.substr(1,1));
    }

}
}
