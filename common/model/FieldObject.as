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

    public function FieldObject(w:uint, l:uint, h:uint) {
        _id = count++;

        width = w;
        length = l;
        _debug_height = h;
    }

    public function create_default_spawn_point(grid:IsoGrid, bot_count:uint = 0):void {
        if(bot_count == 0)
            return;

        var nearest_points:Vector.<Point> = get_nearest_points(grid);

        if(nearest_points.length == 0)
            throw new Error("can`t create spawn point");

        var p:Point = nearest_points[0];
        _spawn_point = new SpawnPoint(p.x, p.y);

        for (var i:uint = 0; i < bot_count; i++){
            _spawn_point.add_bot(new Bot(1));
        }
    }


    public function get spawn_point():SpawnPoint {
        return _spawn_point;
    }

    public function set spawn_point(value:SpawnPoint):void {
        _spawn_point = value;
    }
}
}
