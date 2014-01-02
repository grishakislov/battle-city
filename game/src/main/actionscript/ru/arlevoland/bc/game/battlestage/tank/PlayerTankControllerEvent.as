package ru.arlevoland.bc.game.battlestage.tank {
import flash.events.Event;

import ru.arlevoland.bc.game.keyboard.key.KeyCommand;

internal class PlayerTankControllerEvent extends Event {

    public static const START:String = "START";
    public static const STOP:String = "STOP";

    public function PlayerTankControllerEvent(type:String, command:KeyCommand) {
        super(type, false, false);
        this.command = command;
    }

    public function getCommand():KeyCommand {
        return command;
    }

    private var command:KeyCommand;
}
}
