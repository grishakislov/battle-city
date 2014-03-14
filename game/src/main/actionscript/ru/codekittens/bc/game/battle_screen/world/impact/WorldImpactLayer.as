package ru.codekittens.bc.game.battle_screen.world.impact {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.BattleStageDrawMode;
import ru.codekittens.bc.game.battle_screen.map_loader.MapLoader;
import ru.codekittens.bc.game.battle_screen.tank.ActorDirection;
import ru.codekittens.bc.game.battle_screen.world.*;
import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.settings.model.LevelData;

public class WorldImpactLayer extends Sprite {

    private static const DESTROYABLE_TILES:Array = [
        "BRICK_FULL",
        "BRICK_TOP",
        "BRICK_RIGHT",
        "BRICK_DOWN",
        "BRICK_LEFT"
    ];

    public function initialize(levelId:uint):void {
        impactMap = MapLoader.createImpactMap(levelId);
        visual = MapLoader.drawStageToBitmap(levelId, BattleStageDrawMode.MAIN);
        data = App.levelDataManager.getLevelDataByID(levelId);
        addChild(visual);
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

    public function redrawTileAt(x:uint, y:uint):void {
        var entity:ImpactEntity = impactMap.getEntity(x,y);
        if (entity.getTileName() != "HQ" && entity.getTileName() != "BROKEN_HQ") {
            redrawTile(new Point(x,y), App.assetManager.getTileAsset(entity.getTileName()));
        }
    }

    private function redrawTile(coords:Point, tile:TileAsset):void {
        var rect:Rectangle = new Rectangle(0, 0, GameSettings.TILE_SIZE, GameSettings.TILE_SIZE);
        coords.x *= GameSettings.TILE_SIZE;
        coords.y *= GameSettings.TILE_SIZE;
        visual.bitmapData.copyPixels(tile.getBitmap().bitmapData, rect, coords);
    }

    private function getTile(name:String):TileAsset {
        return App.assetManager.getTileAsset(name);
    }

    public function getImpactMap():ImpactMap {
        return impactMap;
    }

    public function getVisual():Bitmap {
        return visual;
    }

    private var impactMap:ImpactMap;
    private var visual:Bitmap;
    private var data:LevelData;
    private var water:WorldWaterLayer;

}
}