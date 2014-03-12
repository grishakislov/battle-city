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

    public static const WORLD_SIZE_MULTIPLIER:uint = 32;

    public static const STAGE_WIDTH:uint = 512;
    public static const STAGE_HEIGHT:uint = 448;

    public static const AI_TANKS_TOTAL:uint = 20;
    public static const AI_TANKS_MAX:uint = 4;

    public static const TILE_SIZE:uint = 8;
    public static const MAP_TILE_SIZE:int = TILE_SIZE * 2;
    public static const TANK_SIZE:int = 16;
    public static const TANK_GRID_SIZE:int = 8;


    //Speeds

    public static const PRELOADER_SPEED:uint = 256;

    public static const DEFAULT_SPEED:uint = 170;//Pixels per sec
    public static const PLAYER_TANK_SPEED:uint = 50;//Pixels per sec


    public static const LEVEL_1_BULLETS:int = int.MAX_VALUE;


    public static const PLAYER_TANK_1_INITIAL_COORDS:Point = new Point(4, 12);

    //public static const BULLET_MAX_X:int = 208;
    //public static const BULLET_MAX_Y:int = 208;

}
}
