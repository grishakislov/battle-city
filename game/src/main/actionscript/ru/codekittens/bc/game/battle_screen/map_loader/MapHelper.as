package ru.codekittens.bc.game.battle_screen.map_loader {
import flash.display.BitmapData;
import flash.geom.Point;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.world.impact.ImpactEntity;
import ru.codekittens.bc.game.battle_screen.world.impact.ImpactMap;
import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.settings.model.FitData;

public class MapHelper {

    [ArrayElementType("flash.geom.Point")]
    private static const WALL_COORDS:Array = [
            new Point(11,25),
            new Point(11,24),
            new Point(11,23),
            new Point(12,23),
            new Point(13,23),
            new Point(14,23),
            new Point(14,24),
            new Point(14,25)
    ];

    [ArrayElementType("flash.geom.Point")]
    private static const EAGLE_COORDS:Array = [
        new Point(12,25),
        new Point(12,24),
        new Point(13,25),
        new Point(13,24)
    ];

    public static function drawEagle(map:BitmapData):void {
        var tileSize:uint = GameSettings.TILE_SIZE;
        var eagle:BitmapData = App.assetManager.getTileAsset("HQ").getBitmap().bitmapData;
        map.copyPixels(eagle, eagle.rect, new Point(12 * tileSize, 24 * tileSize));
    }

    public static function drawBrokenFlag(map:BitmapData):void {
        var tileSize:uint = GameSettings.TILE_SIZE;
        var flag:BitmapData = App.assetManager.getTileAsset("BROKEN_HQ").getBitmap().bitmapData;
        map.copyPixels(flag, flag.rect, new Point(12 * tileSize, 24 * tileSize));
    }


    public static function drawHqBricks(map:BitmapData):void {
        var brick:TileAsset = App.assetManager.getTileAsset("BRICK");
        drawWall(brick, map);
    }

    public static function drawHqMetal(map:BitmapData):void {
        var metal:TileAsset = App.assetManager.getTileAsset("METAL");
        drawWall(metal, map);
    }

    public static function setHqBricks(map:ImpactMap):void {
        var fitData:FitData;
        var tileName:String = "BRUSH_F";
        fitData = App.settingsManager.getFitDataByName(tileName);
        for (var i:int = 0; i < WALL_COORDS.length; i++) {
            map.setEntity(new ImpactEntity(tileName, fitData.brushIndex), WALL_COORDS[i]);
        }
    }

    public static function setHqMetal(map:ImpactMap):void {
        var tileName:String = "METAL";
        for (var i:int = 0; i < WALL_COORDS.length; i++) {
            map.setEntity(new ImpactEntity(tileName, 0), WALL_COORDS[i]);
        }
    }

    public static function setHqEagle(map:ImpactMap):void {
        var tileName:String = "HQ";
        for (var i:int = 0; i < EAGLE_COORDS.length; i++) {
            map.setEntity(new ImpactEntity(tileName, 0), EAGLE_COORDS[i]);
        }
    }


    private static function drawWall(asset:TileAsset, map:BitmapData):void {
        var tileSize:uint = GameSettings.TILE_SIZE;
        var bitmapData:BitmapData = asset.getBitmap().bitmapData;
        var currentPoint:Point;
        for (var i:int = 0; i < WALL_COORDS.length; i++) {
            currentPoint = WALL_COORDS[i].clone();
            currentPoint.x *= tileSize;
            currentPoint.y *= tileSize;
            map.copyPixels(bitmapData, bitmapData.rect, currentPoint);
        }
    }
}
}
