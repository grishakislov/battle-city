package ru.codekittens.bc.game.battle_screen.world.impact {
public class ImpactEntityPair extends AbstractPair {

    public function ImpactEntityPair(first:ImpactEntity, second:ImpactEntity) {
        super(first, second);
    }

    public function getFirst():ImpactEntity {
        return first;
    }

    public function getSecond():ImpactEntity {
        return second;
    }

}
}
