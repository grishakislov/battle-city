package ru.codekittens.bc.game.core.assets.model {
public class TileDictionary {

    public function add(element:TileAsset):void {
        if (dictionary[element.getName()] == null) {
            dictionary[element.getName()] = element;
            index.push(element.getName());
        } else {
            dictionary[element.getName()] = element;
        }
    }

    public function getTileAssetByName(name:String):TileAsset {
        return TileAsset(dictionary[name]);
    }

    public function getTileAssetByIndex(index:int):TileAsset {
        return dictionary[this.index[index]];
    }

    public function getLength():uint {
        return index.length;
    }

    private var dictionary:Object = {};
    private var index:Array = [];

}
}
