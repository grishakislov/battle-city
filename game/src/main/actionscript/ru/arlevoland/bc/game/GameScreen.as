/**
 * @author arlechin
 * Date: 08.07.12
 * Time: 23:20
 */
package ru.arlevoland.bc.game {
import ru.arlevoland.bc.game.controller.IGameScreen;
import ru.arlevoland.bc.game.core.debug.GameError;

public class GameScreen extends BaseScreen implements IGameScreen {

    public function GameScreen() {
        super();
    }

    //TODO: Не нужна
    public function initialize():void {
        GameError.notImplemented("initialize()");
    }

    public function run(data:* = undefined):void {
        GameError.notImplemented("run()");
    }

    public function destroy():* {
        GameError.notImplemented("destroy()");
    }

    override public function pause():void {
        if (_paused) {
            Main.removePauseScreen();
        } else {
            Main.showPauseScreen();
        }
        super.pause();
    }
}
}
