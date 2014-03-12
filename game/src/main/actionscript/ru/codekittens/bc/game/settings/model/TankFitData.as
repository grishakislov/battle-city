package ru.codekittens.bc.game.settings.model {
public class TankFitData {

    [JsonProperty("key")]
    public var key:String;
    [JsonProperty("coord")]
    public var coord:Coord;

    public function getLevel():uint {
        return uint (key.substr(1,1));
    }

}
}
