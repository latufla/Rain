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

import flash.display.Sprite;
import flash.geom.Point;

import utils.iso.IsoMathUtil;

public class FieldObjectController {

    private var _object:FieldObject;
    private var _view:FieldObjectView = new FieldObjectView();
    public function FieldObjectController() {

    }

    public function draw(apply_axises:Function):void{
        if(!_object)
            throw new Error("FieldObjectView -> draw(): object is null");

        _view.object = _object;
        _view.draw();

        var pnt:Point = apply_axises(_object);
        pnt = IsoMathUtil.isoToScreen(pnt.x, pnt.y);
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
