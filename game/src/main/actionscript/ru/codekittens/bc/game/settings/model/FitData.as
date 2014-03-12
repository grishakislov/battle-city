package ru.codekittens.bc.game.settings.model {

public class FitData {

    [JsonProperty("name")]
    public var name:String;
    [JsonProperty("palette")]
    public var palette:String;
    [JsonProperty("brushIndex")]
    public var brushIndex:uint;
    [JsonProperty("tag")]
    public var tag:String;
    [JsonProperty("straight")]
    public var straight:Boolean;
    [JsonProperty("coords")]
    public var coords:Vector.<Coord>;

}
}
