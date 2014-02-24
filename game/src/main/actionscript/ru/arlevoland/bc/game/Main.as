package ru.arlevoland.bc.game {
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.EventDispatcher;

import ru.arlevoland.bc.game.battle_screen.BattleScreen;
import ru.arlevoland.bc.game.battle_screen.map_loader.MapLoader;
import ru.arlevoland.bc.game.battle_screen.world.impact.ImpactMap;

import ru.arlevoland.bc.game.core.assets.AssetManager;
import ru.arlevoland.bc.game.core.assets.LevelDataManager;
import ru.arlevoland.bc.game.core.debug.DevTools;
import ru.arlevoland.bc.game.core.debug.LogManager;
import ru.arlevoland.bc.game.core.debug.LogMessageType;
import ru.arlevoland.bc.game.core.debug.viewers.Viewer;
import ru.arlevoland.bc.game.keyboard.KeyboardManager;
import ru.arlevoland.bc.game.power_on.PowerOnEffect;
import ru.arlevoland.bc.game.screen_manager.GameScreenManager;
import ru.arlevoland.bc.game.settings.SettingsManager;
import ru.arlevoland.bc.game.sfx.SfxManager;
import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.title.Title;

[SWF(width="768", height="672", frameRate="60", backgroundColor="#000000")]
public class Main extends Sprite {
    private const msg:String = "Прикольный у тебя декомпилятор.";

    public function Main() {
        var a:uint = 0x3 & 0xC;
        !1;
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
        App.sfxManager = new SfxManager();
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

    public static function getStage():Stage {
        return instance.stage;
    }

    private static var instance:Main;
}
}
