/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/28/12
 * Time: 8:51 PM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
import common.controller.ControllerBase;
import common.event.GameEvent;

import flash.events.EventDispatcher;

public class TargetPoint extends EventDispatcher{

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

    public function apply_params_to_grid():void{
        var t:IsoTile = tile;
        if(t)
            t.is_target = true;
    }

    public function remove_params_from_grid():void{
        var t:IsoTile = tile;
        if(t)
            t.is_target = false;
    }

    public function refresh():void {
        var t:IsoTile = tile;
        if(!t)
            return;

        var bots:Vector.<ControllerBase> = t.bots;
        if (bots.length >= _bots_count){
            dispatchEvent(new GameEvent(GameEvent.COMPLETE_TARGET, {object:this}));
        }
    }

    public function get tile():IsoTile{
        return Config.field_c.grid.get_tile(_x, _y);
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
