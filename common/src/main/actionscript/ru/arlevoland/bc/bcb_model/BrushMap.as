package ru.arlevoland.bc.bcb - model {
public class BrushMap {


    public function BrushMap(name:String, palette:String, width:uint, height:uint) {
        _name = name;
        _palette = palette;
        _width = width;
        _height = height;
    }

    public function get brushMap():Array {
        return _brushMap;
    }

    public function set brushMap(value:Array):void {
        _brushMap = value;
    }

    public function get name():String {
        return _name;
    }

    public function get palette():String {
        return _palette;
    }

    public function get width():uint {
        return _width;
    }

    public function get height():uint {
        return _height;
    }

    private var _name:String;
    private var _palette:String;
    private var _brushMap:Array = [];
    private var _width:uint;
    private var _height:uint;


}
}
