package ru.codekittens.bc.game.title {
import flash.events.Event;

public class TitleEvent extends Event {

    public static const MENU_SELECTED:String = "MENU_SELECTED";

    public function TitleEvent(type:String, position:int) {
        super(type, false, false);
        position = position;
    }

    public function getPosition():int {
        return position;
    }

    private var position:int;

}
}
