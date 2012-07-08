/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/8/12
 * Time: 11:47 AM
 * To change this template use File | Settings | File Templates.
 */
package common.view {
import common.model.FieldObject;
import common.model.FieldObjectsList;

import flash.display.Sprite;

public class FieldObjectsView extends Sprite{

    private var _objects:FieldObjectsList;
    private var _views:Array = [];

    public function FieldObjectsView() {
    }

    public function draw():void{
        if(!_objects)
            throw new Error("FieldObjectsView -> draw(): objects is null");

    }

    public function get objects():FieldObjectsList {
        return _objects;
    }

    public function set objects(value:FieldObjectsList):void {
        _objects = value;
    }
}
}
