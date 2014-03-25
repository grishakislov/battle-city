package ru.codekittens.bc.game.battle_screen {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.Colors;
import ru.codekittens.bc.game.GameScreen;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.battle_stage_splash.BattleStageSplash;
import ru.codekittens.bc.game.battle_screen.world.World;
import ru.codekittens.bc.game.events.BattleScreenEvent;
import ru.codekittens.bc.game.model.StageResult;

public class BattleScreen extends GameScreen {

    private static const FIRST_LEVEL_ID:uint = 1;

    override public function initialize():void {
        initializeStageBackground();
        initializeWorldBackground();
    }

    override public function run(data:* = undefined):void {
        setBackgroundVisible(false);
        previousStageResult = StageResult(data);
        if (GameSettings.DEBUG) {
            setBackgroundVisible(true);
            initializeWorld(previousStageResult.getNextLevelId());
        } else {
            showPreloader();
            App.dispatcher.addEventListener(BattleScreenEvent.SPLASH_COMPLETED, onPreloaderCompleted);
            App.dispatcher.addEventListener(BattleScreenEvent.SPLASH_DESTROYED, onPreloaderDestroyed);
        }

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


    override public function togglePause():void {
        super.togglePause();
        if (preloader != null) {
            preloader.togglePause();
        }
        if (world != null) {
            world.togglePause();
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
        world.initializePlayerTank(previousStageResult.playerLevel, previousStageResult.score, previousStageResult.playerLives);
        worldBackground.addChild(world);
    }

    private var preloader:BattleStageSplash;

    private var previousStageResult:StageResult;

    private var stageBackground:MovieClip;
    private var worldBackground:MovieClip;
    private var world:World;

}
}
