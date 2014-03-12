package ru.codekittens.bc.game.settings {
import flash.utils.describeType;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public class JSONHelper {

    public static function readObject(cls:Class, json:Object):* {
        var decodedObject:Object;
        var s:String = getQualifiedClassName(cls);
        if (s == "String" || s == "uint" || s == "int") {
            return json;
        } else {
            decodedObject = (json is String) ? JSON.parse(json as String) : json;
        }

        var classDesc:XML = describeType(cls);
        var className:String = classDesc.@name;

        if (className.indexOf("__AS3__.vec::Vector") == 0) {
            var vectorInstanceType:Class = getDefinitionByName(className.split("<")[1].split(">")[0]) as Class;
            return cls(readList(vectorInstanceType, decodedObject));
        }

        var instance:* = new cls();
        return setInstanceProperties(instance, decodedObject, classDesc);
    }

    public static function readList(cls:Class, json:Object):Array {
        var decodedList:Array = (json is String) ? JSON.parse(json as String) as Array : json as Array;
        var list:Array = [];
        for (var i:int = 0; i < decodedList.length; i++) {
            list.push(readObject(cls, decodedList[i]));
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
