/*
 * Copyright © 2010-2012 South Port Studios
 * Copyright © 2010-2012 ООО "Южный Порт Студиоз"
 *
 * @author arlechin
 */
package ru.arlevoland.bc.game.time {
import flash.events.Event;

public class TickerEvent extends Event {

    public static const TICK:String = "TICK";
    public static const FPS:String = "FPS";

    public function TickerEvent(type:String, deltaTime:int) {
        super(type);
        _dt = deltaTime;
    }

    public function get dt():* {
        return _dt;
    }

    private var _dt:*;

}
}
