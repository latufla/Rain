/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/28/12
 * Time: 12:11 PM
 * To change this template use File | Settings | File Templates.
 */
package common.model {

public class SpawnPoint {

    private var _x:uint; // tile field pos
    private var _y:uint;



    private var _bots:Vector.<Bot> = new Vector.<Bot>();
    private var _next_bot_id:uint  = 0;
    private var _interval:Number = 1000;

    public function SpawnPoint(x:uint, y:uint) {
        _x = x;
        _y = y;
    }

    public function next_bot():Bot{
        if(_next_bot_id >= _bots.length)
            return null;

        return _bots[_next_bot_id++];
    }

    public function add_bot(o:Bot):void{
        o.move_to(_x, _y);
        _bots.push(o);
    }

    public function remove_bot(o:Bot):Bot{
        var idx:int = bots.indexOf(o);
        if(idx == -1)
            return null;

        bots.splice(idx, 1);
        return o;
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

    public function get bots():Vector.<Bot> {
        return _bots;
    }

    public function set bots(value:Vector.<Bot>):void {
        _bots = value;
    }

    public function get interval():Number {
        return _interval;
    }

    public function set interval(value:Number):void {
        _interval = value;
    }
}
}
