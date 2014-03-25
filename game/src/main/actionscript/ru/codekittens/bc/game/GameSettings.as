package ru.codekittens.bc.game {
import flash.geom.Point;

public class GameSettings {

    public static const DEBUG:Boolean = true;
    public static const SOUND_ENABLED:Boolean = true;

    public static const WORLD_WIDTH:uint = 13;//by 32
    public static const WORLD_HEIGHT:uint = 13;//by 32

    public static const NATIVE_NES_SCREEN_SIZE:Point = new Point(256, 224);

    public static const WORLD_STAGE_INSET:Point = new Point(16, 8);

    public static const WORLD_SCALE:uint = 3;

    public static const AI_TANKS_TOTAL:uint = 20;
    public static const AI_TANKS_MAX:uint = 4;

    public static const TILE_SIZE:uint = 8;
    public static const MAP_TILE_SIZE:int = TILE_SIZE * 2;
    public static const TANK_SIZE:int = 16;
    public static const TANK_GRID_SIZE:int = 8;

    //TODO: Move to json
    public static const LEVEL_1_BULLETS:int = 1;
    public static const LEVEL_2_BULLETS:int = 1;
    public static const LEVEL_3_BULLETS:int = 2;
    public static const LEVEL_4_BULLETS:int = 2;

    public static const PLAYER_TANK_1_INITIAL_COORDS:Point = new Point(4, 12);
    public static const SCORE_TO_LIFE:uint = 200000;

}
}
