/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:11 PM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
public class FieldObject extends ObjectBase{

    protected var _is_target:Boolean;
    private var _bots:Array;

    private var _debug_height:uint;

    public function FieldObject(w:uint, l:uint, h:uint) {
        width = w;
        length = l;
        _debug_height = h;
    }

    public function get is_target():Boolean {
        return _is_target;
    }

    public function set is_target(value:Boolean):void {
        _is_target = value;
    }

    public function get bots():Array {
        return _bots;
    }

    public function get debug_height():uint {
        return _debug_height;
    }

    public function set debug_height(value:uint):void {
        _debug_height = value;
    }
}
}
