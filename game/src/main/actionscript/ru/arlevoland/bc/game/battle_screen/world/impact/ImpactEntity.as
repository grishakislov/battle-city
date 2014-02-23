package ru.arlevoland.bc.game.battle_screen.world.impact {
import ru.arlevoland.bc.game.battle_screen.world.ActorType;
import ru.arlevoland.bc.game.battle_screen.world.IActor;

public class ImpactEntity {

    public function ImpactEntity(tileName:String, isBrick:Boolean, brickIndex:uint) {
        this.tileName = tileName;
        this.brick = isBrick;
        this.brickIndex = brickIndex;
    }

    public function checkImpact(actor:IActor):Boolean {
        if (actor.getType().isTank()) {
            if (brick) {
                return brickIndex > 0;
            } else {
                return tileName == "METAL" ||
                       tileName == "WATER";
            }
        } else if (actor.getType() == ActorType.BULLET) {

        }
        return false;
    }

    public function getTileName():String {
        return tileName;
    }

    public function isBrick():Boolean {
        return brick;
    }

    public function getBrickIndex():uint {
        return brickIndex;
    }

    private var tileName:String;
    private var brick:Boolean;
    private var brickIndex:uint;


}
}
