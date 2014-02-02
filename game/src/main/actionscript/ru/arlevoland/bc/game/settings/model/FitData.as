package ru.arlevoland.bc.game.settings.model {
import flash.geom.Point;

public class FitData {

    [JsonProperty("name")]
    public var name:String;
    [JsonProperty("palette")]
    public var palette:String;
    [JsonProperty("index")]
    public var index:uint;
    [JsonProperty("tag")]
    public var tag:String;
    [JsonProperty("straight")]
    public var straight:Boolean;
    [JsonProperty("coords")]
    public var coords:Vector.<Coord>;

}
}
