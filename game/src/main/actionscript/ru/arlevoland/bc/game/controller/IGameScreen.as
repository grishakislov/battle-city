package ru.arlevoland.bc.game.controller {
public interface IGameScreen {

    function initialize():void;

    function run(data:* = undefined):void;

    function destroy():*;

    function pause():void;

}
}
