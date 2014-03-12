package ru.codekittens.bc.game.core.pipeline {
import flash.utils.Dictionary;

public class Pipeline {

    public function Pipeline() {
        handlers = new Dictionary();
    }

    public function add(handler:Function):void {
        var bucket:PipelineBucket = new PipelineBucket();
        bucket.handler = handler;
        handlers[handler] = bucket;
    }

    public function addOnce(handler:Function):void {
        var bucket:PipelineBucket = new PipelineBucket();
        bucket.handler = handler;
        bucket.once = true;
        handlers[handler] = bucket;
    }

    public function remove(handler:Function):void {
        delete handlers[handler];
    }

    public function dispatch(...args):void {
        for each (var b:PipelineBucket in handlers) {
            b.handler.apply(this, args);
            if (b.once) {
                delete handlers[b.handler];
            }
        }
    }

    public function removeAll():void {
        handlers = new Dictionary();
    }

    private var handlers:Dictionary;
}
}
