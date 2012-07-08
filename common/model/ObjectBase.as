/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:07 PM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
public class ObjectBase {

    protected var _x:uint;
    protected var _y:uint;
    protected var _width:uint
    protected var _length:uint;

    private var _is_reachable:Boolean;
    private var _is_occupied:Boolean;

    public function ObjectBase() {
    }

    public function get x():uint {
        return _x;
    }

    public function set x(value:uint):void {
        _x = value;
    }

    public function get y():uint {
        return _y;
    }

    public function set y(value:uint):void {
        _y = value;
    }

    public function get width():uint {
        return _width;
    }

    public function set width(value:uint):void {
        _width = value;
    }

    public function get length():uint {
        return _length;
    }

    public function set length(value:uint):void {
        _length = value;
    }

    public function get is_reachable():Boolean {
        return _is_reachable;
    }

    public function set is_reachable(value:Boolean):void {
        _is_reachable = value;
    }

    public function get is_occupied():Boolean {
        return _is_occupied;
    }

    public function set is_occupied(value:Boolean):void {
        _is_occupied = value;
    }
}
}
