package ru.arlevoland.bc.editor.gui {
import flash.display.Sprite;

public class DataList extends Sprite {
    public function DataList(dataType:String) {
        _dataType = dataType;
        _data = getData(_dataType);
    }

    private function getData(dataType:String):Array {
        var result:Array;
        switch (dataType) {
            case BCBDataMarker.FIT_DATA:
                result = BCBLoader.readFitData();
                break;
        }
        return result;
    }

    private var _data:Array;
    private var _dataType:String;
}
}
