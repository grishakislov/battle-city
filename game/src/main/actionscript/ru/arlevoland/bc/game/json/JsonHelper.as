package ru.arlevoland.bc.game.json {
import flash.utils.describeType;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

import ru.arlevoland.bc.game.core.assets.Resources;
import ru.arlevoland.bc.game.json.model.BrushMap;
import ru.arlevoland.bc.game.json.model.FitData;
import ru.arlevoland.bc.game.json.model.LevelData;
import ru.arlevoland.bc.game.json.model.TankFitData;

public class JsonHelper {

    public static function getFitData():Array {
        var data:String = new Resources.FIT_DATA;
        var result:Array = readList(FitData, data);
        return result;
    }

    public static function getTankFitData():Array {
        var data:String = new Resources.TANK_FIT_DATA;
        var result:Array = readList(TankFitData, data);
        return result;
    }

    public static function getBrushMaps():Array {
        var data:String = new Resources.BRUSH_MAPS;
        var result:Array = readList(BrushMap, data);
        return result;
    }

    public static function getLevels():Array {
        var data:String = new Resources.LEVELS;
        var result:Array = readList(LevelData, data);
        return result;
    }

    public static function readObject(clazz:Class, json:Object):* {
        var decodedObject:Object = (json is String) ? JSON.parse(json as String) : json;
        var classDesc:XML = describeType(clazz);
        var className:String = classDesc.@name;

        if (className.indexOf("__AS3__.vec::Vector") == 0) {
            var vectorInstanceType:Class = getDefinitionByName(className.split("<")[1].split(">")[0]) as Class;
            return clazz(readList(vectorInstanceType, decodedObject));
        }

        var instance:* = new clazz();
        return setInstanceProperties(instance, decodedObject, classDesc);
    }

    public static function readList(clazz:Class, json:Object):Array {
        var decodedList:Array = (json is String) ? JSON.parse(json as String) as Array : json as Array;
        var list:Array = [];
        for (var i:int = 0; i < decodedList.length; i++) {
            list.push(readObject(clazz, decodedList[i]));
        }
        return list;
    }

    private static function setInstanceProperties(instance:*, decodedObject:Object, classDesc:XML):* {
        for each(var mixinVar:XML in classDesc.factory.variable) {
            var meta:XML = mixinVar.metadata.(@name == "JsonProperty")[0];
            if (meta) {
                var instancePropName:String = mixinVar.@name;
                var instancePropType:String = mixinVar.@type;
                var jsonPropName:String = meta.arg.@value;
                var jsonPropValue:* = decodedObject[jsonPropName];
                var jsonPropType:String = getQualifiedClassName(jsonPropValue);
                if (instancePropType.indexOf("Array") == 0) {
                    throw new Error("Jameson does not support Array fields (yet). Use Vectors to denote object type.");
                }
                if (instance.hasOwnProperty(instancePropName) && jsonPropValue != null) {
                    if (instancePropType != jsonPropType) {
                        instance[instancePropName] = readObject(getDefinitionByName(instancePropType) as Class, jsonPropValue);
                    } else {
                        instance[instancePropName] = decodedObject[jsonPropName];
                    }
                }
            }
        }
        return instance;
    }

}
}
