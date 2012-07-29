/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/28/12
 * Time: 8:51 PM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
public class TargetPoint {

    private var _x:uint; // tile field pos
    private var _y:uint;

    private var _priority:int = -1; // -1 is inactive

    private var _bots_type:String;
    private var _bots_count:uint;

    private var _cur_count:uint;

    public function TargetPoint(x:uint, y:uint, bots_type:String = "def", bots_count:uint = 5) {
        _x = x;
        _y = y;
        _bots_type  = bots_type;
        _bots_count = bots_count;
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

    public function get cur_count():uint {
        return _cur_count;
    }

    public function set cur_count(value:uint):void {
        _cur_count = value;
    }

    public function get priority():int {
        return _priority;
    }

    public function set priority(value:int):void {
        _priority = value;
    }
}
}
