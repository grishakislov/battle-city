package ru.arlevoland.bc.game.core.assets {


public class Resources {

    [Embed(source="../../../../../../../resources/embedded/tanks.gif")]
    public static const TANKS:Class;

    [Embed(source="../../../../../../../resources/embedded/tiles.gif")]
    public static const TILES:Class;

    [Embed(source="../../../../../../../resources/embedded/data.bcb", mimeType="application/octet-stream")]
    public static const DATA:Class;

    //Sound
    [Embed(source="../../../../../../../resources/embedded/click.mp3")]
    public static const CLICK:Class;

    [Embed(source="../../../../../../../resources/embedded/engine1.mp3")]
    public static const ENGINE_1:Class;

    [Embed(source="../../../../../../../resources/embedded/engine2.mp3")]
    public static const ENGINE_2:Class;

    [Embed(source="../../../../../../../resources/embedded/shoot.mp3")]
    public static const SHOOT:Class;


}

}