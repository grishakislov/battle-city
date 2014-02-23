package ru.arlevoland.bc.game.battle_screen.new_world.map {
public class MapType {

    public static const TREE:MapType = new MapType("tree");

    private var id:String;

    public function MapType(id:String) {
        this.id = id;
    }

    public function getId():String {
        return id;
    }
}
}
