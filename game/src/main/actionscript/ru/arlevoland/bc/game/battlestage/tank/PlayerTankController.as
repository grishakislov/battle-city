/**
 * @author arlechin
 * Date: 09.08.12
 * Time: 17:07
 */
package ru.arlevoland.bc.game.battlestage.tank {
import flash.events.EventDispatcher;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.game.keyboard.KeyboardManagerEvent;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;

internal class PlayerTankController extends EventDispatcher {

    public function initialize():void {
        Main.getKeyboardManager().addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
        Main.getKeyboardManager().addEventListener(KeyboardManagerEvent.KEY_UP, onKeyUp);
    }

    private function onKeyDown(e:KeyboardManagerEvent):void {
        if (currentCommand == e.getCommand()) return;

        if (e.getCommand() != KeyCommand.FIRE) {
            currentCommand = e.getCommand();
            dispatchEvent(new PlayerTankControllerEvent(PlayerTankControllerEvent.START, currentCommand));
        } else {
            dispatchEvent(new PlayerTankControllerEvent(PlayerTankControllerEvent.START, e.getCommand()));
        }
    }

    private function onKeyUp(e:KeyboardManagerEvent):void {
        if (currentCommand == null) return;

        if (e.getCommand() != KeyCommand.FIRE) {
            if ((e.getCommand()) == currentCommand) {
                dispatchEvent(new PlayerTankControllerEvent(PlayerTankControllerEvent.STOP, e.getCommand()));
                currentCommand = null;
            }
        } else {
            dispatchEvent(new PlayerTankControllerEvent(PlayerTankControllerEvent.STOP, e.getCommand()));
        }
    }

    private var currentCommand:KeyCommand;

}
}
