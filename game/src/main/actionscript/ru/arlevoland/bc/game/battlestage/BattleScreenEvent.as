package ru.arlevoland.bc.game.battlestage {
import flash.events.Event;

public class BattleScreenEvent extends Event {

    public static const PRELOADER_COMPLETED:String = "preloader_completed";

    public function BattleScreenEvent(type:String) {
        super(type);
    }
}
}
