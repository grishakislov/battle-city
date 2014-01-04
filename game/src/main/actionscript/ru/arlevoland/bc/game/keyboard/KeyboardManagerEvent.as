package ru.arlevoland.bc.game.keyboard {
import flash.events.Event;

import ru.arlevoland.bc.game.keyboard.key.KeyCommand;

public class KeyboardManagerEvent extends Event {

    public static const KEY_DOWN:String = "KEY_DOWN";
    public static const KEY_UP:String = "KEY_UP";

    public function KeyboardManagerEvent(type:String, command:KeyCommand) {
        super(type, false, false);
        this.command = command;
    }


    public function getCommand():KeyCommand {
        return command;
    }

    private var command:KeyCommand;
}
}
