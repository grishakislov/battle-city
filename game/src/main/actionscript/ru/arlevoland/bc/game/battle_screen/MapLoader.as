package ru.arlevoland.bc.game.battle_screen {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;
import ru.arlevoland.bc.game.battle_screen.world.ActorType;
import ru.arlevoland.bc.game.bcb.model.LevelData;

public class MapLoader {

    private static const TILE_ORDER:Array = [
        "BRICK_RIGHT",
        "BRICK_BOTTOM",
        "BRICK_LEFT",
        "BRICK_TOP",
        "BRICK_FULL",
        "METAL_RIGHT",
        "METAL_BOTTOM",
        "METAL_LEFT",
        "METAL_TOP",
        "METAL_FULL",
        "WATER_FULL",
        "TREE_FULL",
        "ICE_FULL",
        "ASPHALT_FULL"
    ];

    private static const COLLISION_TILES:Array = [
        "BRICK_RIGHT",
        "BRICK_BOTTOM",
        "BRICK_LEFT",
        "BRICK_TOP",
        "BRICK_FULL",
        "METAL_RIGHT",
        "METAL_BOTTOM",
        "METAL_LEFT",
        "METAL_TOP",
        "METAL_FULL",
        "ICE_FULL",
        "WATER_FULL"
    ];

    public static function drawStageToBitmap(stageId:uint, mode:String, waterTileAsset:TileAsset = null):Bitmap {

        var w:uint = GameSettings.WORLD_WIDTH;
        var h:uint = GameSettings.WORLD_HEIGHT;
        var y:int;
        var x:int;

        var tileSize:uint = GameSettings.MAP_TILE_SIZE;
        var resultBitmapData:BitmapData = new BitmapData(w * tileSize, h * tileSize, true, 0x000000);
        var resultBitmap:Bitmap = new Bitmap(resultBitmapData);
        var data:LevelData = App.levelDataManager.getLevelDataByID(stageId);
        var currentTile:TileAsset;

        for (y = 0; y < h; y++) {
            for (x = 0; x < w; x++) {
                switch (mode) {
                    case BattleStageDrawMode.FULL:
                        currentTile = getTileByID(data.getDataAt(x, y));
                        resultBitmapData.copyPixels(currentTile.getBitmap().bitmapData, new Rectangle(0, 0, tileSize, tileSize), new Point(x * tileSize, y * tileSize));
                        break;

                    case BattleStageDrawMode.MAIN:
                        if (COLLISION_TILES.indexOf(TILE_ORDER[data.getDataAt(x, y)]) > -1) {
                            currentTile = getTileByID(data.getDataAt(x, y));
                            if (currentTile.getName() != "WATER_FULL") {
                                resultBitmapData.copyPixels(currentTile.getBitmap().bitmapData, new Rectangle(0, 0, tileSize, tileSize), new Point(x * tileSize, y * tileSize));
                            }
                        }
                        break;

                    case BattleStageDrawMode.TREES:
                        if (TILE_ORDER[data.getDataAt(x, y)] == "TREE_FULL") {
                            currentTile = getTileByID(data.getDataAt(x, y));
                            resultBitmapData.copyPixels(currentTile.getBitmap().bitmapData, new Rectangle(0, 0, tileSize, tileSize), new Point(x * tileSize, y * tileSize));
                        }
                        break;

                    case BattleStageDrawMode.NO_WATER:
                        if (TILE_ORDER[data.getDataAt(x, y)] != "WATER_FULL") {
                            currentTile = getTileByID(data.getDataAt(x, y));
                            resultBitmapData.copyPixels(currentTile.getBitmap().bitmapData, new Rectangle(0, 0, tileSize, tileSize), new Point(x * tileSize, y * tileSize));
                        }
                        break;

                    case BattleStageDrawMode.WATER:
                        if (TILE_ORDER[data.getDataAt(x, y)] == "WATER_FULL") {
                            resultBitmapData.copyPixels(waterTileAsset.getBitmap().bitmapData, new Rectangle(0, 0, tileSize, tileSize), new Point(x * tileSize, y * tileSize));
                        }
                        break;
                }
            }
        }
        return resultBitmap;
    }

    public static function getTileByID(tileID:uint):TileAsset {
        return App.assetManager.getTileAsset(TILE_ORDER[tileID]);
    }

}
}