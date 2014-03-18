package ru.codekittens.bc.game.battle_screen.tank {
import flash.events.Event;

import ru.codekittens.bc.game.keyboard.key.KeyCommand;

internal class TankControllerEvent extends Event {

    public static const START:String = "START";
    public static const STOP:String = "STOP";

    public function TankControllerEvent(type:String, command:KeyCommand) {
        super(type, false, false);
        this.command = command;
    }

    public function getCommand():KeyCommand {
        return command;
    }

    private var command:KeyCommand;
}
}
