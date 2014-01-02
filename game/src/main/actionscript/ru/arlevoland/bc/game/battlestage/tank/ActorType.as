/**
 * @author arlechin
 * Date: 09.08.12
 * Time: 15:32
 */
package ru.arlevoland.bc.game.battlestage.tank {
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
