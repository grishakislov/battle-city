package ru.codekittens.bc.game.settings.model {

public class ImpactData {

    [JsonProperty("name")]
    public var name:String;

    [JsonProperty("passable")]
    public var passable:Boolean;

    [JsonProperty("brushIndex")]
    public var brushIndex:uint;

}

}
