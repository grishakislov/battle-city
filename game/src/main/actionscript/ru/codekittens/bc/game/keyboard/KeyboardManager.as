package ru.codekittens.bc.game.keyboard {
import flash.events.EventDispatcher;
import flash.events.KeyboardEvent;

import ru.codekittens.bc.game.Main;
import ru.codekittens.bc.game.keyboard.key.KeyCommand;
import ru.codekittens.bc.game.keyboard.key.KeyManager;

public class KeyboardManager extends EventDispatcher {

    public function initialize():void {
        Main.getStage().addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        Main.getStage().addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        keyManager = new KeyManager();
        keyManager.initialize();
    }

    public function bindKey(command:KeyCommand, keyCodes:Array):void {
        //TODO: Разработать новый механизм ошибок

    }

    private function onKeyDown(e:KeyboardEvent):void {
        var command:KeyCommand = keyManager.getCommandByKey(e.keyCode);
        if (command != null) dispatchEvent(new KeyboardManagerEvent(KeyboardManagerEvent.KEY_DOWN, command));
    }

    private function onKeyUp(e:KeyboardEvent):void {
        var command:KeyCommand = keyManager.getCommandByKey(e.keyCode);
        if (command != null) dispatchEvent(new KeyboardManagerEvent(KeyboardManagerEvent.KEY_UP, command));
    }

    private var keyManager:KeyManager;

}
}
