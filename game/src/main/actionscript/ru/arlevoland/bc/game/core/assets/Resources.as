package ru.arlevoland.bc.game.core.assets {


public class Resources {

    [Embed(source="../../../../../../../resources/embedded/tanks.gif")]
    public static const TANKS:Class;

    [Embed(source="../../../../../../../resources/embedded/tiles.gif")]
    public static const TILES:Class;

    //JSON
    [Embed(source="../../../../../../../resources/embedded/json/fitdata.json", mimeType='application/octet-stream')]
    public static const FIT_DATA:Class;

    [Embed(source="../../../../../../../resources/embedded/json/tankfitdata.json", mimeType='application/octet-stream')]
    public static const TANK_FIT_DATA:Class;

    [Embed(source="../../../../../../../resources/embedded/json/levels.json", mimeType='application/octet-stream')]
    public static const LEVELS:Class;

    [Embed(source="../../../../../../../resources/embedded/json/brushmaps.json", mimeType='application/octet-stream')]
    public static const BRUSH_MAPS:Class;

    [Embed(source="../../../../../../../resources/embedded/json/bigtiles.json", mimeType='application/octet-stream')]
    public static const BIG_TILES:Class;

    //Sound
    [Embed(source="../../../../../../../resources/embedded/sfx/click.mp3")]
    public static const CLICK:Class;

    [Embed(source="../../../../../../../resources/embedded/sfx/engine1.mp3")]
    public static const ENGINE_1:Class;

    [Embed(source="../../../../../../../resources/embedded/sfx/engine2.mp3")]
    public static const ENGINE_2:Class;

    [Embed(source="../../../../../../../resources/embedded/sfx/shoot.mp3")]
    public static const SHOOT:Class;

    [Embed(source="../../../../../../../resources/embedded/sfx/intro.mp3")]
    public static const INTRO:Class;

    [Embed(source="../../../../../../../resources/embedded/sfx/pause.mp3")]
    public static const PAUSE:Class;

    [Embed(source="../../../../../../../resources/embedded/sfx/ricochet_brick.mp3")]
    public static const RICOCHET_BRICK:Class;

    [Embed(source="../../../../../../../resources/embedded/sfx/ricochet_wall.mp3")]
    public static const RICOCHET_WALL:Class;

    [Embed(source="../../../../../../../resources/embedded/sfx/big_explode.mp3")]
    public static const BIG_EXPLODE:Class;


}

}