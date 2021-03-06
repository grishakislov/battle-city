﻿package ru.codekittens.bc.game {
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.EventDispatcher;

import ru.codekittens.bc.game.battle_screen.BattleScreen;
import ru.codekittens.bc.game.core.assets.AssetManager;
import ru.codekittens.bc.game.core.assets.LevelDataManager;
import ru.codekittens.bc.game.core.debug.LogManager;
import ru.codekittens.bc.game.core.debug.LogMessageType;
import ru.codekittens.bc.game.core.debug.viewers.Viewer;
import ru.codekittens.bc.game.events.TogglePauseEvent;
import ru.codekittens.bc.game.keyboard.KeyboardManager;
import ru.codekittens.bc.game.power_on.PowerOnEffect;
import ru.codekittens.bc.game.screen_manager.GameScreenManager;
import ru.codekittens.bc.game.settings.SettingsManager;
import ru.codekittens.bc.game.sfx.GameSoundManager;
import ru.codekittens.bc.game.time.Ticker;
import ru.codekittens.bc.game.title.Title;

[SWF(width="768", height="672", frameRate="64", backgroundColor="#000000")]
public class Main extends Sprite {
    private const msg:String = "Прикольный у тебя декомпилятор.";

    public function Main() {
        initLogManager();
        initSettingsManager();

        App.logManager.showMessage(LogMessageType.INIT_GAME);

        Ticker.initialize(stage);
        instance = this;
        scaleX = GameSettings.WORLD_SCALE;
        scaleY = GameSettings.WORLD_SCALE;

        initKeyboardManager();

        initSFXManager();
        initDispatcher();
        initPowerOnEffect();

        initAssetManager();
        initLevelDataManager();

        initTitle();

        initBattleStage();

        initGameController();

        App.dispatcher.addEventListener(TogglePauseEvent.PAUSE, onPause);
    }

    private function onPause(event:TogglePauseEvent):void {
        paused = !paused;
        if (paused) {
            Main.showPauseScreen();
        } else {
            Main.removePauseScreen();
        }
    }

    private function initSettingsManager():void {
        App.settingsManager = new SettingsManager();
        App.logManager.showMessage(LogMessageType.INIT_SETTINGS);
        App.settingsManager.initialize();
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

    public function initSFXManager():void {
        App.sfxManager = new GameSoundManager();
        App.sfxManager.initialize();
        App.logManager.showMessage(LogMessageType.INIT_SFX_MANAGER);
    }

    public function initDispatcher():void {
        App.dispatcher = new EventDispatcher();
        App.logManager.showMessage(LogMessageType.INIT_PIPELINE);
    }

    public function initPowerOnEffect():void {
        App.powerOnEffect = new PowerOnEffect();
        App.logManager.showMessage(LogMessageType.INIT_POWER_ON);
        addChild(App.powerOnEffect);
    }

    private function initAssetManager():void {
        App.assetManager = new AssetManager();
        App.logManager.showMessage(LogMessageType.INIT_ASSET_MANAGER);
        App.assetManager.initialize();
    }

    private static function initLevelDataManager():void {
        App.levelDataManager = new LevelDataManager();
        App.logManager.showMessage(LogMessageType.INIT_LEVEL_DATA_MANAGER);
        App.levelDataManager.initialize();
    }

    public function initTitle():void {
        App.title = new Title();
        App.logManager.showMessage(LogMessageType.INIT_TITLE);
        addChild(App.title);
    }

    public function initBattleStage():void {
        App.battleStage = new BattleScreen();
        App.logManager.showMessage(LogMessageType.INIT_BATTLE_STAGE);
        addChild(App.battleStage);
    }

    private static function initGameController():void {
        App.screenManager = new GameScreenManager();
        App.logManager.showMessage(LogMessageType.INIT_GAME_CONTROLLER);
        App.screenManager.initialize();
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

    public static function getStage():Stage {
        return instance.stage;
    }

    private var paused:Boolean;
    private static var instance:Main;
}
}
