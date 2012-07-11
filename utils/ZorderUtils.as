package utils {
import common.controller.FieldObjectController;
import common.model.ObjectBase;

import flash.utils.getTimer;

public class ZorderUtils {

//    public static function custom_zorder(list:Vector.<ObjectBase>):Vector.<ObjectBase>{
//        var start_time:Number = getTimer();
//        var res:Vector.<ObjectBase> = list.sort(tile_object_compare);
//        trace("custom_zorder end. Elapsed: ", getTimer() - start_time);
//        return res;
//    }


    public static function custom_zorder(list:Array):Array{
        var start_time:Number = getTimer();
        var res:Array = list.sort(tile_object_compare);
        trace("custom_zorder end. Elapsed: ", getTimer() - start_time);
        return res;
    }

    public static function tile_object_compare(a_c:*, b_c:*):int{
        var a:ObjectBase = a_c.object;
        var b:ObjectBase = b_c.object;

        if(a.x > b.x && a.bottomDiagonalId >= b.topDiagonalId)
            return 1;

        if(a.y >= b.y + b.length && a.topDiagonalId > b.bottomDiagonalId)
            return 1;

        return -1;
    }

//    public static function tile_object_compare(a:ObjectBase, b:ObjectBase):int{
//        if(a.x > b.x && a.bottomDiagonalId >= b.topDiagonalId)
//            return 1;
//
//        if(a.y + a.length <= b.y && a.topDiagonalId > b.bottomDiagonalId)
//            return 1;
//
//        return -1;
//    }


//    public static function insert_resort_single_object(obj:ObjectBase, v:Vector.<ObjectBase>):void {
//        if(tile_object_compare(v[0], obj) == 1){
//            v.unshift(obj);
//            return;
//        }
//
//        if(tile_object_compare(v[v.length - 1], obj) == -1){
//            v.push(obj);
//            return;
//        }
//
//        find first top in ordered view_list
//        for (var i:int = 0; i < v.length; i++) {
//            if(tile_object_compare(v[i], obj) == 1){
//                v.splice(i, 0, obj);
//                return;
//            }
//        }
//    }

    public static function insert_resort_single_object(obj_c:*, a:Array):void {
        if(tile_object_compare(a[0], obj_c) == 1){
            a.unshift(obj_c);
            return;
        }

        if(tile_object_compare(a[a.length - 1], obj_c) == -1){
            a.push(obj_c);
            return;
        }

//        find first top in ordered view_list
        for (var i:int = 0; i < a.length; i++) {
            if(tile_object_compare(a[i], obj_c) == 1){
                a.splice(i, 0, obj_c);
                return;
            }
        }
    }
}
}
