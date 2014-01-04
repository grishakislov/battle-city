package ru.arlevoland.bc.game.battle_screen {
import flash.events.Event;

public class BattleScreenEvent extends Event {

    public static const SPLASH_COMPLETED:String = "splash_completed";
    public static const SPLASH_DESTROYED:String = "splash_destroyed";

    public function BattleScreenEvent(type:String) {
        super(type);
    }
}
}
