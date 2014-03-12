package ru.codekittens.bc.game.core.assets.model {
public class TilePalette {

    public static const KEY_COLOR_0:uint = 0xFF747474;//gray
    public static const KEY_COLOR_1:uint = 0xFFC84C0C;//orange
    public static const KEY_COLOR_2:uint = 0xFFA40000;//red
    public static const KEY_COLOR_ALPHA:uint = 0xFF000000;//black

    public static const DEFAULT:TilePalette = new TilePalette("DEFAULT", 0xFF747474, 0xFFC84C0C, 0xFFA40000);
    public static const WHITE_FONT:TilePalette = new TilePalette("WHITE_FONT", 0xFFFCFCFC, 0x00000000, 0x00000000);
    public static const PLAYER_TANK:TilePalette = new TilePalette("PLAYER_TANK", 0xFFFCE4A0, 0xFF887000, 0xFFFC9838);
    public static const AI_TANK:TilePalette = new TilePalette("AI_TANK", 0xFFFCFCFC, 0xFF183C5C, 0xFFBCBCBC);
    public static const EXPLODE:TilePalette = new TilePalette("EXPLODE", 0xFFFFFFFF, 0xFF982078, 0xFFE05000);
    public static const WHITE_LOGO:TilePalette = new TilePalette("WHITE_LOGO", 0xFFFCFCFC, 0xFFD82800, 0xFFD82800);
    public static const METAL:TilePalette = new TilePalette("METAL", 0xFFFCFCFC, 0xFF747474, 0xFFBCBCBC);
    public static const ICE:TilePalette = new TilePalette("ICE", 0xFFFCFCFC, 0xFF747474, 0xFFBCBCBC);
    public static const TREE:TilePalette = new TilePalette("TREE", 0xFF003C14, 0xFF80D010, 0xFF004400);
    public static const NAMCOT:TilePalette = new TilePalette("NAMCOT", 0x00000000, 0xFFd82800, 0x00000000);
    public static const POWERUP:TilePalette = new TilePalette("POWERUP", 0xFFFFFFFF, 0xFF305080, 0xFFBCBCBC);
    public static const BLACK_ASPHALT:TilePalette = new TilePalette("BLACK_ASPHALT", 0xFF000000, 0x00000000, 0x00000000);
    public static const WATER_1:TilePalette = new TilePalette("WATER_1", 0xFF2038EC, 0xFF9CFCF0, 0xFF2038EC);
    public static const WATER_2:TilePalette = new TilePalette("WATER_2", 0xFF2038EC, 0xFF2038EC, 0xFF9CFCF0);
    public static const BULLET:TilePalette = new TilePalette("BULLET", 0x00000000, 0x00000000, 0xFFBCBCBC);
    public static const PRELOADER_FONT:TilePalette = new TilePalette("PRELOADER_FONT", 0xFF000000, 0x00000000, 0x00000000);

    public function TilePalette(name:String, color0:uint, color1:uint, color2:uint):void {
        this.name = name;
        this.color0 = color0;
        this.color1 = color1;
        this.color2 = color2;
    }

    public function getColor0():uint {
        return color0;
    }

    public function getColor1():uint {
        return color1;
    }

    public function getColor2():uint {
        return color2;
    }

    public function getName():String {
        return name;
    }

    private var name:String;
    private var color0:uint;
    private var color1:uint;
    private var color2:uint;
}
}