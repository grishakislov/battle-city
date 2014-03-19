package ru.codekittens.bc.game.battle_screen.bonus {
public class BonusType {

    public static const HELMET:BonusType = new BonusType("helmet");
    public static const TIME:BonusType = new BonusType("time");
    public static const SHOVEL:BonusType = new BonusType("shovel");
    public static const STAR:BonusType = new BonusType("star");
    public static const BOMB:BonusType = new BonusType("bomb");
    public static const TANK:BonusType = new BonusType("tank");

    private var id:String;

    public function BonusType(id:String) {
        this.id = id;
    }

    public function getId():String {
        return id;
    }
}
}
