package ru.arlevoland.bc.game.screen_manager {
import flash.display.Sprite;

import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.core.debug.LogMessageType;
import ru.arlevoland.bc.game.events.GameEvent;
import ru.arlevoland.bc.game.keyboard.KeyboardManagerEvent;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;
import ru.arlevoland.bc.game.power_on.PowerOnEffect;
import ru.arlevoland.bc.game.title.Title;

public class GameScreenManager extends Sprite {
    public function GameScreenManager() {

    }

    public function initialize():void {
        App.powerOnEffect.run();
        currentGameScreen = App.powerOnEffect;
        App.logManager.showMessage(LogMessageType.POWER_ON_EFFECT_STARTED);

        App.dispatcher.addEventListener(GameEvent.SCREEN_FINISHED, onFinish)
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }

    private function onFinish(e:GameEvent):void {

        if (e.getSrc() is PowerOnEffect) {
            App.powerOnEffect.destroy();
            App.logManager.showMessage(LogMessageType.POWER_ON_EFFECT_DESTROYED);
            startTitle(e.getData());
        }

        if (e.getSrc() is Title) {
            var selectedMode:uint = App.title.destroy();
            App.logManager.showMessage(LogMessageType.BATTLE_STAGE_STARTED);
            startBattleStageWithMode(selectedMode);
        }
    }

    private function startTitle(data:* = undefined):void {
        App.title.initialize();
        App.title.run();
        currentGameScreen = App.title;
        App.logManager.showMessage(LogMessageType.TITLE_STARTED);
    }

    private function continueBattleStage(levelId:uint):void {
        App.battleStage.initialize();
        App.battleStage.run(levelId);
        currentGameScreen = App.battleStage;
    }

    private function startBattleStageWithMode(battleStageMode:uint):void {
        App.battleStage.initialize();
        App.battleStage.runWithMode(battleStageMode);
        currentGameScreen = App.battleStage;
    }

    private function onKeyDown(e:KeyboardManagerEvent):void {
        switch (e.getCommand()) {
            case KeyCommand.PAUSE:
                currentGameScreen.pause();
                break;
        }
    }

    private var currentGameScreen:IGameScreen;

}
}
