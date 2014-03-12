package ru.codekittens.bc.game.keyboard.key {

public class KeyBinding {

    public function KeyBinding(command:KeyCommand, keys:Array):void {
        this.command = command;
        this.keys = keys;
    }

    public function getCommand():KeyCommand {
        return command;
    }

    public function getKeys():Array {
        return keys;
    }

    private var command:KeyCommand;
    private var keys:Array;

}
}
