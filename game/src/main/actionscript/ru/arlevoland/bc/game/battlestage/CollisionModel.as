package ru.arlevoland.bc.game.battlestage {
import ru.arlevoland.bc.game.battlestage.tank.ActorType;

public class CollisionModel {

    //2x2
    private static var _tankCollisions:Array = [
        new CollisionModel("BRICK_RIGHT", 0, 1, 0, 1),
        new CollisionModel("BRICK_BOTTOM", 0, 0, 1, 1),
        new CollisionModel("BRICK_LEFT", 1, 0, 1, 0),
        new CollisionModel("BRICK_TOP", 1, 1, 0, 0),
        new CollisionModel("BRICK_FULL", 1, 1, 1, 1),
        new CollisionModel("METAL_RIGHT", 0, 1, 0, 1),
        new CollisionModel("METAL_BOTTOM", 0, 0, 1, 1),
        new CollisionModel("METAL_LEFT", 1, 0, 1, 0),
        new CollisionModel("METAL_TOP", 1, 1, 0, 0),
        new CollisionModel("METAL_FULL", 1, 1, 1, 1),
        new CollisionModel("ICE_FULL", 0, 0, 0, 0),
        new CollisionModel("WATER_FULL", 1, 1, 1, 1),
        new CollisionModel("TREE_FULL", 0, 0, 0, 0),
        new CollisionModel("ASPHALT_FULL", 0, 0, 0, 0)
    ];

    //1x1
    private static var _bulletCollisions:Array = [
        new CollisionModel("BRUSH_0", 0, 0, 0, 0),
        new CollisionModel("BRUSH_1", 1, 0, 0, 0),
        new CollisionModel("BRUSH_2", 0, 1, 0, 0),
        new CollisionModel("BRUSH_3", 1, 1, 0, 0),
        new CollisionModel("BRUSH_4", 0, 0, 1, 0),
        new CollisionModel("BRUSH_5", 1, 0, 1, 0),
        new CollisionModel("BRUSH_6", 0, 1, 1, 0),
        new CollisionModel("BRUSH_7", 1, 1, 1, 0),
        new CollisionModel("BRUSH_8", 0, 0, 0, 1),
        new CollisionModel("BRUSH_9", 1, 0, 0, 1),
        new CollisionModel("BRUSH_A", 0, 1, 0, 1),
        new CollisionModel("BRUSH_B", 1, 1, 0, 1),
        new CollisionModel("BRUSH_C", 0, 0, 1, 1),
        new CollisionModel("BRUSH_D", 1, 0, 1, 1),
        new CollisionModel("BRUSH_E", 0, 1, 1, 1),
        new CollisionModel("BRUSH_F", 1, 1, 1, 1),
        new CollisionModel("DUMMY", 0, 0, 0, 0)
    ];

    public function CollisionModel(tileName:String, TL:uint, TR:uint, BL:uint, BR:uint) {
        _tileName = tileName;
        _TL = TL;
        _TR = TR;
        _BL = BL;
        _BR = BR;
    }

    public function get tileName():String {
        return _tileName;
    }

    public function get TL():uint {
        return _TL;
    }

    public function get TR():uint {
        return _TR;
    }

    public function get BL():uint {
        return _BL;
    }

    public function get BR():uint {
        return _BR;
    }

    public static function getModelByName(name:String, type:ActorType):CollisionModel {
        var collisions:Array;
        if (type == ActorType.BULLET) {
            collisions = _bulletCollisions;
        } else {
            collisions = _tankCollisions;
        }
        for each (var m:CollisionModel in collisions) {
            if (m.tileName == name) {
                return m;
            }
        }
        return CollisionModel.getModelByName("DUMMY", ActorType.BULLET);
    }

    public static function get tankCollisions():Array {
        return _tankCollisions;
    }

    private var _tileName:String;
    private var _TL:uint;
    private var _TR:uint;
    private var _BL:uint;
    private var _BR:uint;
}
}
