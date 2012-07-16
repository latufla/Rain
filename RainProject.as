package {

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Rectangle;

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

        _engine = new Engine();
        _engine.init();

        STAGE.addChild(new FPSCounter());



//        var sp:Sprite = new Sprite();
//        IsoRenderUtil.draw_iso_box(sp, 10, 10, 50, 0xC2C3C2);
//        sp.x = 50;
//        sp.y = 100;
//        addChild(sp);
//        sp.graphics.beginFill(0x00FF00);
//        sp.graphics.drawRect(-2, -2, 4, 4);
//        sp.graphics.endFill();
//
//
//        var bounds:Rectangle = sp.getBounds(sp);
//        var bd:BitmapData = new BitmapData(bounds.width, bounds.height);
//        var m:Matrix = new Matrix();
//        m.translate(-bounds.x, -bounds.y);
//        bd.draw(sp, m);

//
//        var bitmap:Bitmap = new Bitmap();
//        bitmap.bitmapData = bd;
//        bitmap.x = 150;
//        bitmap.y = 100;
//        addChild(bitmap);
    }
}
}
