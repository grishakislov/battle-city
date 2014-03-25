package ru.codekittens.bc.game {
import flash.events.EventDispatcher;

import ru.codekittens.bc.game.battle_screen.BattleScreen;
import ru.codekittens.bc.game.core.assets.AssetManager;
import ru.codekittens.bc.game.core.assets.LevelDataManager;
import ru.codekittens.bc.game.core.debug.LogManager;
import ru.codekittens.bc.game.core.debug.viewers.Viewer;
import ru.codekittens.bc.game.keyboard.KeyboardManager;
import ru.codekittens.bc.game.power_on.PowerOnEffect;
import ru.codekittens.bc.game.screen_manager.GameScreenManager;
import ru.codekittens.bc.game.settings.SettingsManager;
import ru.codekittens.bc.game.sfx.GameSoundManager;
import ru.codekittens.bc.game.title.Title;

public class App {

    public static var keyboardManager:KeyboardManager;
    public static var viewer:Viewer;
    public static var logManager:LogManager;
    public static var settingsManager:SettingsManager;
    public static var screenManager:GameScreenManager;
    public static var dispatcher:EventDispatcher;
    public static var sfxManager:GameSoundManager;
    public static var powerOnEffect:PowerOnEffect;
    public static var title:Title;
    public static var battleStage:BattleScreen;
    public static var assetManager:AssetManager;
    public static var levelDataManager:LevelDataManager;

}
}
