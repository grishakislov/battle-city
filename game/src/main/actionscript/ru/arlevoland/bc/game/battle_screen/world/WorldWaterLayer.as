package ru.arlevoland.bc.game.battle_screen.world {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.battle_screen.BattleStageDrawMode;
import ru.arlevoland.bc.game.battle_screen.map_loader.MapLoader;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;
import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.time.TickerEvent;

public class WorldWaterLayer extends Sprite {

    private static const WATER_FRAMES_SKIP:uint = 32;//TODO: сравнить со скоростью в оригинале

    public function WorldWaterLayer() {
        Ticker.addEventListener(TickerEvent.TICK, onTick);
    }

    public function initialize(levelId:uint):void {
        framesPassed = 0;
        key = false
        this.levelId = levelId;
        visual.bitmapData.dispose();
        visual = MapLoader.drawStageToBitmap(levelId, BattleStageDrawMode.WATER,
                App.assetManager.copyTileAsset("WATER_FULL"));
        addChild(visual);
    }

    private function onTick(e:TickerEvent):void {
        framesPassed++;
        var currentWaterTile:TileAsset;
        if (framesPassed >= WATER_FRAMES_SKIP) {
            111
            //TODO: изменение палитры тайла, а не перерисовка
            currentWaterTile = key ? App.assetManager.getTileAsset("WATER_FULL_1")
                    : App.assetManager.getTileAsset("WATER_FULL_2");
            removeChild(visual);
            visual = MapLoader.drawStageToBitmap(levelId, BattleStageDrawMode.WATER, currentWaterTile);
            addChild(visual);
            key = !key;
            framesPassed = 0;
        }
    }

    private var levelId:uint;
    private var visual:Bitmap = new Bitmap(new BitmapData(
                    GameSettings.MAP_TILE_SIZE * GameSettings.WORLD_WIDTH,
                    GameSettings.MAP_TILE_SIZE * GameSettings.WORLD_HEIGHT,
                    true, 0x00FF0000));
    private var key:Boolean = false;
    private var framesPassed:uint = 0;
}
}
