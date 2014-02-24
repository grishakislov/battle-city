package ru.arlevoland.bc.game.battle_screen.world.impact {
import flash.geom.Point;

public class PointPair extends AbstractPair {

    public function PointPair(first:Point, second:Point) {
        super(first, second);
    }

    public function getFirst():Point {
        return first;
    }

    public function getSecond():Point {
        return second;
    }

    public function toArray():Array {
        return [first, second];
    }
}
}
