/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 6/25/12
 * Time: 11:35 PM
 * To change this template use File | Settings | File Templates.
 */
package utils {

public class PathfindUtils {
    public static var heuristic:Function = PathfindUtils.mantattan_tie_breaks_heuristic;

    public static var ort_cost:int = 10000;// to avoid Number
    public static var dia_cost:int = 14000;

    public function PathfindUtils() {
    }


    public static function find_path(first_node:Tile, destination_node:Tile, connected_node_function:Function ):Array 	{
        DebugUtils.start_profile_block("find_path");
        var open_nodes:Array = []; // sortOn
        var closed_nodes:Vector.<Tile> = new Vector.<Tile>();
        var current_node:Tile = first_node;
        var test_node:Tile;
        var connected_nodes:Array;
        var travel_cost:int = ort_cost;
        var g:int;
        var h:int;
        var f:int;
        current_node.g = 0;
        current_node.h = heuristic(first_node, current_node, destination_node);
        current_node.f = current_node.g + current_node.h;
        var l:int;
        var i:int;

        while (current_node != destination_node) {
            connected_nodes = connected_node_function(current_node);

            l = connected_nodes.length;
            for (i = 0; i < l; i++) {
                test_node = connected_nodes[i];

                g = current_node.g  + travel_cost;
                h = heuristic(first_node, test_node, destination_node);
                f = g + h;

                if (open_nodes.indexOf(test_node) != -1 || closed_nodes.indexOf(test_node) != -1)	{
                    if(test_node.f > f)
                        test_node.fill_pathfinding_params(current_node, f, g, h);
                }else {
                    test_node.fill_pathfinding_params(current_node, f, g, h);
                    open_nodes.push(test_node);
                }
            }

            closed_nodes.push(current_node);

            if (open_nodes.length == 0)
                return null;

            open_nodes.sortOn('f', Array.NUMERIC);
            current_node = open_nodes.shift() as Tile;
        }

        DebugUtils.stop_profile_block("find_path");
        return build_path(destination_node, first_node);
    }

    public static function build_path(destination_node:Tile, start_node:Tile):Array {
        var path:Array = [];
        var node:Tile = destination_node;
        path.push(node);
        while (node != start_node) {
            node = node.parent_node;
            path.unshift(node);
        }
        return path;
    }

    // HEURISTIC
    // 4 ortogonal ways
    public static function manhattan_heuristic(node:Tile, destinationNode:Tile, cost:int = 10):int{
        var dx:int = Math.abs(node.x - destinationNode.x);
        var dy:int = Math.abs(node.y - destinationNode.y);
        return (dx + dy) * cost;
    }

    public static function mantattan_tie_breaks_heuristic(start_node:Tile, node:Tile, destination_node:Tile, cost:int = 10000):int{
        var dx:int = abs(node.x - destination_node.x);
        var dy:int = abs(node.y - destination_node.y);
        var manhattan_h:int = (dx + dy) * cost;

        var dx1:int = node.x - destination_node.x
        var dy1:int = node.y - destination_node.y
        var dx2:int = start_node.x - destination_node.x
        var dy2:int = start_node.y - destination_node.y
        var cross:int = abs(dx1 * dy2 - dx2 * dy1);
        var tie_breaking_h:int = cross;

        return manhattan_h + tie_breaking_h;
    }

    private static function abs(value:int):int{
        return (value ^ (value >> 31)) - (value >> 31);
    }

    // 8 ways ort + dia
    public static function diagonal_heuristic(node:Tile, destinationNode:Tile, cost:int = 10, diagonalCost:int = 14):int{
        var dx:int = Math.abs(node.x - destinationNode.x);
        var dy:int = Math.abs(node.y - destinationNode.y);
        var diag:int = Math.min( dx, dy ); // MAX amount dia tiles we can pass through
        var straight:int = dx + dy; // manhattan
        return diagonalCost * diag + cost * (straight - 2 * diag);
    }

    public static function euclidian_heuristic(node:Tile, destinationNode:Tile, cost:int = 10):int {
        var dx:int = node.x - destinationNode.x;
        var dy:int = node.y - destinationNode.y;
        return Math.sqrt( dx * dx + dy * dy ) * cost;
    }

}
}
