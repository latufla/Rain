/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/8/00
 * Time: 00:49 PM
 * To change this template use File | Settings | File Templates.
 */
package utils.creator {
import common.controller.FieldController;
import common.model.FieldObject;

import flash.utils.setTimeout;

public class DemoFieldCreator {

    private static const GRID:Array = [
        [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
        [0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1],
        [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1],
        [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1],
        [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ];

    private static const OBJECTS:Array = [
//         { x:3, y:3, w:1, l:1 },
//                 { x:3, y:4, w:2, l:2 },
//                 { x:3, y:6, w:2, l:1 },
//                 { x:4, y:7, w:1, l:1 },
//                 { x:5, y:3, w:1, l:2 },
//                 { x:5, y:5, w:1, l:2 },
//                 { x:6, y:3, w:1, l:1 },
//                 { x:6, y:4, w:2, l:2 },
//                 { x:6, y:6, w:1, l:1 },
//                 { x:7, y:3, w:1, l:1 }
//        {x:9, y:1, w:1, l:2},
//        {x:11, y:6, w:1, l:2},
//        {x:1, y:3, w:1, l:2},
//        {x:4, y:8, w:1, l:2},
//        {x:2, y:11, w:1, l:3},
//        {x:9, y:11, w:2, l:2},
//        {x:3, y:16, w:2, l:2},
//        {x:12, y:16, w:1, l:3},
//        {x:15, y:11, w:3, l:1},
//        {x:14, y:7, w:1, l:3}
        {x:2, y:10, w:1, l:1},
        {x:3, y:10, w:1, l:1},
        {x:4, y:10, w:1, l:1},
        {x:5, y:10, w:1, l:1},
        {x:5, y:9, w:1, l:1},
        {x:5, y:8, w:1, l:1},
        {x:5, y:7, w:1, l:1},
        {x:4, y:7, w:1, l:3}
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
        field_c.create_grid(12, 12);

//        for (var i:int = 0; i < GRID.length; i++) {
//            for (var j:int = 0; j < GRID[i].length; j++) {
//                switch (GRID[i][j]){
//                    case 0:
//                        field_c.grid.get_tile(i, j).is_reachable = false;
//                        break;
//                    case 2:
//                        field_c.grid.get_tile(i, j).is_target = true;
//                    default:
//                        do nothing
//                }
//            }
//        }

        field_c.debug_generate_random_buildings();

//        for each (var p:Object in OBJECTS){
//            field_c.create_building(p.x, p.y, p.w, p.l);
//        }
//
//        field_c.resolve_spawn_points();
//
//        var b:FieldObject;
//        var j:int = 0;
//        for each (var p:* in field_c.buildings){
//            b = p.object;
//            i = 0;
//            j += 70
//            while(i++ < 30){
//                setTimeout(field_c.create_bot, i * 1000 + j, b.spawn_point.x, b.spawn_point.y);
//            }
//        }
//
//        for each (var p:Object in BOTS){
//            i = 0;
//            while(i++ < 20)
//                setTimeout(field_c.create_bot, i * 1000, p.x, p.y, p.w, p.l);
//            field_c.create_bot(p.x, p.y);
//        }

        return field_c;
    }
}
}
