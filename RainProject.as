package {

import common.controller.ControllerBase;
import common.controller.ControllerBase;
import common.model.IsoTile;
import common.view.IsoTileRenderer;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

import utils.ArrayUtils;

import utils.ArrayUtils;
import utils.DebugUtils;

import utils.FPSCounter;
import utils.iso.IsoRenderUtil;

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

        var s:Sprite = new Sprite();
        IsoRenderUtil.draw_iso_box(s, 20, 20, 20, 0x00FF00);


        var bounds:Rectangle = s.getBounds(s);
        bd = new BitmapData(bounds.width, bounds.height, true, 0xFFFFFF);

        var m:Matrix = new Matrix();
        m.translate(-bounds.x, -bounds.y);
        bd.draw(s, m);

//        var b:Bitmap = new Bitmap(bd);
//        addChild(b);
//        b.x = 100;

        stage.addEventListener(MouseEvent.CLICK, on_click);
        _engine = new Engine();
        _engine.init();
//
        STAGE.addChild(new FPSCounter());
    }

    private var bd:BitmapData;
    private function on_click(e:MouseEvent):void {
       // trace(bd.hitTest(new Point(0, 0), 0xFFFFFF, new Point(e.localX, e.localY)));
    }
}
}
