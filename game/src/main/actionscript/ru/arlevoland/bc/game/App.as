/**
 * @author arlechin
 * Date: 06.12.13
 * Time: 23:16
 */
package ru.arlevoland.bc.game {
import flash.display.Bitmap;

import ru.arlevoland.bc.game.battlestage.BattleScreen;
import ru.arlevoland.bc.game.battlestage.battleground.Battleground;
import ru.arlevoland.bc.game.bcb.BCBLoader;
import ru.arlevoland.bc.game.controller.GameScreenController;
import ru.arlevoland.bc.game.core.assets.AssetManager;
import ru.arlevoland.bc.game.core.assets.LevelDataManager;
import ru.arlevoland.bc.game.core.debug.DevTools;
import ru.arlevoland.bc.game.core.debug.LogManager;
import ru.arlevoland.bc.game.core.debug.viewers.Viewer;
import ru.arlevoland.bc.game.keyboard.KeyboardManager;
import ru.arlevoland.bc.game.power_on.PowerOnEffect;
import ru.arlevoland.bc.game.sfx.SfxManager;
import ru.arlevoland.bc.game.title.Title;

public class App {

    public static var keyboardManager:KeyboardManager;
    public static var viewer:Viewer;
    public static var logManager:LogManager;
    public static var bcbLoader:BCBLoader;
    public static var gameController:GameScreenController;

    public static var sfxManager:SfxManager;

    public static var powerOnEffect:PowerOnEffect;
    public static var title:Title;

    public static var battleStage:BattleScreen;
    public static var stageSprite:Bitmap;
    public static var assetManager:AssetManager;
    public static var levelDataManager:LevelDataManager;
    public static var devTools:DevTools;

    public static var battleground:Battleground;



}
}
