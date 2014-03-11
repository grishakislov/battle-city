package ru.arlevoland.bc.game.events {
import flash.events.Event;

import ru.arlevoland.bc.game.battle_screen.tank.BaseTank;

public class HQDestroyEvent extends Event {

    public static var HQ_DESTROY:String = "hq_destroy";

    private var tank:BaseTank;

    public function HQDestroyEvent(type:String, tank:BaseTank) {
        super(type);
        this.tank = tank;
    }

    public function getTank():BaseTank {
        return tank;
    }
}
}
