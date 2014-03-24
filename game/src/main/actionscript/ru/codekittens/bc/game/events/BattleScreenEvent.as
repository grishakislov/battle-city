package ru.codekittens.bc.game.events {
import flash.events.Event;

public class BattleScreenEvent extends Event {

    public static const SPLASH_COMPLETED:String = "splash_completed";
    public static const SPLASH_DESTROYED:String = "splash_destroyed";
    public static const REDRAW_HUD:String = "redraw_hud";

    public function BattleScreenEvent(type:String) {
        super(type);
    }
}
}
