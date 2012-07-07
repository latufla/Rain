/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 6/25/12
 * Time: 10:13 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import utils.MovieClipHelper;

// width and height are single
// real width and real heights counts by Field.TILE_WIDTH, Field.TILE_WIDTH
public class Tile {
    private static const NON_REACHABLE_COLOR:uint = 0xFF0000;
    private static const REACHABLE_COLOR:uint = 0x00FF00;

    private var _x:int;
    private var _y:int;
    private var _is_reachable:Boolean = true;

    // A* - TODO: move next to another class
    private var _f:int;
    private var _g:int;
    private var _h:int;
    private var _parent_node:Tile;
    // A*

    private var _debug_info:TextField = new TextField();

    private var _debug_type:int = 0;
    public static const DEBUG_KEY_POINT:int = 1;
    public static const DEBUG_OPTIONAL_POINT:int = 2;
    private static const DEBUG_COLORS:Array = [REACHABLE_COLOR, 0x0000FF, 0xC2C3C2];

    public function Tile(x:int, y:int) {
        _x = x;
        _y = y;
    }


    public function draw(layer:Sprite):void {
        var color:uint = DEBUG_COLORS[debug_type];

        if(!is_reachable)
            color = NON_REACHABLE_COLOR;


        layer.graphics.beginFill(color, 0.2);
        layer.graphics.lineStyle(1, color);
        layer.graphics.drawRect(_x * Field.TILE_WIDTH, _y * Field.TILE_HEIGHT, Field.TILE_WIDTH - 2, Field.TILE_HEIGHT - 2);
        layer.graphics.endFill();

        draw_debug_field(layer);
    }

    private function draw_debug_field(layer:Sprite):void {
        _debug_info.x = _x * Field.TILE_WIDTH;
        _debug_info.y = _y * Field.TILE_HEIGHT;

        _debug_info.autoSize = TextFieldAutoSize.LEFT;
        _debug_info.text = "x: " + x + " y: " + y;
//        layer.addChild(_debug_info);
    }

    public function fill_pathfinding_params(parent:Tile, f:int, g:int, h:int):void{
        _f = f;
        _g = g;
        _h = h;
        _parent_node = parent;
        _debug_type = Tile.DEBUG_OPTIONAL_POINT;
    }

    public function clear():void{
        MovieClipHelper.try_remove(_debug_info);
    }

    public function get x():int {
        return _x;
    }

    public function set x(value:int):void {
        _x = value;
    }

    public function get y():int {
        return _y;
    }

    public function set y(value:int):void {
        _y = value;
    }

    public function get f():int {
        return _f;
    }

    public function set f(value:int):void {
        _f = value;
    }

    public function get g():int {
        return _g;
    }

    public function set g(value:int):void {
        _g = value;
    }

    public function get h():int {
        return _h;
    }

    public function set h(value:int):void {
        _h = value;
    }

    public function get parent_node():Tile {
        return _parent_node;
    }

    public function set parent_node(value:Tile):void {
        _parent_node = value;
    }

    public function get is_reachable():Boolean {
        return _is_reachable;
    }

    public function set is_reachable(value:Boolean):void {
        _is_reachable = value;
    }

    public function get debug_info():TextField {
        return _debug_info;
    }

    public function get debug_type():int {
        return _debug_type;
    }

    public function set debug_type(value:int):void {
        _debug_type = value;
    }
}
}
