package ru.arlevoland.bc.game.battlestage.world {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;
import ru.arlevoland.bc.game.battlestage.BattleStageDrawMode;
import ru.arlevoland.bc.game.battlestage.BattleStageLoader;
import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.time.TickerEvent;

public class WorldWaterLayer extends Sprite {

    private static const WATER_FRAMES_SKIP:uint = 32;//TODO: сравнить со скоростью в оригинале

    public function WorldWaterLayer() {
        Ticker.addEventListener(TickerEvent.TICK, onTick);
    }

    public function initialize(levelId:uint):void {
        _framesPassed = 0;
        _key = false
        _levelId = levelId;
        _visual.bitmapData.dispose();
        _visual = BattleStageLoader.drawStageToBitmap(_levelId, BattleStageDrawMode.WATER,
                Game.getAssetManager().copyTileAsset("WATER_FULL"));
        addChild(_visual);
    }

    private function onTick(e:TickerEvent):void {
        _framesPassed++;
        var currentWaterTile:TileAsset;
        if (_framesPassed >= WATER_FRAMES_SKIP) {
            currentWaterTile = _key ? Game.getAssetManager().getTileAsset("WATER_FULL_1")
                    : Game.getAssetManager().getTileAsset("WATER_FULL_2");
            removeChild(_visual);
            _visual = BattleStageLoader.drawStageToBitmap(_levelId, BattleStageDrawMode.WATER, currentWaterTile);
            addChild(_visual);
            _key = !_key;
            _framesPassed = 0;
        }
    }

    private var _levelId:uint;
    private var _visual:Bitmap = new Bitmap(new BitmapData(GameSettings.MAP_TILE_SIZE * GameSettings.WORLD_WIDTH,
            GameSettings.MAP_TILE_SIZE * GameSettings.WORLD_HEIGHT, true, 0x00FF0000));
    private var _key:Boolean = false;
    private var _framesPassed:uint = 0;
}
}
