package ru.arlevoland.bc.game.battle_screen.tank {
public class ActorDirection {

    public static const UP:ActorDirection = new ActorDirection("U");
    public static const RIGHT:ActorDirection = new ActorDirection("R");
    public static const DOWN:ActorDirection = new ActorDirection("D");
    public static const LEFT:ActorDirection = new ActorDirection("L");


    public function ActorDirection(direction:String) {
        this.direction = direction;
    }


    public function getDirectionId():String {
        return direction;
    }

    private var direction:String;

}
}
