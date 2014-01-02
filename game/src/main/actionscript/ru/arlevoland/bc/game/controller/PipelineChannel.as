/**
 * @author arlechin
 * @author antivoland
 */
package ru.arlevoland.bc.game.controller {
public class PipelineChannel {
    public static const MAIN:String = "main";
    public static const SCREEN:String = "screen";

    private var manager:PipelineManager;

    public function PipelineChannel(manager:PipelineManager) {
        this.manager = manager;
    }

// TODO: push message
    public function push(message:ScreenMessage):void {
        // TODO: implement
    }

    // TODO: add listener?
    public function add(channelName:String, handler:Function):void {
        // TODO: implement
    }
}
}
