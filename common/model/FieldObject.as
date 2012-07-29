/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:11 PM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
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

    public function create_spawn_point(grid:IsoGrid, bots_count:uint = 0):void {
        if(bots_count == 0)
            return;

        var nearest_points:Vector.<Point> = get_nearest_points(grid);

        if(nearest_points.length == 0)
            throw new Error("can`t create spawn point");

        var p:Point = nearest_points[0];
        _spawn_point = new SpawnPoint(p.x, p.y);

        var t:IsoTile = grid.get_tile(p.x,  p.y);
        t.is_spawn = true;

        for (var i:uint = 0; i < bots_count; i++){
            _spawn_point.add_bot(new Bot(1));
        }
    }

    public function create_target_point(grid:IsoGrid, bots_type:String, bots_count:uint = 5):void {
        if(bots_count == 0)
            return;

        var nearest_points:Vector.<Point> = get_nearest_points(grid);

        if(nearest_points.length == 0)
            throw new Error("can`t create target point");

        var p:Point = nearest_points[0];
        _target_point = new TargetPoint(p.x, p.y, bots_type, bots_count);

        var t:IsoTile = grid.get_tile(p.x,  p.y);
        t.is_target = true;
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
}
}
