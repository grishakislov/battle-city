/**
 * @author arlechin
 * Date: 01.10.12
 * Time: 2:03
 */
package ru.arlevoland.bc.game.battlestage.battleground {
import flash.geom.Point;

public class TileDestroyingState {

    public static const HALF:String = "half";
    public static const FULL:String = "full";

    public function TileDestroyingState(state:String, coords:Point) {
        _state = state;
        _coords = coords;
    }


    public function get state():String {
        return _state;
    }

    public function set state(value:String):void {
        _state = value;
    }

    public function get coords():Point {
        return _coords;
    }

    private var _state:String;
    private var _coords:Point;

}
}
