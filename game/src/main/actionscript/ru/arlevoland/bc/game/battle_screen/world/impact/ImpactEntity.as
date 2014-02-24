package ru.arlevoland.bc.game.battle_screen.world.impact {
import ru.arlevoland.bc.game.battle_screen.tank.ActorDirection;
import ru.arlevoland.bc.game.battle_screen.world.ActorType;
import ru.arlevoland.bc.game.battle_screen.world.IActor;

[Deprecated]
public class ImpactEntity {

    public function ImpactEntity(tileName:String, isBrick:Boolean, brickIndex:uint) {
        this.tileName = tileName;
        this.brick = isBrick;
        this.brickIndex = brickIndex;
    }

    /*
     positionFlag равен true для левого и верхнего тайла из двух перед пулей
     и false для правого и нижнего
     */
    public function checkImpact(actor:IActor, positionFlag:Boolean):Boolean {
        if (actor.getType().isTank()) {
            if (brick) {
                return brickIndex > 0;
            } else {
                return tileName == "METAL" ||
                       tileName == "WATER";
            }
        } else if (actor.getType() == ActorType.BULLET) {

            var directionMask:uint = getDirectionMask(actor.getDirection(), positionFlag);
            var impact:uint;
            if (brick) {
                impact = directionMask & brickIndex;
                if (impact > 0) {
                    applyDestruction(actor.getDirection())
                    updateTileName();
                }
            } else {
                //TODO: Complete
            }
            return impact > 0;
        }
        return false;
    }

    private function updateTileName():void {
        //TODO: Complete
        if (brickIndex == 0) {
            tileName = "ASPHALT";
            brick = false;
        }
        tileName = "BRUSH" + "_" + brickIndex.toString(16).toUpperCase();
    }


    public function applyDestruction(direction:ActorDirection):void {
        //TODO: Можно уменьшить в четыре раза
        switch (direction) {
            case ActorDirection.UP:
                brickIndex & 0xC ? brickIndex ^= 0xC : brickIndex ^= 0x3;
                break;
            case ActorDirection.RIGHT:
                brickIndex & 0x5 ? brickIndex ^= 0x5 : brickIndex ^= 0xA;
                break;
            case ActorDirection.DOWN:
                brickIndex & 0x3 ? brickIndex ^= 0x3 : brickIndex ^= 0xC;
                break;
            case ActorDirection.LEFT:
                brickIndex & 0xA ? brickIndex ^= 0xA : brickIndex ^= 0x5;
                break;
        }


    }

    private function getDirectionMask(direction:ActorDirection, positionFlag:Boolean):uint {
        switch (direction) {
            case ActorDirection.UP:
                return positionFlag ? 0x5 : 0xA;
            case ActorDirection.RIGHT:
                return positionFlag ? 0x3 : 0xC;
            case ActorDirection.DOWN:
                return positionFlag ? 0xA : 0x5;
            case ActorDirection.LEFT:
                return positionFlag ? 0xC : 0x3;
        }
        return 0;
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
