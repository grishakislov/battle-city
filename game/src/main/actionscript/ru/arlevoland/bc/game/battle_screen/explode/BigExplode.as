package ru.arlevoland.bc.game.battle_screen.explode {
public class BigExplode extends BaseExplode {

    public function BigExplode() {
        explodeSequence =  ["EXPLODE_1", "EXPLODE_2", "EXPLODE_3", "EXPLODE_4", "EXPLODE_5",
                            "EXPLODE_4", "EXPLODE_3", "EXPLODE_2", "EXPLODE_1"];
    }

    override protected function onAnimation(delta:uint):void {
        super.onAnimation(delta);
        //index incremented by super
        var index:uint = explodeSequenceIndex - 1;

        //Offset for big tiles
        var offset:Boolean = index == 3 || index == 4 || index == 5;
        visual.x = visual.y = offset ? -8 : 0;
    }
}
}
