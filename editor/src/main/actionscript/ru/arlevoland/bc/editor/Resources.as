package ru.arlevoland.bc.editor {
public class Resources {

    [Embed(source="../../../../../resources/embedded/tanks.gif")]
    public static const TANKS:Class;

    [Embed(source="../../../../../resources/embedded/tiles.gif")]
    public static const TILES:Class;

    [Embed(source="../../../../../resources/embedded/FitData.txt", mimeType="application/octet-stream")]
    public static const TILES_TXT:Class;

    [Embed(source="../../../../../resources/embedded/TankFitData.txt", mimeType="application/octet-stream")]
    public static const TANKS_TXT:Class;

    [Embed(source="../../../../../resources/embedded/BrushMap.txt", mimeType="application/octet-stream")]
    public static const BRUSH_TXT:Class;

    [Embed(source="../../../../../resources/embedded/levels.txt", mimeType="application/octet-stream")]
    public static const LEVELS_TXT:Class;

}
}
