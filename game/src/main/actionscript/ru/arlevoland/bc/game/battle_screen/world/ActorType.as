package ru.arlevoland.bc.game.battle_screen.world {
public class ActorType {

    public static const PLAYER:ActorType = new ActorType("PLAYER");
    public static const TANK:ActorType = new ActorType("TANK");
    public static const AI:ActorType = new ActorType("AI");
    public static const BULLET:ActorType = new ActorType("BULLET");

    public function ActorType(type:String) {
        this.type = type;
    }

    public function isTank():Boolean {
        return type != "BULLET";
    }

    private var type:String;

}
}
