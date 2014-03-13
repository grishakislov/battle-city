package ru.codekittens.bc.game.settings.model {
public class BigTile {

    [JsonProperty("id")]
    public var id:int;

    [JsonProperty("name")]
    public var name:String;

    [JsonProperty("tiles")]
    public var tiles:Vector.<String>;

}
}
