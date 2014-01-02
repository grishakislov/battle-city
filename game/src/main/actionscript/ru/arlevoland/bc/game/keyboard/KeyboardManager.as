/**
 * @author arlechin
 * Date: 09.08.12
 * Time: 15:44
 */
package ru.arlevoland.bc.game.keyboard {
import flash.events.EventDispatcher;
import flash.events.KeyboardEvent;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.game.keyboard.key.KeyCommand;
import ru.arlevoland.bc.game.keyboard.key.KeyManager;

public class KeyboardManager extends EventDispatcher {

    public function initialize():void {
        Main.getStage().addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        Main.getStage().addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        _keyManager = new KeyManager();
        _keyManager.initialize();
    }

    public function bindKey(command:KeyCommand, keyCodes:Array):void {
        //TODO: Разработать новый механизм ошибок

    }

    private function onKeyDown(e:KeyboardEvent):void {
        var command:KeyCommand = _keyManager.getCommandByKey(e.keyCode);
        if (command != null) dispatchEvent(new KeyboardManagerEvent(KeyboardManagerEvent.KEY_DOWN, command));
    }

    private function onKeyUp(e:KeyboardEvent):void {
        var command:KeyCommand = _keyManager.getCommandByKey(e.keyCode);
        if (command != null) dispatchEvent(new KeyboardManagerEvent(KeyboardManagerEvent.KEY_UP, command));
    }

    private var _keyManager:KeyManager;

}
}
