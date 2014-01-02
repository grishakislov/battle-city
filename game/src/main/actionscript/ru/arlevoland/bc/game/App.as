/**
 * @author arlechin
 * @author antivoland
 */
package ru.arlevoland.bc.game {
import ru.arlevoland.bc.game.bcb.BCBLoader;
import ru.arlevoland.bc.game.controller.PipelineManager;
import ru.arlevoland.bc.game.core.assets.AssetManager;
import ru.arlevoland.bc.game.core.assets.LevelDataManager;
import ru.arlevoland.bc.game.core.debug.LogManager;
import ru.arlevoland.bc.game.core.debug.viewers.Viewer;
import ru.arlevoland.bc.game.keyboard.KeyboardManager;
import ru.arlevoland.bc.game.power_on.PowerOnEffect;
import ru.arlevoland.bc.game.sfx.SfxManager;

public class App {
    public static var keyboardManager:KeyboardManager;
    public static var viewer:Viewer;
    public static var logManager:LogManager;
    public static var bcbLoader:BCBLoader;
    // public static var gameController:GameScreenController; // TODO: uncomment
    public static var pipelineManager:PipelineManager;

    public static var sfxManager:SfxManager;

    public static var powerOnEffect:PowerOnEffect;
    // public static var title:Title; // TODO: uncomment

    // public static var battleStage:BattleScreen; // TODO: uncomment
    // public static var stageSprite:Bitmap; // TODO: uncomment
    public static var assetManager:AssetManager;
    public static var levelDataManager:LevelDataManager;
    // public static var devTools:DevTools; // TODO: uncomment

    // public static var battleground:Battleground; // TODO: uncomment
}
}
