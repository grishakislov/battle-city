package ru.codekittens.bc.game.settings.model {
import ru.codekittens.bc.game.GameSettings;

public class LevelData {

    public var id:String;
    public var data:String;

    public function getDataAt(x:uint, y:uint):uint {
        return levelData[x + y * GameSettings.WORLD_WIDTH];
    }

    public var levelData:Array;

}
}
