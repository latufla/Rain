/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:11 PM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
import common.event.GameEvent;

import flash.geom.Point;

public class FieldObject extends ObjectBase{

    private var _spawn_point:SpawnPoint;
    private var _target_point:TargetPoint;

    public function FieldObject(w:uint, l:uint, h:uint) {
        super();

        width = w;
        length = l;
        _debug_height = h;
    }

    public function create_spawn_point(bots_count:uint = 0):void {
        if(bots_count == 0)
            return;

        var grid:IsoGrid = Config.field_c.grid;
        var nearest_points:Vector.<Point> = get_nearest_points(grid);

        if(nearest_points.length == 0)
            throw new Error("can`t create spawn point");

        var p:Point = nearest_points[0];
        _spawn_point = new SpawnPoint(p.x, p.y);

        var t:IsoTile = grid.get_tile(p.x,  p.y);
        t.is_spawn = true;

        for (var i:uint = 0; i < bots_count; i++){
            _spawn_point.add_bot(new Bot());
        }
    }

    public function create_target_point(pnt:Point = null, priority:int = 1, bots_type:String = "def", bots_count:uint = 5):void {
        if(bots_count == 0)
            return;

        var grid:IsoGrid = Config.field_c.grid;
        var nearest_points:Vector.<Point> = get_nearest_points(grid);

        if(nearest_points.length == 0)
            throw new Error("can`t create target point");

        var p:Point = pnt ? pnt : nearest_points[0];
        _target_point = new TargetPoint(p.x, p.y, bots_type, bots_count);
        _target_point.priority = priority;
        _target_point.apply_params_to_grid();
        _target_point.addEventListener(GameEvent.COMPLETE_TARGET, on_complete_target);
    }

    private function on_complete_target(e:GameEvent):void {
        dispatchEvent(new GameEvent(GameEvent.COMPLETE_TARGET, {object:e.data.object}));
    }

    public function remove_target_point():void{
        if(!_target_point)
            return;

        _target_point.remove_params_from_grid();
        _target_point = null;
    }

    public function get bots():Vector.<Bot> {
        if(!_spawn_point)
            return null;

        return _spawn_point.bots;
    }

    public function get spawn_interval():Number{
        if(!_spawn_point)
            return 2000;

        return _spawn_point.interval;
    }

    public function get next_bot():Bot{
        if(!_spawn_point)
            return null;

        return _spawn_point.next_bot();
    }

    public function get target_point():TargetPoint {
        return _target_point;
    }

    public function get has_spawn_point():Boolean{
        return _spawn_point;
    }
}
}
