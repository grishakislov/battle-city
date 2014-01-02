/**
 * @author arlechin
 * Date: 09.08.12
 * Time: 16:38
 */
package ru.arlevoland.bc.game.keyboard.key {

public class KeyBinding {

    public function KeyBinding(command:KeyCommand, keys:Array):void {
        _command = command;
        _keys = keys;
    }

    public function getCommand():KeyCommand {
        return _command;
    }

    public function getKeys():Array {
        return _keys;
    }

    private var _command:KeyCommand;
    private var _keys:Array;

}
}
