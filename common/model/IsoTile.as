/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:22 AM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
import common.controller.ControllerBase;

import utils.PNode;

// field tile, not normally use for extending
public class IsoTile extends ObjectBase{

    //
    private var _field_object_c:ControllerBase;
    private var _objects:Vector.<ControllerBase> = new Vector.<ControllerBase>();

    // pathfinding node
    private var _p_node:PNode;

    // DEBUG
    private var _debug_type:int = 0;

    public function IsoTile(x:int, y:int) {
        super();
        init(x, y);
    }

    private function init(x:int, y:int):void {
        move_to(x, y);

        _is_reachable = true;
        _p_node = new PNode(this);
    }

    public function get debug_type():int {
        return _debug_type;
    }

    public function set debug_type(value:int):void {
        _debug_type = value;
    }

    public function get p_node():PNode {
        return _p_node;
    }

    public function toString():String{
        return "x: " + _x + ", y: " + _y +
                ", is_reachable: " + _is_reachable;
//                + ", debug type: " + _debug_type;
    }

    public function get field_object_c():ControllerBase {
        return _field_object_c;
    }

    public function set field_object_c(value:ControllerBase):void {
        _field_object_c = value;
    }

    public function get objects():Vector.<ControllerBase> {
        return _objects;
    }

    public function set objects(value:Vector.<ControllerBase>):void {
        _objects = value;
    }

    public function add_object(o:ControllerBase):void{
        _objects.push(o);
    }

    public function remove_object(o:ControllerBase):ControllerBase{
        var idx:int = _objects.indexOf(o);
        if(idx == -1)
            return null;

        _objects.splice(idx, 1);
        return o;
    }

}
}
