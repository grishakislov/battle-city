package ru.codekittens.bc.game.core.assets {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.core.assets.model.TileDictionary;
import ru.codekittens.bc.game.core.assets.model.TilePalette;
import ru.codekittens.bc.game.core.debug.GameError;
import ru.codekittens.bc.game.settings.model.BrushMap;
import ru.codekittens.bc.game.settings.model.Coord;
import ru.codekittens.bc.game.settings.model.FitData;
import ru.codekittens.bc.game.settings.model.TankFitData;

public class AssetManager {

    public function initialize():void {

        tiles = new Resources.TILES();
        tankTiles = new Resources.TANKS();

        fitData = App.settingsManager.getFitData();
        tankFitData = App.settingsManager.getTankFitData()
        brushMaps = App.settingsManager.getBrushMaps();
        tileAssets = new TileDictionary();

        processFitData();
        processTankFitData();

        drawBrushMaps();
    }

    private function processFitData():void {
        for each (var m:FitData in fitData) {
            var tile:TileAsset = fitTiles(m);
            tile.setPalette(TilePalette[m.palette]);
            tileAssets.add(tile);
        }
    }

    private function processTankFitData():void {
        for each (var m:TankFitData in tankFitData) {
            var tile:TileAsset = fitTankTiles(m);
            m.key.substr(0, 1) == "P" ? tile.setPalette(TilePalette.PLAYER_TANK)
                    : tile.setPalette(TilePalette.AI_TANK);
            tileAssets.add(tile);
        }
    }

    private function fitTiles(model:FitData):TileAsset {
        var bitmap:Bitmap;
        var result:TileAsset;
        var tileSize:uint = GameSettings.TILE_SIZE;
        var rect:Rectangle;
        var coord:Coord;
        var tilesNumber:int = model.coords.length;
        if (model.straight) {

            bitmap = new Bitmap(new BitmapData(tileSize * tilesNumber, tileSize, true, 0x00000000));
            coord = model.coords[0];
            rect = new Rectangle(coord.x * tileSize, coord.y * tileSize, tileSize * tilesNumber, tileSize);
            bitmap.bitmapData.copyPixels(tiles.bitmapData, rect, new Point(0, 0));

        } else if (tilesNumber == 1) {

            bitmap = new Bitmap(new BitmapData(tileSize, tileSize, true, 0x00000000));
            coord = model.coords[0];
            rect = new Rectangle(coord.x * tileSize, coord.y * tileSize, tileSize, tileSize);
            bitmap.bitmapData.copyPixels(tiles.bitmapData, rect, new Point(0, 0));

        } else if (tilesNumber == 2) {

            bitmap = new Bitmap(new BitmapData(tileSize, tileSize * 2, true, 0x00000000));
            coord = model.coords[0];
            rect = new Rectangle(coord.x * tileSize, coord.y * tileSize, tileSize, tileSize);
            bitmap.bitmapData.copyPixels(tiles.bitmapData, rect, new Point(0, 0));
            rect = new Rectangle((coord.x + 1) * tileSize, coord.y * tileSize, tileSize, tileSize);
            bitmap.bitmapData.copyPixels(tiles.bitmapData, rect, new Point(0, tileSize));

        } else if (tilesNumber == 4 || tilesNumber == 16) {
            var side:int = Math.sqrt(tilesNumber);
            bitmap = new Bitmap(new BitmapData(tileSize * side, tileSize * side, true, 0x00000000));
            /*
             Fit order:
             0 2 4 6
             1 3 5 7
             8 A C E
             9 B D F
             */
            var coords:Vector.<Coord> = model.coords.concat();
            var targetPoints:Array = [];
            for (var y:uint = 0; y < side / 2; y++) {
                for (var x:uint = 0; x < side; x++) {
                    targetPoints.push(new Point(x * tileSize, y * 2 * tileSize));
                    targetPoints.push(new Point(x * tileSize, (y * 2 + 1) * tileSize));
                }
            }

            for each (var p:Point in targetPoints) {
                coord = coords.shift();
                rect = new Rectangle(coord.x * tileSize, coord.y * tileSize, tileSize, tileSize);
                bitmap.bitmapData.copyPixels(tiles.bitmapData, rect, p);
            }

        } else if (tilesNumber == 8) {
            //Game over sprite

            bitmap = new Bitmap(new BitmapData(tileSize * 4, tileSize * 2, true, 0x00000000));
            var coords:Vector.<Coord> = model.coords.concat();
            var targetPoints:Array = [];
            var y:uint;
            var newX:uint;
            for (var x:uint = 0; x < 8; x++) {
                y = x % 2;
                newX = x / 2;
                targetPoints.push(new Point(newX * tileSize, y * tileSize));
            }

            for each (var p:Point in targetPoints) {
                coord = coords.shift();
                rect = new Rectangle(coord.x * tileSize, coord.y * tileSize, tileSize, tileSize);
                bitmap.bitmapData.copyPixels(tiles.bitmapData, rect, p);
            }

        } else {
            GameError.invalidFitData(model);
        }
        result = new TileAsset(model.name, bitmap);
        return result;
    }

    private function fitTankTiles(model:TankFitData):TileAsset {
        var bitmap:Bitmap;
        var result:TileAsset;
        var tileSize:uint = GameSettings.TILE_SIZE;
        var rect:Rectangle;
        var coords:Vector.<Coord> = new Vector.<Coord>();
        coords.push(model.coord);
        var coord:Coord;
        /*
         Fit order:
         0 2
         1 3
         */
        for (var i:int = 0; i < 4; i++) {
            coord = new Coord();
            coord.x = coords[i].x + 1;
            coord.y = coords[i].y;
            coords.push(coord);
        }

        bitmap = new Bitmap(new BitmapData(tileSize * 2, tileSize * 2, true, 0x00000000));

        var targetPoints:Array = [];
        targetPoints.push(new Point(0, 0));
        targetPoints.push(new Point(0, tileSize));
        targetPoints.push(new Point(tileSize, 0));
        targetPoints.push(new Point(tileSize, tileSize));

        for each (var p:Point in targetPoints) {
            coord = coords.shift();
            rect = new Rectangle(coord.x * tileSize, coord.y * tileSize, tileSize, tileSize);
            bitmap.bitmapData.copyPixels(tankTiles.bitmapData, rect, p);
        }

        result = new TileAsset(model.key, bitmap);
        return result;
    }


    private function drawBrushMaps():void {
        for each (var m:BrushMap in brushMaps) {
            var tile:TileAsset = BrushMapTool.renderBrushMap(m);
            tile.setPalette(TilePalette[m.palette]);
            tileAssets.add(tile);
        }
    }


    /*
     спрайт танка:

     TankAssets.getPlayer(Players.PLAYER).getLevel(0).getDirection(TankDirection.UP);



     */

    public function getTileAsset(name:String):TileAsset {
        return tileAssets.getTileAssetByName(name);
    }

    public function copyTileAsset(name:String):TileAsset {
        return tileAssets.getTileAssetByName(name).getClone();
    }

    public function getTileAssetByIndex(index:int):TileAsset {
        return tileAssets.getTileAssetByIndex(index);
    }

    public function getTileCollectionSize():uint {
        return tileAssets.getLength();
    }

    private var tiles:Bitmap;
    private var tankTiles:Bitmap;

    private var fitData:Vector.<FitData> = new Vector.<FitData>();
    private var tankFitData:Vector.<TankFitData> = new Vector.<TankFitData>();
    private var brushMaps:Vector.<BrushMap> = new Vector.<BrushMap>();

    private var tileAssets:TileDictionary;

}
}
