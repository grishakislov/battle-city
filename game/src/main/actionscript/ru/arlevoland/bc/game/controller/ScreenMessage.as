package ru.arlevoland.bc.game.controller {
public class ScreenMessage {
    public static const FINISHED:String = "FINISHED";

    public var name:String;
    public var src:*;
    public var data:*;

    public function ScreenMessage(name:String, src:*) {
        this.name = name;
        this.src = src;
    }
}
}
