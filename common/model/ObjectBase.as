/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:07 PM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
import utils.FieldUtils;

public class ObjectBase {

    protected var _x:uint;
    protected var _y:uint;
    protected var _width:uint = 1;
    protected var _length:uint = 1;
    protected var _debug_height:uint = 2;

    protected var _is_reachable:Boolean;
    protected var _is_occupied:Boolean;
    protected var _is_target:Boolean;
    protected var _type:int;

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

    public function get topDiagonalId():int{
        return (x + width) - (y  + length);
    }

    public function get bottomDiagonalId():int{
        return x - y;
    }

    public function intersects(o:ObjectBase):Boolean{
        var obj_1:Object = {x: x, y: y, w: width, h: length};
        var obj_2:Object = {x: o.x, y: o.y, w: o.width, h: o.length};
        return FieldUtils.intersects(obj_1, obj_2);
    }

    public function get is_target():Boolean {
        return _is_target;
    }

    public function set is_target(value:Boolean):void {
        _is_target = value;
    }

    public function get type():int {
        return _type;
    }

    public function set type(value:int):void {
        _type = value;
    }

    public function get debug_height():uint {
        return _debug_height;
    }

    public function set debug_height(value:uint):void {
        _debug_height = value;
    }
}
}
