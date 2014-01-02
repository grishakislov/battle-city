/**
 * @author arlechin
 * Date: 04.07.12
 * Time: 23:34
 */
package ru.arlevoland.bc.game.controller {
public interface IGameScreen {

    function initialize():void;

    function run(data:* = undefined):void;

    function destroy():*;

    function pause():void;

}
}
