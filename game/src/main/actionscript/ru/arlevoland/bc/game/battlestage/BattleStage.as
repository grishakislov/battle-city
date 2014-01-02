/**
 * @author arlechin
 * Date: 30.05.12
 * Time: 6:28
 */
package ru.arlevoland.bc.game.battlestage {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;

import ru.arlevoland.bc.game.Colors;
import ru.arlevoland.bc.game.GameScreen;
import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.battlestage.battleground.Battleground;
import ru.arlevoland.bc.game.model.StageResult;

public class BattleStage extends GameScreen {

    private static const FIRST_LEVEL_ID:uint = 1;

    override public function initialize():void {
        initializeStageBackground();
        initializeWorldBackground();

    }

    override public function run(data:* = undefined):void {
        //TODO: Вставить прелоадер
        previousStageResult = StageResult(data);
        initializeWorld(previousStageResult.getNextLevelId());
    }


    override public function pause():void {
        super.pause();
        battleGround.pause();
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
        _stageBackground = new MovieClip();
        _stageBackground.addChild(sprite);
        addChild(_stageBackground);
    }

    private function initializeWorldBackground():void {
        var multiplier:uint = GameSettings.MAP_TILE_SIZE;
        var sprite:Bitmap = new Bitmap(new BitmapData(GameSettings.WORLD_WIDTH * multiplier,
                GameSettings.WORLD_HEIGHT * multiplier, false, Colors.SCENE_BG));
        _worldBackground = new MovieClip();
        _worldBackground.addChild(sprite);
        _worldBackground.x = GameSettings.WORLD_STAGE_INSET.x;
        _worldBackground.y = GameSettings.WORLD_STAGE_INSET.y;
        addChild(_worldBackground);
    }

    private function initializeWorld(levelId:uint):void {

        battleGround = new Battleground();
        battleGround.initialize(levelId);
        battleGround.initializePlayerTank(previousStageResult.playerLevel);
        _worldBackground.addChild(battleGround);
    }

    private var previousStageResult:StageResult;

    private var _stageBackground:MovieClip;
    private var _worldBackground:MovieClip;
    private var battleGround:Battleground;

}
}
