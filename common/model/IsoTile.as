/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:22 AM
 * To change this template use File | Settings | File Templates.
 */
package common.model {

// width and height are single
// real width and real heights counts by Field.TILE_WIDTH, Field.TILE_WIDTH
public class IsoTile {

    private var _x:int;
    private var _y:int;
    private var _is_reachable:Boolean = true;

    // DEBUG
    private var _debug_type:int = 0;
    public static const DEBUG_KEY_POINT:int = 1;
    public static const DEBUG_OPTIONAL_POINT:int = 2;

    public function IsoTile(x:int, y:int) {
        _x = x;
        _y = y;
        trace(x, y);
    }

    public function get x():int {
        return _x;
    }

    public function set x(value:int):void {
        _x = value;
    }

    public function get y():int {
        return _y;
    }

    public function set y(value:int):void {
        _y = value;
    }

    public function get is_reachable():Boolean {
        return _is_reachable;
    }

    public function set is_reachable(value:Boolean):void {
        _is_reachable = value;
    }

    public function get debug_type():int {
        return _debug_type;
    }

    public function set debug_type(value:int):void {
        _debug_type = value;
    }
}
}
