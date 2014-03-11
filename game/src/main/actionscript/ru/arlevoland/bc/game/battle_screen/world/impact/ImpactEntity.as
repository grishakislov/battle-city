package ru.arlevoland.bc.game.battle_screen.world.impact {
import ru.arlevoland.bc.game.battle_screen.tank.ActorDirection;
import ru.arlevoland.bc.game.battle_screen.world.Actor;
import ru.arlevoland.bc.game.battle_screen.world.ActorType;

public class ImpactEntity {

    public function ImpactEntity(tileName:String, brickIndex:uint) {
        this.tileName = tileName;
        this.brickIndex = brickIndex;
    }

    /*
     positionFlag равен false для левого и верхнего тайла из двух перед пулей
     и true для правого и нижнего
     */
    public function checkImpact(actor:Actor, positionFlag:Boolean):Boolean {
        if (actor.getType().isTank()) {

            return isBrick() || tileName == "METAL" || tileName == "WATER";

        } else if (actor.getType() == ActorType.BULLET) {

            var directionMask:uint = getDirectionMask(actor.getDirection(), positionFlag);
            var impact:uint;
            if (isBrick()) {
                impact = directionMask & brickIndex;
                if (impact > 0) {
                    setFlag(actor.getDirection());
                }
            } else {
                //TODO: Complete
            }
            return impact > 0;
        }
        return false;
    }

    public function destruct(direction:ActorDirection):void {
        applyDestruction(direction)
        updateTileName();
    }

    private function updateTileName():void {
        //TODO: Complete
        if (brickIndex == 0) {
            tileName = "ASPHALT";
        }
        tileName = "BRUSH" + "_" + brickIndex.toString(16).toUpperCase();
    }

    private function setFlag(direction:ActorDirection):void {
        switch (direction) {
            case ActorDirection.UP:
                frontFlag = ((brickIndex & 0xC) != 0);
                break;
            case ActorDirection.RIGHT:
                frontFlag = ((brickIndex & 0x5) != 0);
                break;
            case ActorDirection.DOWN:
                frontFlag = ((brickIndex & 0x3) != 0);
                break;
            case ActorDirection.LEFT:
                frontFlag = ((brickIndex & 0xA) != 0);
                break;
        }
    }

    private function applyDestruction(direction:ActorDirection):void {
        switch (direction) {
            case ActorDirection.UP:
                brickIndex & 0xC ? brickIndex &= 0x3 : brickIndex = 0;
                break;
            case ActorDirection.RIGHT:
                brickIndex & 0x5 ? brickIndex &= 0xA : brickIndex = 0;
                break;
            case ActorDirection.DOWN:
                brickIndex & 0x3 ? brickIndex &= 0xC : brickIndex = 0;
                break;
            case ActorDirection.LEFT:
                brickIndex & 0xA ? brickIndex &= 0x5 : brickIndex = 0;
                break;
        }
    }

    private function getDirectionMask(direction:ActorDirection, positionFlag:Boolean):uint {
        if (direction.isVertical()) return positionFlag ? 0x5 : 0xA;
        if (direction.isHorizontal()) return positionFlag ? 0x3 : 0xC;
        return 0;
    }

    public function getTileName():String {
        return tileName;
    }

    public function isBrick():Boolean {
        return brickIndex > 0;
    }

    public function getBrickIndex():uint {
        return brickIndex;
    }

    public function getFrontFlag():Boolean {
        return frontFlag;
    }

    private var frontFlag:Boolean;
    private var tileName:String;
    private var brickIndex:uint;


}
}
