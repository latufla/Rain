/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/10/12
 * Time: 4:11 PM
 * To change this template use File | Settings | File Templates.
 */
package common.view {
import common.model.Bot;

import flash.display.Bitmap;

import flash.display.BitmapData;

import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Rectangle;

import utils.iso.IsoRenderUtil;

public class BotView extends Sprite{
    public var bd:BitmapData;
    public var x_offset:int;
    public var y_offset:int;

    private var _object:Bot;
    public function BotView() {
    }

    public function draw():void{
        if(!_object)
            throw new Error("BotView -> draw(): object is null" );

        var sp:Sprite = new Sprite();
        var w:uint = _object.width * 10;
        var l:uint = _object.length * 10;
        var h:uint = 40;
        IsoRenderUtil.draw_iso_box(sp, w, l, h, 0xC2C3C2);

        var bounds:Rectangle = sp.getBounds(sp);

        bd = new BitmapData(bounds.width, bounds.height, true, 0xFFFFFF);
        var m:Matrix = new Matrix();
        m.translate(-bounds.x, -bounds.y);
        bd.draw(sp, m);
        x_offset = bounds.x;
        y_offset = bounds.y;
    }

    public function get object():Bot{
        return _object;
    }

    public function set object(value:Bot):void {
        _object = value;
    }
}
}
