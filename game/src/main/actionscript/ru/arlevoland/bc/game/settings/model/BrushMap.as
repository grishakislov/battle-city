package ru.arlevoland.bc.game.settings.model {
public class BrushMap {

    [JsonProperty("name")]
    public var name:String;
    [JsonProperty("palette")]
    public var palette:String;
    [JsonProperty("width")]
    public var width:int;
    [JsonProperty("height")]
    public var height:int;
    [JsonProperty("data")]
    public var data:String;

}
}
