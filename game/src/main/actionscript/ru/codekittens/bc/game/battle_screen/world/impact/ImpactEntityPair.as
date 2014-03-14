package ru.codekittens.bc.game.battle_screen.world.impact {
public class ImpactEntityPair extends AbstractPair {

    public function ImpactEntityPair(first:ImpactEntity = null, second:ImpactEntity = null) {
        super(first, second);
    }

    public function getFirst():ImpactEntity {
        return first;
    }

    public function getSecond():ImpactEntity {
        return second;
    }

    public function set(first:ImpactEntity, second:ImpactEntity):void {
        this.first = first;
        this.second = second;
    }

    public function setFirst(value:ImpactEntity):void {
        first = value;
    }

    public function setSecond(value:ImpactEntity):void {
        second = value;
    }

}
}
