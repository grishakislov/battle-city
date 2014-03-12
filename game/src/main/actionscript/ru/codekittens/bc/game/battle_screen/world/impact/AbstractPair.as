package ru.codekittens.bc.game.battle_screen.world.impact {
public class AbstractPair {

    protected var first:*;
    protected var second:*;

    public function AbstractPair(first:*, second:*) {
        this.first = first;
        this.second = second;
    }

    public function toArray():Array {
        return [first, second];
    }
}
}
