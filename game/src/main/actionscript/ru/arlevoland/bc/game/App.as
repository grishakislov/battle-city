package ru.arlevoland.bc.game {
import flash.events.EventDispatcher;

import ru.arlevoland.bc.game.battle_screen.BattleScreen;
import ru.arlevoland.bc.game.battle_screen.world.World;
import ru.arlevoland.bc.game.screen_manager.GameScreenManager;
import ru.arlevoland.bc.game.core.assets.AssetManager;
import ru.arlevoland.bc.game.core.assets.LevelDataManager;
import ru.arlevoland.bc.game.core.debug.DevTools;
import ru.arlevoland.bc.game.core.debug.LogManager;
import ru.arlevoland.bc.game.core.debug.viewers.Viewer;
import ru.arlevoland.bc.game.keyboard.KeyboardManager;
import ru.arlevoland.bc.game.power_on.PowerOnEffect;
import ru.arlevoland.bc.game.settings.SettingsManager;
import ru.arlevoland.bc.game.sfx.SfxManager;
import ru.arlevoland.bc.game.title.Title;

public class App {
    public static var keyboardManager:KeyboardManager;
    public static var viewer:Viewer;
    public static var logManager:LogManager;
    public static var settingsManager:SettingsManager;
    public static var screenManager:GameScreenManager;
    public static var dispatcher:EventDispatcher;

    public static var sfxManager:SfxManager;

    public static var powerOnEffect:PowerOnEffect;
    public static var title:Title;

    public static var battleStage:BattleScreen;
    // public static var stageSprite:Bitmap; // TODO: uncomment
    public static var assetManager:AssetManager;
    public static var levelDataManager:LevelDataManager;
    public static var devTools:DevTools;

    public static var battleground:World;
}
}
