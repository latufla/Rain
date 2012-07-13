/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:18 PM
 * To change this template use File | Settings | File Templates.
 */
package common.view {
import common.controller.FieldController;
import common.model.FieldObject;

import flash.display.Bitmap;

import flash.display.BitmapData;

import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Rectangle;

import utils.iso.IsoRenderUtil;

public class FieldObjectView extends Sprite{

    private var _object:FieldObject;
    public function FieldObjectView() {
    }

    public function draw():void{
        if(!_object)
            throw new Error("FieldObjectView -> draw(): object is null" );

        var sp:Sprite = new Sprite();
        var w:uint = _object.width * FieldController.TILE_WIDTH - 2;
        var l:uint = _object.length * FieldController.TILE_LENGTH - 2;
        var h:uint = _object.debug_height * FieldController.TILE_LENGTH;
        IsoRenderUtil.draw_iso_box(sp, w, l, h, 0xC2C3C2);

        var bounds:Rectangle = sp.getBounds(sp);
        var bd:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0xFFFFFF);
        var m:Matrix = new Matrix();
        m.translate(-bounds.x, -bounds.y);
        bd.draw(sp, m);

//
        var bitmap:Bitmap = new Bitmap();
        bitmap.bitmapData = bd;
        bitmap.x = bounds.x;
        bitmap.y = bounds.y;
        addChild(bitmap);
    }

    public function get object():FieldObject{
        return _object;
    }

    public function set object(value:FieldObject):void {
        _object = value;
    }
}
}
