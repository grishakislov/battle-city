package ru.codekittens.bc.game.battle_screen.tank {
public class ActorDirection {

    public static const UP:ActorDirection = new ActorDirection("U");
    public static const RIGHT:ActorDirection = new ActorDirection("R");
    public static const DOWN:ActorDirection = new ActorDirection("D");
    public static const LEFT:ActorDirection = new ActorDirection("L");


    public function ActorDirection(direction:String) {
        this.direction = direction;
    }

    public function isVertical():Boolean {
        return this == UP || this == DOWN;
    }

    public function isHorizontal():Boolean {
        return this == LEFT || this == RIGHT;
    }

    public function getDirectionId():String {
        return direction;
    }

    private var direction:String;

}
}
