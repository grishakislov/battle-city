package ru.arlevoland.bc.game.battle_screen {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.Colors;
import ru.arlevoland.bc.game.Main;
import ru.arlevoland.bc.game.GameScreen;
import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.battle_screen.battle_stage_splash.BattleStageSplash;
import ru.arlevoland.bc.game.battle_screen.world.World;
import ru.arlevoland.bc.game.model.StageResult;
import ru.arlevoland.bc.game.screen_manager.GameEvent;

public class BattleScreen extends GameScreen {

    private static const FIRST_LEVEL_ID:uint = 1;

    override public function initialize():void {
        initializeStageBackground();
        initializeWorldBackground();
    }

    override public function run(data:* = undefined):void {
        setBackgroundVisible(false);
        previousStageResult = StageResult(data);
        showPreloader();
        App.dispatcher.addEventListener(BattleScreenEvent.SPLASH_COMPLETED, onPreloaderCompleted);
        App.dispatcher.addEventListener(BattleScreenEvent.SPLASH_DESTROYED, onPreloaderDestroyed);
    }

    private function onPreloaderCompleted(event:BattleScreenEvent):void {
        setBackgroundVisible(true);
        App.dispatcher.removeEventListener(BattleScreenEvent.SPLASH_COMPLETED, onPreloaderCompleted);
        initializeWorld(previousStageResult.getNextLevelId());
    }

    private function onPreloaderDestroyed(event:BattleScreenEvent):void {
        App.dispatcher.removeEventListener(BattleScreenEvent.SPLASH_DESTROYED, onPreloaderCompleted);
        preloader.destroy();
        preloader = null;
    }

    private function setBackgroundVisible(value:Boolean):void {
        stageBackground.visible = value;
        worldBackground.visible = value;
    }

    private function showPreloader():void {
        preloader = new BattleStageSplash();
        addChild(preloader);
        preloader.start(previousStageResult.getNextLevelId());
    }


    override public function pause():void {
        super.pause();
        if (preloader != null) {
            preloader.pause();
        }
        if (world != null) {
            world.pause();
        }
    }

    public function runWithMode(battleStageMode:uint):void {
        switch (battleStageMode) {
            case BattleStageMode.ONE_PLAYER:
                run(StageResult.createBlankStageResult());
                break;
        }
    }

    private function loadNextStage(stageResult:StageResult):void {

    }


    private function addHQ():void {

    }

    private function initializeStageBackground():void {
        var bitmapData:BitmapData = new BitmapData
                (GameSettings.NATIVE_NES_SCREEN_SIZE.x, GameSettings.NATIVE_NES_SCREEN_SIZE.y, false, Colors.MAIN_BG);
        var sprite:Bitmap = new Bitmap(bitmapData);
        stageBackground = new MovieClip();
        stageBackground.addChild(sprite);
        addChild(stageBackground);
    }

    private function initializeWorldBackground():void {
        var multiplier:uint = GameSettings.MAP_TILE_SIZE;
        var sprite:Bitmap = new Bitmap(new BitmapData(GameSettings.WORLD_WIDTH * multiplier,
                GameSettings.WORLD_HEIGHT * multiplier, false, Colors.SCENE_BG));
        worldBackground = new MovieClip();
        worldBackground.addChild(sprite);
        worldBackground.x = GameSettings.WORLD_STAGE_INSET.x;
        worldBackground.y = GameSettings.WORLD_STAGE_INSET.y;
        addChild(worldBackground);
    }

    private function initializeWorld(levelId:uint):void {

        world = new World();
        world.initialize(levelId);
        world.initializePlayerTank(previousStageResult.playerLevel);
        worldBackground.addChild(world);
        App.battleground = world; // TODO: move to Main
    }

    private var preloader:BattleStageSplash;

    private var previousStageResult:StageResult;

    private var stageBackground:MovieClip;
    private var worldBackground:MovieClip;
    private var world:World;

}
}