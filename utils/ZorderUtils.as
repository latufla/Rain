package utils {
import common.controller.ControllerBase;
import common.controller.FieldObjectController;
import common.model.IsoGrid;
import common.model.IsoTile;
import common.model.ObjectBase;

import flash.utils.getTimer;

public class ZorderUtils {

    public static function custom_zorder(list:Array):Array{
//        var start_time:Number = getTimer();
        var res:Array = list.sort(function(a_c:*, b_c:*):int{
            var i:int = tile_object_compare(a_c, b_c);
            trace("---step---");
            trace("a:", a_c.object.x, a_c.object.y, "|", a_c.object.id, "vs", "b:", b_c.object.x, b_c.object.y, "|", b_c.object.id, "=", i);
            return i;
        })
//        trace("custom_zorder end. Elapsed: ", getTimer() - start_time);
        return res;
    }

    public static function tile_object_compare(a_c:*, b_c:*):int{
        var a:ObjectBase = a_c.object;
        var b:ObjectBase = b_c.object;

//        determine same tile objects
//        if(a.x == b.x && a.y == b.y){
//            if(a.id < b.id)
//                return 1;
//            else
//                return -1;
//        }

        if (a.right <= b.left)
            return -1;
        else if (a.left >= b.right)
            return 1;
        else if (a.front <= b.back)
            return -1;
        else if (a.back >= b.front)
            return 1;

        return 0;
//        determine same tile objects

//
//        if(a.x > b.x && a.bottomDiagonalId >= b.topDiagonalId)
//            return 1;
//
//        if(a.y >= b.y + b.length && a.topDiagonalId > b.bottomDiagonalId)
//            return 1;
//
//        return -1;
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

    public static function bin_insert_resort_single_object(obj_c:*, a:Vector.<ControllerBase>):int{
        if(a.length == 0 || tile_object_compare(a[0], obj_c) != -1){
            a.unshift(obj_c);
            return 0;
        }

        if(tile_object_compare(a[a.length - 1], obj_c) == -1){
            a.push(obj_c);
            return a.length - 1;
        }

        var idx:int = ArrayUtils.get_insert_index_in_sorted(a, obj_c, tile_object_compare);
        a.splice(idx, 0, obj_c);
        return idx;
    }


    // walk through verticals
    public static function z_sort(grid:IsoGrid):Vector.<ControllerBase>{
        var res:Vector.<ControllerBase> = new Vector.<ControllerBase>();

        // traverse
        var cur_elem:ControllerBase;
        var cur_vert:Vector.<IsoTile>;
        var already_traversed_in_vertical:Vector.<ControllerBase> = new Vector.<ControllerBase>();
        for (var i:int = 0; i < grid.tiles.length; i++) {
            already_traversed_in_vertical = new Vector.<ControllerBase>();
            cur_vert = get_vertical(grid, i);
            for (var j:int = cur_vert.length - 1; j >= 0; j--) {
                if(cur_vert[j].field_object_c){
                    cur_elem = cur_vert[j].field_object_c;

                    // first found in vertical
                    if(res.length == 0){
                       res.push(cur_elem);
                       already_traversed_in_vertical.push(cur_elem);
                       cur_elem.static_zordered = true;
                        continue;
                    }

                    // not in res, then insert it before last traversed
                    //if(res.indexOf(cur_elem) == -1){
                    if(!cur_elem.static_zordered){
                        if(already_traversed_in_vertical.length == 0){
                            res.push(cur_elem);
                        } else{
                            var last_traversed:ControllerBase = already_traversed_in_vertical[already_traversed_in_vertical.length - 1];
                            var idx:int = res.indexOf(last_traversed);
                            res.splice(idx, 0, cur_elem);
                        }
                    }

                    cur_elem.static_zordered = true;
                    already_traversed_in_vertical.push(cur_elem);
                }

            }
        }

        return res;
    }


    public static function get_vertical(grid:IsoGrid, id:uint):Vector.<IsoTile>{
        if(id >= grid.tiles.length)
            return null;

        return grid.tiles[id];
    }

    // TODO: think about field borders
    // 1 x 1 object
    public static function insert_resort_single_object(o_c:ControllerBase, all_objects:Vector.<ControllerBase>, grid:IsoGrid):void{
        // traverse cur vert down
        // if any object - > insert o_c before
        var insert_obj:ObjectBase = o_c.object;
        if(insert_obj.width != 1 || insert_obj.length != 1)
            throw new Error("object not single!");

        var cur_obj:ObjectBase;
        var cur_vert:Vector.<IsoTile> = get_vertical(grid, insert_obj.x);
        trace("insert_obj", insert_obj.x, insert_obj.y);
        for(var i:int = insert_obj.y + 1; i < grid.length; i++){
            if(!cur_vert[i].field_object_c || !cur_vert[i].field_object_c.object)
                continue;

            cur_obj = cur_vert[i].field_object_c.object;

//            if (cur_obj.x + cur_obj.width - 1 != insert_obj.x)
//                continue;
//
            all_objects.splice(all_objects.indexOf(cur_vert[i].field_object_c), 0, o_c);
            return;
        }

//        // all verts before and down
//        for (i = insert_obj.x - 1; i >= 0; i--) {
//            cur_vert = get_vertical(grid, i);
//            for (var j:int = grid.length - 1; j >= insert_obj.x; j--) {
//                if(!cur_vert[j].field_object_c || !cur_vert[j].field_object_c.object)
//                    continue;
//
//                if(cur_vert[j].field_object_c.object.x == i && cur_vert[j].field_object_c.object.y == j){
//                    all_objects.splice(all_objects.indexOf(cur_vert[j].field_object_c) + 1, 0, o_c);
//                    return;
//                }
//            }
//        }


//                // traverse cur vert up
//        // if any object -> insert o_c after
//        for(i = insert_obj.y - 1; i >= 0; i--){
//            if(!cur_vert[i].field_object_c || !cur_vert[i].field_object_c.object)
//                continue;
//
//            if(cur_vert[i].field_object_c.object.x == insert_obj.x){
//                all_objects.splice(all_objects.indexOf(cur_vert[i].field_object_c) + 1, 0, o_c);
//                return;
//            }
//
//            break;
//        }
//
//        // traverse all verts before
//        // if any object -> insert o_c after
//        var cur_obj_was_in_vert:Boolean;
//        for (i = insert_obj.x - 1; i >= 0; i--) {
//            cur_vert = get_vertical(grid, i);
//            for (var j:int = grid.length - 1; j >= 0; j--) {
//                if(!cur_vert[j].field_object_c || !cur_vert[j].field_object_c.object)
//                    continue;
//
//
//                if(cur_vert[j].field_object_c.object.y >= insert_obj.y){
//                    all_objects.splice(all_objects.indexOf(cur_vert[j].field_object_c) + 1, 0, o_c);
//                    return;
//                }
//                    trace("really were here")
//                if(cur_vert[j].field_object_c.object.x == i && cur_vert[j].field_object_c.object.y == j){
//                    all_objects.splice(all_objects.indexOf(cur_vert[j].field_object_c) + 1, 0, o_c);
//                    return;
//                }
//            }
//        }
//
//        // traverse cur vert up
//        // if any object -> insert o_c after
////        cur_vert = get_vertical(grid, insert_obj.x);
////        for(i = insert_obj.y - 1; i >= 0; i--){
////            if(!cur_vert[i].field_object_c || !cur_vert[i].field_object_c.object)
////                continue;
////
////            all_objects.splice(all_objects.indexOf(cur_vert[i].field_object_c) + 1, 0, o_c);
////            return;
////        }
//
//        all_objects.unshift(o_c);
    }
}
}
