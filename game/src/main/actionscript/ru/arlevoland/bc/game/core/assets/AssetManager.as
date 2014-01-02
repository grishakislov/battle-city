/**
 * @author arlechin
 * Date: 29.05.12
 * Time: 22:24
 */

package ru.arlevoland.bc.game.core.assets {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;
import ru.arlevoland.bc.game.core.assets.model.TileDictionary;
import ru.arlevoland.bc.game.core.assets.model.TilePalette;
import ru.arlevoland.bc.game.bcb.model.BrushMap;
import ru.arlevoland.bc.game.bcb.model.FitData;
import ru.arlevoland.bc.game.bcb.model.TankFitData;
import ru.arlevoland.bc.game.core.debug.GameError;

public class AssetManager {

    /*
    Менеджер ассетов. Любой графический ассет берется отсюда.
     */

    public function initialize():void {

        _tiles = new Resources.TILES();
        _tankTiles = new Resources.TANKS();

        _fitData = Main.getBcbLoader().fitData;
        _tankFitData = Main.getBcbLoader().tankFitData;
        _brushMaps = Main.getBcbLoader().brushMaps;

        _tileAssets = new TileDictionary();

        processFitData();
        processTankFitData();
        drawBrushMaps();
    }

    private function processFitData():void {
        for each (var m:FitData in _fitData) {
            var tile:TileAsset = fitTiles(m);
            tile.setPalette(TilePalette[m.getPalette()]);
            _tileAssets.add(tile);
        }
    }

    private function processTankFitData():void {
        for each (var m:TankFitData in _tankFitData) {
            var tile:TileAsset = fitTankTiles(m);
            m.getName().substr(0, 2) == "PT" ? tile.setPalette(TilePalette.PLAYER_TANK)
                    : tile.setPalette(TilePalette.AI_TANK);
            _tileAssets.add(tile);

        }
    }

    private function fitTiles(model:FitData):TileAsset {
        var bitmap:Bitmap;
        var result:TileAsset;
        var tileSize:uint = GameSettings.TILE_SIZE;
        var rect:Rectangle;
        var coords:Point;
        if (model.isHorizontalOrder()) {

            bitmap = new Bitmap(new BitmapData(tileSize * model.getTilesNumber(), tileSize, true, 0x00000000));
            coords = model.getCoordAt(0);
            rect = new Rectangle(coords.x * tileSize, coords.y * tileSize, tileSize * model.getTilesNumber(), tileSize);
            bitmap.bitmapData.copyPixels(_tiles.bitmapData, rect, new Point(0, 0));

        } else if (model.getTilesNumber() == 1) {

            bitmap = new Bitmap(new BitmapData(tileSize, tileSize, true, 0x00000000));
            coords = model.getCoordAt(0);
            rect = new Rectangle(coords.x * tileSize, coords.y * tileSize, tileSize, tileSize);
            bitmap.bitmapData.copyPixels(_tiles.bitmapData, rect, new Point(0, 0));

        } else if (model.getTilesNumber() == 2) {

            bitmap = new Bitmap(new BitmapData(tileSize, tileSize * 2, true, 0x00000000));
            coords = model.getCoordAt(0);
            rect = new Rectangle(coords.x * tileSize, coords.y * tileSize, tileSize, tileSize);
            bitmap.bitmapData.copyPixels(_tiles.bitmapData, rect, new Point(0, 0));
            rect = new Rectangle((coords.x + 1) * tileSize, coords.y * tileSize, tileSize, tileSize);
            bitmap.bitmapData.copyPixels(_tiles.bitmapData, rect, new Point(0, tileSize));

        } else if (model.getTilesNumber() == 4 || model.getTilesNumber() == 16) {
            var side:int = Math.sqrt(model.getTilesNumber());
            bitmap = new Bitmap(new BitmapData(tileSize * side, tileSize * side, true, 0x00000000));
            /*
             Порядок сборки:
             0 2 4 6
             1 3 5 7
             8 A C E
             9 B D F
             */
            var coordsArray:Array = model.getAllCoords().concat();
            var targetPoints:Array = [];
            for (var y:uint = 0; y < side / 2; y++) {
                for (var x:uint = 0; x < side; x++) {
                    targetPoints.push(new Point(x * tileSize, y * 2 * tileSize));
                    targetPoints.push(new Point(x * tileSize, (y * 2 + 1) * tileSize));
                }
            }

            for each (var p:Point in targetPoints) {
                coords = coordsArray.shift();
                rect = new Rectangle(coords.x * tileSize, coords.y * tileSize, tileSize, tileSize);
                bitmap.bitmapData.copyPixels(_tiles.bitmapData, rect, p);
            }

        } else {
            GameError.invalidFitData(model);
        }
        result = new TileAsset(model.getName(), bitmap);
        return result;
    }

    private function fitTankTiles(model:TankFitData):TileAsset {
        var bitmap:Bitmap;
        var result:TileAsset;
        var tileSize:uint = GameSettings.TILE_SIZE;
        var rect:Rectangle;
        var coordsArray:Array = [model.getCoords()];
        var coords:Point;
        /*
         Порядок сборки:
         0 2
         1 3
         */
        for (var i:int = 0; i < 4; i++) {
            coordsArray.push(new Point(coordsArray[i].x + 1, coordsArray[i].y));
        }

        bitmap = new Bitmap(new BitmapData(tileSize * 2, tileSize * 2, true, 0x00000000));

        var targetPoints:Array = [];
        targetPoints.push(new Point(0, 0));
        targetPoints.push(new Point(0, tileSize));
        targetPoints.push(new Point(tileSize, 0));
        targetPoints.push(new Point(tileSize, tileSize));

        for each (var p:Point in targetPoints) {
            coords = coordsArray.shift();
            rect = new Rectangle(coords.x * tileSize, coords.y * tileSize, tileSize, tileSize);
            bitmap.bitmapData.copyPixels(_tankTiles.bitmapData, rect, p);
        }

        result = new TileAsset(model.getName(), bitmap);
        return result;
    }


    private function drawBrushMaps():void {
        for each (var m:BrushMap in _brushMaps) {
            var tile:TileAsset = BrushMapTool.renderBrushMap(m);
            tile.setPalette(TilePalette[m.palette]);
            _tileAssets.add(tile);
        }
    }


    public function getTileAsset(name:String):TileAsset {
        return _tileAssets.getTileAssetByName(name);
    }

    public function copyTileAsset(name:String):TileAsset {
        return _tileAssets.getTileAssetByName(name).getClone();
    }

    public function getTileAssetByIndex(index:int):TileAsset {
        return _tileAssets.getTileAssetByIndex(index);
    }

    public function getTileCollectionSize():uint {
        return _tileAssets.getLength();
    }

    private var _tiles:Bitmap;
    private var _tankTiles:Bitmap;

    private var _fitData:Array = [];
    private var _tankFitData:Array = [];
    private var _brushMaps:Array = [];

    [ArrayElementType("ru.arlechin.battlecity.core.assets.model.TileAsset")]
    private var _tileAssets:TileDictionary;

}
}
