package ru.codekittens.bc.game.screen_manager {
public interface IGameScreen {

    function initialize():void;

    function run(data:* = undefined):void;

    function destroy():*;

    function pause():void;

}
}
