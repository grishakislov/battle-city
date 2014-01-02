/**
 * @author arlechin
 * Date: 07.07.12
 * Time: 4:01
 */
package ru.arlevoland.bc.game.core.assets {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;
import ru.arlevoland.bc.game.bcb.model.BrushMap;

internal class BrushMapTool {

    /*
    Отрисовывает рисунок из карты брашей
     */

    public static function renderBrushMap(model:BrushMap):TileAsset {
        var tiles:Bitmap = new Resources.TILES();
        var brushMap:Array = model.brushMap.concat();
        var tileSize:uint = GameSettings.TILE_SIZE;
        var bitmap:Bitmap = new Bitmap(new BitmapData(model.width * tileSize, model.height * tileSize, true, 0x00000000));
        var rect:Rectangle;
        var p:Point;
        for (var y:uint = 0; y < model.height; y++) {
            for (var x:uint = 0; x < model.width; x++) {
                rect = new Rectangle(brushMap.shift() * tileSize, 0, tileSize, tileSize);
                p = new Point(x * tileSize, y * tileSize);
                bitmap.bitmapData.copyPixels(tiles.bitmapData, rect, p);

            }
        }

        return new TileAsset(model.name, bitmap)
    }

}
}
