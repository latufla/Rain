/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/8/00
 * Time: 00:49 PM
 * To change this template use File | Settings | File Templates.
 */
package utils.creator {
import common.controller.FieldController;
import common.controller.FieldObjectController;
import common.model.Bot;
import common.model.FieldObject;
import common.model.SpawnPoint;

import flash.geom.Point;

import flash.utils.setTimeout;

import utils.FieldUtils;

public class DemoFieldCreator {

    private static const GRID:Array = [
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ];

    private static const OBJECTS:Array = [
        {x:27, y:26, w:2, l:3, h:2, b: 50},
        {x:6, y:2, w:1, l:3, h:2, b: 50},
        {x:23, y:14, w:2, l:2, h:2, b: 50},
        {x:11, y:2, w:2, l:4, h:2, b: 50},
        {x:14, y:6, w:1, l:3, h:2, b: 50},
        {x:10, y:17, w:2, l:2, h:4, b: 50},
        {x:27, y:1, w:2, l:2, h:2, b: 100},
        {x:16, y:17, w:2, l:3, h:2, b: 50},
        {x:24, y:22, w:3, l:1, h:2, b: 50}
    ]

    private static const PASSIVE_OBJECTS:Array = [
        {x:6, y:9, w:1, l:3, h:2},
        {x:2, y:12, w:5, l:2, h:2},
        {x:1, y:16, w:1, l:3, h:2},
        {x:2, y:21, w:4, l:1, h:2},
        {x:5, y:19, w:3, l:1, h:2},
        {x:9, y:21, w:2, l:1, h:2},
        {x:1, y:22, w:1, l:2, h:4},
        {x:3, y:27, w:3, l:2, h:2, t:true, tp:1},
        {x:13, y:26, w:1, l:2, h:2},
        {x:13, y:22, w:1, l:3, h:2},
        {x:17, y:27, w:1, l:2, h:2},
        {x:17, y:23, w:1, l:3, h:4},
        {x:17, y:21, w:1, l:1, h:2},
        {x:17, y:13, w:1, l:2, h:2},
        {x:15, y:11, w:2, l:1, h:2},

        {x:19, y:28, w:1, l:1, h:3, t:true, tp:2},
        {x:19, y:24, w:1, l:3, h:4},
        {x:19, y:16, w:1, l:5, h:2},
        {x:9, y:11, w:3, l:1, h:3},
        {x:13, y:12, w:1, l:3, h:2}
    ]

    private static const BOTS:Array = [
//        {x:11, y:10, w:1, l:1},
//        {x:13, y:10, w:1, l:1},
//        {x:14, y:10, w:1, l:1},
//        {x:15, y:10, w:1, l:1},
//        {x:15, y:9, w:1, l:1},
//        {x:15, y:8, w:1, l:1},
//        {x:15, y:7, w:1, l:1}
    ]

    public function DemoFieldCreator() {
    }

    public static function create():FieldController{
        var field_c:FieldController = new FieldController();
        field_c.create_grid(GRID.length, GRID[i].length);
//
//        field_c.create_grid(20, 20);
//
        for (var i:int = 0; i < GRID.length; i++) {
            for (var j:int = 0; j < GRID[i].length; j++) {
                switch (GRID[i][j]){
                    case 0:
                        field_c.grid.get_tile(i, j).is_reachable = false;
                        break;
                    case 2:
                        field_c.grid.get_tile(i, j).is_target = true;
                    default:
                        // do nothing
                }
            }
        }
//
//        FieldUtils.debug_generate_random_buildings(field_c);

        for each (var p:Object in OBJECTS){
            var b:FieldObject = new FieldObject(p.w, p.l, p.h);
            b.move_to(p.x, p.y);
            field_c.add_building(b, 5);
        }

        for each (var p:Object in PASSIVE_OBJECTS){
            var b:FieldObject = new FieldObject(p.w, p.l, p.h);
            b.move_to(p.x, p.y);

            if(p.t)
                b.create_target_point(p.tp);

            field_c.add_building(b);
        }

        trace("TB: ", field_c.target_buildings);

        return field_c;
    }
}
}
