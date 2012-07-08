/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/8/12
 * Time: 11:55 AM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import avmplus.finish;

import common.model.FieldObject;
import common.view.FieldObjectView;

import flash.display.Sprite;

public class FieldObjectController {

    private var _object:FieldObject;
    private var _view:FieldObjectView = new FieldObjectView();
    public function FieldObjectController() {

    }

    public function draw():void{
        if(!_object)
            throw new Error("FieldObjectView -> draw(): object is null");

        _view.object = _object;
        _view.draw();
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
