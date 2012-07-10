/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/10/12
 * Time: 12:53 PM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
import utils.PathfindUtils;

public class Bot extends ObjectBase{

    public static const SIMPLE_TYPE:int = 1;

    protected var _x_px:int; // may be not directly connected with tiled x and y
    protected var _y_px:int;

//    protected var _pathfinding_nodes:Vector.<PNode> = new Vector.<PNode>();


    protected var _grid:IsoGrid;
    protected var _path:Array = [];

    public function Bot(type:int, grid:IsoGrid) {
        _type = type;
        init(grid);
    }

    private function init(grid:IsoGrid):void {
        if(!grid)
            throw new Error("Bot -> init(): grid is null");

        _grid = grid;
    }

    public function find_path(end:IsoTile):void{
        _path = PathfindUtils.a_star_find_path(position_tile, end, _grid.get_four_connected_p_nodes);
    }

    public function get position_tile():IsoTile{
        return _grid.get_tile(x, y);
    }

    public function get x_px():int {
        return _x_px;
    }

    public function set x_px(value:int):void {
        _x_px = value;
    }

    public function get y_px():int {
        return _y_px;
    }

    public function set y_px(value:int):void {
        _y_px = value;
    }
}
}
