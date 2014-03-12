package ru.codekittens.bc.game.core.debug {
import flash.errors.IllegalOperationError;

import mx.utils.StringUtil;

import ru.codekittens.bc.game.settings.model.FitData;

public class GameError {

    private static const SINGLETON_ERROR:String = "Class is singleton";
    private static const NOT_IMPLEMENTED:String = "Method not implemented";

    private static const SOME_ERROR:String = "SOME ERROR";

    private static const INVALID_LEVEL_ID:String = "Invalid level ID: ";
    private static const INVALID_TILE_FIT:String = "Invalid FitData: {0}, {1} tiles";
    private static const INVALID_ASSET_ID:String = "Invalid asset ID: {0}";
    private static const INVALID_ASSET_INDEX:String = "Invalid asset index: {0}";
    private static const INVALID_CHARACTER_ID:String = "Invalid character ID: {0}";

    public static function singletonError():void {
        throw new IllegalOperationError(SINGLETON_ERROR);
    }

    public static function someError():void {
        throw new IllegalOperationError(SOME_ERROR);
    }

    public static function notImplemented(name:String):void {
        throw new IllegalOperationError(NOT_IMPLEMENTED + ": " + name);
    }

    public static function invalidLevelId(id:uint):void {
        throw new IllegalOperationError(INVALID_LEVEL_ID + id);
    }

    public static function invalidFitData(model:FitData):void {
        var text:String = StringUtil.substitute(INVALID_TILE_FIT, model.name, model.coords.length);
        throw new IllegalOperationError(text);
    }

    public static function invalidAssetId(name:String):void {//TODO use
        var text:String = StringUtil.substitute(INVALID_ASSET_ID, name);
        throw new IllegalOperationError(text);
    }

    public static function invalidAssetIndex(index:int):void {//TODO use
        var text:String = StringUtil.substitute(INVALID_ASSET_INDEX, index);
        throw new IllegalOperationError(text);
    }

    public static function invalidCharacterId(name:String):void {
        var text:String = StringUtil.substitute(INVALID_CHARACTER_ID, name);
        throw new IllegalOperationError(text);
    }

}
}
