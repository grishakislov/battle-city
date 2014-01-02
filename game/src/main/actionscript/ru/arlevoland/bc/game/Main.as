﻿/**
 * @author arlechin
 * @author antivoland
 */
package ru.arlevoland.bc.game {
import flash.display.Sprite;
import flash.display.Stage;

import ru.arlevoland.bc.game.bcb.BCBLoader;
import ru.arlevoland.bc.game.core.debug.LogManager;
import ru.arlevoland.bc.game.core.debug.LogMessageType;
import ru.arlevoland.bc.game.keyboard.KeyboardManager;
import ru.arlevoland.bc.game.sfx.SfxManager;
import ru.arlevoland.bc.game.time.Ticker;

[SWF(width="768", height="672", frameRate="60", backgroundColor="#000000")]
public class Main extends Sprite {
    private const msg:String = "Прикольный у тебя декомпилятор.";

    public function Main() {
        initLogManager();

        App.logManager.showMessage(LogMessageType.INIT_GAME);

        Ticker.initialize(stage);
        instance = this;
        scaleX = GameSettings.WORLD_SCALE;
        scaleY = GameSettings.WORLD_SCALE;

        initKeyboardManager();
        initBCBLoader();

        initSFXManager();
        /* TODO: fix'n'uncomment
        initPowerOnEffect();

        initAssetManager();
        initLevelDataManager();

        initTitle();

        initBattleStage();

        initGameController();
        */
    }

    private static function initLogManager():void {
        App.logManager = new LogManager();
        App.logManager.showMessage(LogMessageType.LOG_MANAGER_INITIALIZED);
    }

    private static function initKeyboardManager():void {
        App.keyboardManager = new KeyboardManager();
        App.logManager.showMessage(LogMessageType.INIT_KEYBOARD_MANAGER);
        App.keyboardManager.initialize();
    }

    private static function initBCBLoader():void {
        App.bcbLoader = new BCBLoader();
        App.logManager.showMessage(LogMessageType.INIT_BCB_LOADER);
        App.bcbLoader.initialize();
    }

    public function initSFXManager():void {
        App.sfxManager = new SfxManager();
        App.logManager.showMessage(LogMessageType.INIT_SFX_MANAGER);
    }

    /* TODO: fix'n'uncomment
    public function initPowerOnEffect():void {
        App.powerOnEffect = new PowerOnEffect();
        App.logManager.showMessage(LogMessageType.INIT_POWER_ON);
        addChild(App.powerOnEffect);
    }

    private static function initLevelDataManager():void {
        App.levelDataManager = new LevelDataManager();
        App.logManager.showMessage(LogMessageType.INIT_LEVEL_DATA_MANAGER);
        App.levelDataManager.initialize();
    }

    private static function initGameController():void {
        App.gameController = new GameScreenController();
        App.logManager.showMessage(LogMessageType.INIT_GAME_CONTROLLER);
        App.gameController.initialize();
    }

    private function initAssetManager():void {
        App.assetManager = new AssetManager();
        App.logManager.showMessage(LogMessageType.INIT_ASSET_MANAGER);
        App.assetManager.initialize();
    }

    public function initTitle():void {
        App.title = new Title();
        addChild(App.title);
    }

    public function initBattleStage():void {
        App.battleStage = new BattleScreen();
        App.logManager.showMessage(LogMessageType.INIT_BATTLE_STAGE);
        addChild(App.battleStage);
    }

    public function initDevTools():void {
        App.devTools = new DevTools();
        App.devTools.initialize();
        addChild(App.devTools);
    }

    public static function showPauseScreen():void {
        App.viewer = new Viewer();
        App.viewer.initialize();
        instance.addChild(App.viewer);
    }

    public static function removePauseScreen():void {
        App.viewer.stop();
        instance.removeChild(App.viewer);
        App.viewer = null;
    }
    */

    public static function getStage():Stage {
        return instance.stage;
    }

    private static var instance:Main;
}
}
