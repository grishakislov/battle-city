package ru.arlevoland.bc.game.title {
import flash.events.Event;

public class TitleEvent extends Event {

    public static const MENU_SELECTED:String = "MENU_SELECTED";

    public function TitleEvent(type:String, position:int) {
        super(type, false, false);
        _position = position;
    }

    public function get position():int {
        return _position;
    }

    private var _position:int;

}
}
