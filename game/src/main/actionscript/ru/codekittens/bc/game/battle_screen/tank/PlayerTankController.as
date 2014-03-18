package ru.codekittens.bc.game.battle_screen.tank {
import flash.events.EventDispatcher;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.keyboard.KeyboardManagerEvent;
import ru.codekittens.bc.game.keyboard.key.KeyCommand;

internal class PlayerTankController extends EventDispatcher {

    public function initialize():void {
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_UP, onKeyUp);
    }

    private function onKeyDown(e:KeyboardManagerEvent):void {
        if (currentCommand == e.getCommand()) return;

        if (e.getCommand() != KeyCommand.FIRE) {
            currentCommand = e.getCommand();
            dispatchEvent(new TankControllerEvent(TankControllerEvent.START, currentCommand));
        } else {
            //TODO: double command
            dispatchEvent(new TankControllerEvent(TankControllerEvent.START, e.getCommand()));
        }
    }

    private function onKeyUp(e:KeyboardManagerEvent):void {
        if (currentCommand == null) return;

        if (e.getCommand() != KeyCommand.FIRE) {
            if ((e.getCommand()) == currentCommand) {
                dispatchEvent(new TankControllerEvent(TankControllerEvent.STOP, e.getCommand()));
                currentCommand = null;
            }
        } else {
            dispatchEvent(new TankControllerEvent(TankControllerEvent.STOP, e.getCommand()));
        }
    }

    private var currentCommand:KeyCommand;

}
}
