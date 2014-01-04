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
import ru.arlevoland.bc.game.battle_screen.tank.TankDirection;
import ru.arlevoland.bc.game.bcb.model.LevelData;

internal class WorldCollisionLayer extends Sprite {

    private static const DESTROYABLE_TILES:Array = [
        "BRICK_FULL",
        "BRICK_TOP",
        "BRICK_RIGHT",
        "BRICK_DOWN",
        "BRICK_LEFT"
    ];

    public function initialize(levelId:uint):void {
        _visual = MapLoader.drawStageToBitmap(levelId, BattleStageDrawMode.MAIN);
        _data = App.levelDataManager.getLevelDataByID(levelId);
        addChild(_visual);

    }

    public function applyDestruction(worldPoint:Point, direction:TankDirection):void {
        /*
         //проверяем, кирпич ли там
         //если нет, то уходим

         если да, то меняем тайл
         если кирпич разрушен, то изменяем таблицу столкновений
         */
        var mapPoint:Point = new Point(Math.floor(worldPoint.x / 2), Math.floor(worldPoint.y / 2));
        var currentTile:String = MapLoader.getTileByID(_data.getDataAt(mapPoint.x, mapPoint.y)).getName();
        var tileState:TileDestroyingState;
        if (!isDestroyable(currentTile)) {
            return;
        }

        tileState = findBroken(worldPoint);
        broke(direction, worldPoint, tileState);

    }

    private function isDestroyable(tileName:String):Boolean {
        return DESTROYABLE_TILES.indexOf(tileName) > -1;
    }

    private function findBroken(point:Point):TileDestroyingState {
        for each (var s:TileDestroyingState in _destroyedTiles) {
            if (s.coords == point) {
                return s;
            }
        }
        return null;
    }

    private function broke(direction:TankDirection, point:Point, state:TileDestroyingState):void {
        switch (direction) {
            case TankDirection.UP:
                if (state == null) {
                    redrawTileAt(point, getTile("BRUSH_3"));
                    addBrokenTile(TileDestroyingState.HALF, point);
                } else if (state.state == TileDestroyingState.HALF) {
                    redrawTileAt(state.coords, getTile("BRUSH_0"));
//                    deleteCollisionAt(state.coords);
                } else if (state.state == TileDestroyingState.FULL) {

                }
                break;
        }
    }

    private function addBrokenTile(state:String, coords:Point):void {
        _destroyedTiles.push(new TileDestroyingState(state, coords));
    }

    private function redrawTileAt(coords:Point, tile:TileAsset):void {
        var rect:Rectangle = new Rectangle(0, 0, GameSettings.TILE_SIZE, GameSettings.TILE_SIZE);
        coords.x *= GameSettings.TILE_SIZE;
        coords.y *= GameSettings.TILE_SIZE;
        _visual.bitmapData.copyPixels(tile.getBitmap().bitmapData, rect, coords);
    }

    private function getTile(name:String):TileAsset {
        return App.assetManager.getTileAsset(name);
    }

    private var _destroyedTiles:Array = [];
    private var _visual:Bitmap;
    private var _data:LevelData;
    private var _water:WorldWaterLayer;

}
}
