/**
 * @author arlechin
 * Date: 04.07.12
 * Time: 23:20
 */
package ru.arlevoland.bc.game.core.debug {
import mx.utils.StringUtil;

public class GameWarning {

    private static const PALETTE_ALREADY_APPLIED:String = "Palette {0} already applied for {1}";

    public static function paletteAlreadyApplied(paletteName:String, tileName:String):void {
        var message:String = StringUtil.substitute(PALETTE_ALREADY_APPLIED, paletteName, tileName);
        trace(message);
    }

}
}
