package ru.codekittens.bc.game.battle_screen.tank.player {
import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.battle_screen.tank.*;
import ru.codekittens.bc.game.keyboard.KeyboardManagerEvent;
import ru.codekittens.bc.game.keyboard.key.KeyCommand;

internal class PlayerTankController extends BaseTankController {

    private var currentCommand:KeyCommand;

    override public function initialize():void {
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_UP, onKeyUp);
    }

    private function onKeyDown(e:KeyboardManagerEvent):void {
        if (currentCommand == e.getCommand()) return;

        if (e.getCommand() != KeyCommand.FIRE) {
            currentCommand = e.getCommand();
            start(currentCommand);
        } else {
            //TODO: double command
            start(e.getCommand());
        }
    }

    private function onKeyUp(e:KeyboardManagerEvent):void {
        if (currentCommand == null) return;

        if (e.getCommand() != KeyCommand.FIRE) {
            if ((e.getCommand()) == currentCommand) {
                stop(e.getCommand());

                currentCommand = null;
            }
        } else {
            stop(e.getCommand());
        }
    }


}
}
