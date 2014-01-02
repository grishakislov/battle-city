/**
 * @author arlechin
 * Date: 30.05.12
 * Time: 6:28
 */
package ru.arlevoland.bc.game.battlestage {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.Colors;
import ru.arlevoland.bc.game.Main;
import ru.arlevoland.bc.game.GameScreen;
import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.battlestage.battle_stage_preloader.BattleStagePreloader;
import ru.arlevoland.bc.game.battlestage.battleground.Battleground;
import ru.arlevoland.bc.game.model.StageResult;

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
        //TODO: Вставить прелоадер, повесить хэндлер

//        initializeWorld(previousStageResult.getNextLevelId());
    }

    private function setBackgroundVisible(value:Boolean):void {
        stageBackground.visible = value;
        worldBackground.visible = value;
    }

    private function showPreloader():void {
        preloader = new BattleStagePreloader();
        addChild(preloader);
        preloader.initialize();
        preloader.run(previousStageResult.getNextLevelId())
    }


    override public function pause():void {
        super.pause();
        world.pause();
        //TODO: Pause
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

        world = new Battleground();
        world.initialize(levelId);
        world.initializePlayerTank(previousStageResult.playerLevel);
        worldBackground.addChild(world);
        App.battleground = world; // TODO: move to Main
    }

    private var preloader:BattleStagePreloader;

    private var previousStageResult:StageResult;

    private var stageBackground:MovieClip;
    private var worldBackground:MovieClip;
    private var world:Battleground;

}
}
