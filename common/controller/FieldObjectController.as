/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/8/12
 * Time: 11:55 AM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {

import common.model.FieldObject;
import common.view.FieldObjectView;

import flash.display.BitmapData;

import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

import utils.iso.IsoMathUtil;
import utils.iso.IsoRenderUtil;

public class FieldObjectController {

    private var _object:FieldObject;
    private var _view:FieldObjectView = new FieldObjectView();
    public function FieldObjectController() {

    }

    public function draw(bd:BitmapData, update_only:Boolean = false):void{
        if(!_object)
            throw new Error("FieldObjectController -> draw(): object is null");

        if(!update_only){
            _view.object = _object;
            _view.draw();
        }

        update_position();
        bd.copyPixels(_view.bd,
                new Rectangle(0, 0, _view.bd.width, _view.bd.height),
                new Point(_view.x + 748 + _view.x_offset, _view.y + _view.y_offset), null, null, true );
    }

    private function update_position():void {
        var pnt:Point = IsoMathUtil.isoToScreen(_object.x_px, _object.y_px);
        _view.x = pnt.x;
        _view.y = pnt.y;
    }

    public function get view():Sprite {
        return _view;
    }

    public function get object():FieldObject {
        return _object;
    }

    public function set object(value:FieldObject):void {
        _object = value;
    }
}
}
