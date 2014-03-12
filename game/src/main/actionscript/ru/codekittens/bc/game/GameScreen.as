package ru.codekittens.bc.game {
import ru.codekittens.bc.game.core.debug.GameError;
import ru.codekittens.bc.game.screen_manager.IGameScreen;

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
        if (paused) {
            Main.removePauseScreen();
        } else {
            Main.showPauseScreen();
        }
        App.sfxManager.pause();
        super.pause();
    }
}
}
