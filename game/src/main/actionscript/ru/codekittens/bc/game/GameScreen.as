package ru.codekittens.bc.game {
import ru.codekittens.bc.game.core.debug.GameError;
import ru.codekittens.bc.game.screen_manager.IGameScreen;
import ru.codekittens.bc.game.time.Ticker;

public class GameScreen extends GameObject implements IGameScreen {

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

    override public function destroy():* {
        GameError.notImplemented("destroy()");
    }


}
}
