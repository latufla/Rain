package utils {
import flash.utils.getTimer;

public class ZorderUtils {
    private static var _zorder_helper:ZOrderHelper = new ZOrderHelper();

    // precondition: для всех объектов из list установлены object_positions.
    public static function zorder_topological_sort(list:Array):Array {
        var i:int;
        var j:int;

        var len:int = list.length;
        var obj: ObjectBase;

        var is_obj:Array = new Array(len);
        var xs:Array = new Array(len);
        var x_ps:Array = new Array(len);
        var ys:Array = new Array(len);
        var y_ps:Array = new Array(len);
        var layers:Array = new Array(len);

        for(i=0; i<list.length; i++) {
            obj = list[i] as ObjectBase;
            is_obj[i] = obj != null;
            if (is_obj[i]) {
                xs[i] = obj.x_tile;
                x_ps[i] = obj.y_tile;
                ys[i] = obj.w_tile;
                y_ps[i] = obj.h_tile;
                layers[i] = obj.z_layer;
            }
        }
        var res:Array = _zorder_helper.zorder_topological_sort(is_obj, xs, x_ps, ys, y_ps, layers);
        return res.map(function(item:*, index:int, arr:Array):ObjectBase {return list[item] as ObjectBase;});
    }

    public static function custom_zorder(list:Vector.<ObjectBase>):Vector.<ObjectBase>{
        var start_time:Number = getTimer();
        var res:Vector.<ObjectBase> = list.sort(tile_object_compare);
        trace("custom_zorder end. Elapsed: ", getTimer() - start_time);
        return res;
    }

    public static function tile_object_compare(a:ObjectBase, b:ObjectBase):int{
        if(a.x_tile > b.x_tile && a.bottomDiagonalId >= b.topDiagonalId)
            return 1;

        if(a.y_tile + a.h_tile <= b.y_tile && a.topDiagonalId > b.bottomDiagonalId)
            return 1;

        return -1;
    }

    public static function insert_resort_single_object(obj:ObjectBase, v:Vector.<ObjectBase>):void {
        if(tile_object_compare(v[0], obj) == 1){
            v.unshift(obj);
            return;
        }

        if(tile_object_compare(v[v.length - 1], obj) == -1){
            v.push(obj);
            return;
        }

        // find first top in ordered view_list
        for (var i:int = 0; i < v.length; i++) {
            if(tile_object_compare(v[i], obj) == 1){
                v.splice(i, 0, obj);
                return;
            }
        }
    }

}
}
