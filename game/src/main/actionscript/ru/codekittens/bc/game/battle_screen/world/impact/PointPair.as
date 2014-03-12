package ru.codekittens.bc.game.battle_screen.world.impact {
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

    public function trimAll(minX:Number, maxX:Number, minY:Number, maxY:Number):void {
        var first:Point = getFirst();
        var second:Point = getSecond();
        if (first.x > maxX) first.x = maxX;
        if (first.x < minX) first.x = minX;
        if (first.y > maxY) first.y = maxY;
        if (first.y < minY) first.y = minY;
        if (second.x > maxX) second.x = maxX;
        if (second.x < minX) second.x = minX;
        if (second.y > maxY) second.y = maxY;
        if (second.y < minY) second.y = minY;
    }

}
}
