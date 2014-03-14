package ru.codekittens.bc.game.settings.model {

public class FrameSpeed {

    [JsonProperty("id")]
    public var id:String;

    [JsonProperty("type")]
    public var type:String;

    [JsonProperty("pixelsPerFrame")]
    public var pixelsPerFrame:uint;

    [JsonProperty("sequence")]
    public var sequence:Vector.<Boolean>;

}
}
