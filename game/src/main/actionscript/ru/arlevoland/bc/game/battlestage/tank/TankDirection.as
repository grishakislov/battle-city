package ru.arlevoland.bc.game.battlestage.tank {
public class TankDirection {

    public static const UP:TankDirection = new TankDirection("U");
    public static const RIGHT:TankDirection = new TankDirection("R");
    public static const DOWN:TankDirection = new TankDirection("D");
    public static const LEFT:TankDirection = new TankDirection("L");


    public function TankDirection(direction:String) {
        this.direction = direction;
    }


    public function getDirectionId():String {
        return direction;
    }

    private var direction:String;

}
}
