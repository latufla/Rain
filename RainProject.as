package {

import common.model.IsoTile;
import common.view.IsoTileRenderer;

import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;

[SWF(width="1280", height="748", frameRate="30", backgroundColor = "0xFFFFFF")]
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

        _engine = new Engine();
        _engine.init();

    }
}
}
