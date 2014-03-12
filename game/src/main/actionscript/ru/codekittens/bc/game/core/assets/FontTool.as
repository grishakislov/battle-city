package ru.codekittens.bc.game.core.assets {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.core.assets.model.TilePalette;
import ru.codekittens.bc.game.core.debug.GameError;

public class FontTool {

    private static const CHARACTERS:String = "©ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._|= ";

    public static function drawLine(string:String, palette:TilePalette = null):Bitmap {
        if (palette == null) {
            palette = TilePalette.WHITE_FONT;
        }
        var tileSize:uint = GameSettings.TILE_SIZE;
        var result:Bitmap = new Bitmap(new BitmapData(string.length * tileSize, tileSize, true, 0x00000000));
        var source:Bitmap = new Resources.TILES();
        var tileAsset:TileAsset;
        var name:String;
        var rect:Rectangle;
        for (var i:uint = 0; i < string.length; i++) {
            name = getTileName(string.charAt(i));
            tileAsset = App.assetManager.getTileAsset(name).getClone();
            tileAsset.setPalette(palette);
            rect = new Rectangle(0, 0, tileSize, tileSize);
            result.bitmapData.copyPixels(tileAsset.getBitmap().bitmapData, rect, new Point(i * tileSize, 0));
        }
        return result;
    }

    private static function getTileName(char:String):String {
        var name:String;
        switch (char) {
            case "©":
                return "SYM_COPY";
                break;
            case "|":
                return "SYM_I";//TODO это не относится к шрифту
                break;
            case "=":
                return "SYM_II";//TODO это не относится к шрифту
                break;
            case "e":
                name = "E_SMALL";
                break;
            case "f":
                name = "F_SMALL";
                break;
            case "-":
                return "SYM_HYPHEN";
                break;
            case "_":
                return "SYM_UNDERLINE";
                break;
            case ".":
                return "SYM_DOT";
                break;
            case " ":
                return "BRUSH_0";
                break;
            default:
                if (CHARACTERS.indexOf(char) > -1) {
                    name = char;
                    return "FONT_" + name;
                } else {
                    GameError.invalidCharacterId(char);
                }
                break;
        }
        return null;
    }

}
}
