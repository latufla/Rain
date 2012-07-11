package {

import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;

import utils.FPSCounter;

[SWF(width="1280", height="748", frameRate="60", backgroundColor = "0xFFFFFF")]
public class RainProject extends Sprite {

    private var _engine:Engine;
    public static var STAGE:Stage;

    public function RainProject() {
        addEventListener(Event.ADDED_TO_STAGE, onAddStage)
    }

    public function onAddStage(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddStage);
        stage.scaleMode = "noScale";
        stage.align = "left";
        STAGE = stage;

        addChild(new FPSCounter());
        _engine = new Engine();
        _engine.init();
    }
}
}
