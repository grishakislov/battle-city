/**
 * @author arlechin
 * @author antivoland
 */
package ru.arlevoland.bc.game.controller {
public class PipelineChannel {
    public static const MAIN:String = "main";
    public static const SCREEN:String = "screen";

    private var manager:PipelineManager;
    private var handlers:Object = {};

    public function PipelineChannel(manager:PipelineManager) {
        this.manager = manager;
    }

    // TODO: push message
    public function push(message:ScreenMessage):void {
        var messageHandlers:Vector.<Function> = handlers[message.name];
        if (messageHandlers == null) {
            return;
        }
        for each (var handler:Function in messageHandlers) {
            handler.call(null, message);
        }
    }

    // TODO: add listener?
    public function add(messageName:String, handler:Function):void {
        var messageHandlers:Vector.<Function> = handlers[messageName];
        if (messageHandlers == null) {
            messageHandlers = new Vector.<Function>();
            handlers[messageName] = messageHandlers;
        }
        if (messageHandlers.indexOf(handler) >= 0) {
            return;
        }
        messageHandlers.push(handler);
    }
}
}
