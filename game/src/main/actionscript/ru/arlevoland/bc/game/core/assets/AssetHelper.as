/**
 * @author arlechin
 * Date: 11.06.12
 * Time: 17:27
 */
package ru.arlevoland.bc.game.core.assets {
public class AssetHelper {
    public static function convertStringToHex(string:String):uint {
        var result:uint;
        switch (string) {
            case "A":
                result = 0xA;
                break;
            case "B":
                result = 0xB;
                break;
            case "C":
                result = 0xC;
                break;
            case "D":
                result = 0xD;
                break;
            case "E":
                result = 0xE;
                break;
            case "F":
                result = 0xF;
                break;
            default:
                return uint(string);
        }
        return result;
    }


}
}
