package ru.codekittens.bc.game.events {
import flash.events.Event;

public class GameEvent extends Event {

    public static var SCREEN_FINISHED:String = "finished";

    private var src:*;
    private var data:*;


    public function GameEvent(type:String, src:*, data:* = undefined) {
        super(type);
        this.src = src;
        this.data = data;
    }

    public function setSrc(value:*):void {
        this.src = value;
    }

    public function setData(value:*):void {
        this.data = value;
    }

    public function getSrc():* {
        return src;
    }

    public function getData():* {
        return data;
    }
}
}
