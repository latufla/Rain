/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/8/00
 * Time: 00:49 PM
 * To change this template use File | Settings | File Templates.
 */
package utils.creator {
import common.controller.FieldController;

import flash.utils.setTimeout;

public class DemoFieldCreator {

    private static const GRID:Array = [
        [0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1],
        [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ];

    private static const OBJECTS:Array = [
        {x:9, y:1, w:1, l:2},
        {x:11, y:6, w:1, l:2},
        {x:1, y:3, w:1, l:2},
//        {x:3, y:10, w:1, l:1},
        {x:2, y:8, w:1, l:3},
        {x:4, y:7, w:1, l:2},
        {x:9, y:11, w:2, l:2}
    ]

    private static const BOTS:Array = [
        {x:8, y:1, w:1, l:1},
        {x:12, y:6, w:1, l:1}
    ]

    public function DemoFieldCreator() {
    }

    public static function create():FieldController{
        var field_c:FieldController = new FieldController();
        field_c.create_grid(GRID.length, GRID[0].length);

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

        for each (var p:Object in OBJECTS){
            field_c.create_building(p.x, p.y, p.w, p.l);
        }


        for each (var p:Object in BOTS){
            i = 0;
            while(i++ < 25)
                setTimeout(field_c.create_bot, i * 1000, p.x, p.y, p.w, p.l);
        }

        return field_c;
    }
}
}
