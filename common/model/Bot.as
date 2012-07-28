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

//    protected var _x_px:int; // may be not directly connected with tiled x and y
//    protected var _y_px:int;

//    protected var _pathfinding_nodes:Vector.<PNode> = new Vector.<PNode>();


    private var _grid:IsoGrid;
    protected var _path:Array = [];
    protected var _target:IsoTile;

    public function Bot(type:int) {
        super();

        _type = type;
        _is_reachable = true;
        _debug_height = 1;
    }

    public function find_path(end:IsoTile):Array{
        _grid.clear_p_nodes();
        _path = PathfindUtils.a_star_find_path(position_tile, end, _grid.get_four_connected_p_nodes);
        return _path;
    }

    public function get position_tile():IsoTile{
        return _grid.get_tile(x, y);
    }

    public function find_target():IsoTile{
        return _grid.get_tile(0, 29);
    }

    public function find_path_to_target():Array{
        return find_path(find_target());
    }

    public function set grid(value:IsoGrid):void {
        if(!value)
            throw new Error("Bot -> set grid(): null argument");

        _grid = value;
    }
}
}
