package ru.arlevoland.bc.game.battle_screen.world {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;
import ru.arlevoland.bc.game.battle_screen.BattleStageDrawMode;
import ru.arlevoland.bc.game.battle_screen.MapLoader;
import ru.arlevoland.bc.game.battle_screen.tank.ActorDirection;
import ru.arlevoland.bc.game.bcb.model.LevelData;

public class WorldImpactLayer extends Sprite {

    private static const DESTROYABLE_TILES:Array = [
        "BRICK_FULL",
        "BRICK_TOP",
        "BRICK_RIGHT",
        "BRICK_DOWN",
        "BRICK_LEFT"
    ];

    public function initialize(levelId:uint):void {
        visual = MapLoader.drawStageToBitmap(levelId, BattleStageDrawMode.MAIN);
        data = App.levelDataManager.getLevelDataByID(levelId);
        createImpactMap();
        addChild(visual);
    }

    private function createImpactMap():void {

    }

    public function applyDestruction(worldPoint:Point, direction:ActorDirection):void {
        /*
         //проверяем, кирпич ли там
         //если нет, то уходим

         если да, то меняем тайл
         если кирпич разрушен, то изменяем таблицу столкновений
         */
        var mapPoint:Point = new Point(Math.floor(worldPoint.x / 2), Math.floor(worldPoint.y / 2));
        var currentTile:String = MapLoader.getTileByID(data.getDataAt(mapPoint.x, mapPoint.y)).getName();

        if (!isDestroyable(currentTile)) {
            return;
        }


    }

    private function isDestroyable(tileName:String):Boolean {
        return DESTROYABLE_TILES.indexOf(tileName) > -1;
    }

    private function redrawTileAt(coords:Point, tile:TileAsset):void {
        var rect:Rectangle = new Rectangle(0, 0, GameSettings.TILE_SIZE, GameSettings.TILE_SIZE);
        coords.x *= GameSettings.TILE_SIZE;
        coords.y *= GameSettings.TILE_SIZE;
        visual.bitmapData.copyPixels(tile.getBitmap().bitmapData, rect, coords);
    }

    private function getTile(name:String):TileAsset {
        return App.assetManager.getTileAsset(name);
    }

    private var destroyedTiles:Array = [];
    private var visual:Bitmap;
    private var data:LevelData;
    private var water:WorldWaterLayer;

}
}
