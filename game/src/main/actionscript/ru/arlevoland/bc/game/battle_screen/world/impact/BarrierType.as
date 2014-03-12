package ru.arlevoland.bc.game.battle_screen.world.impact {
public class BarrierType {

    public static const BRICK:BarrierType = new BarrierType("brick");
    public static const METAL:BarrierType = new BarrierType("metal");
    public static const BORDER:BarrierType = new BarrierType("border");
    public static const WATER:BarrierType = new BarrierType("water");
    public static const EAGLE:BarrierType = new BarrierType("eagle");
    public static const ARMOR:BarrierType = new BarrierType("armor");

    private var id:String;

    public function BarrierType(id:String) {
        this.id = id;
    }

    public function getId():String {
        return id;
    }
}
}
