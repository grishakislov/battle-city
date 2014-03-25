package ru.codekittens.bc.game.battle_screen.world {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.BattleStageDrawMode;
import ru.codekittens.bc.game.battle_screen.map_loader.MapLoader;
import ru.codekittens.bc.game.core.animation.FrameSkipObject;
import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.time.Ticker;

public class WorldWaterLayer extends FrameSkipObject {

    private static const WATER_FRAMES_SKIP:uint = 32;//TODO: сравнить со скоростью в оригинале

    public function WorldWaterLayer() {
        super(null, WATER_FRAMES_SKIP)
    }

    override public function togglePause():void {
        super.togglePause();
    }

    public function initialize(levelId:uint):void {
        key = false;
        this.levelId = levelId;
        visual.bitmapData.dispose();
        visual = MapLoader.drawStageToBitmap(levelId, BattleStageDrawMode.WATER,
                App.assetManager.copyTileAsset("WATER_FULL"));
        addChild(visual);
    }

    override protected function onAnimation():void {
        var currentWaterTile:TileAsset;
        //TODO: изменение палитры тайла, а не перерисовка
        currentWaterTile = key ? App.assetManager.getTileAsset("WATER_FULL_1")
                               : App.assetManager.getTileAsset("WATER_FULL_2");
        removeChild(visual);
        visual = MapLoader.drawStageToBitmap(levelId, BattleStageDrawMode.WATER, currentWaterTile);
        addChild(visual);
        key = !key;
    }

    private var levelId:uint;
    private var visual:Bitmap = new Bitmap(new BitmapData(
                    GameSettings.MAP_TILE_SIZE * GameSettings.WORLD_WIDTH,
                    GameSettings.MAP_TILE_SIZE * GameSettings.WORLD_HEIGHT,
                    true, 0x00FF0000));
    private var key:Boolean = false;
}
}
