package ru.codekittens.bc.game.events {
import flash.events.Event;

public class TogglePauseEvent extends Event {

    public static const PAUSE:String = "toggle_pause";

    public function TogglePauseEvent(type:String) {
        super(type);
    }
}
}
