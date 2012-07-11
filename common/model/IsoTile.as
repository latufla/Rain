/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:22 AM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
import utils.PNode;

// field tile, not normally use for extending
public class IsoTile extends ObjectBase{

    // pathfinding node
    private var _p_node:PNode;

    // DEBUG
    private var _debug_type:int = 0;
    public static const DEBUG_KEY_POINT:int = 1;
    public static const DEBUG_OPTIONAL_POINT:int = 2;

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
                ", is_reachable: " + _is_reachable +
                ", debug type: " + _debug_type;
    }
}
}
