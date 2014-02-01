package ru.arlevoland.bc.game.core.assets {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.arlevoland.bc.game.core.assets.AssetHelper;

import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;
import ru.arlevoland.bc.game.json.model.BrushMap;

internal class BrushMapTool {

    public static function renderBrushMap(model:BrushMap):TileAsset {
        var tiles:Bitmap = new Resources.TILES();
        var tileSize:uint = GameSettings.TILE_SIZE;
        var bitmap:Bitmap = new Bitmap(new BitmapData(model.width * tileSize, model.height * tileSize, true, 0x00000000));
        var rect:Rectangle;
        var p:Point;
        var c:uint;
        var i:uint = 0;
        for (var y:uint = 0; y < model.height; y++) {
            for (var x:uint = 0; x < model.width; x++) {
                c = AssetHelper.convertStringToHex(model.data.charAt(i))
                rect = new Rectangle(c * tileSize, 0, tileSize, tileSize);
                p = new Point(x * tileSize, y * tileSize);
                bitmap.bitmapData.copyPixels(tiles.bitmapData, rect, p);
                i++;
            }
        }

        return new TileAsset(model.name, bitmap)
    }

}
}
