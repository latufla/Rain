/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 4:04 PM
 * To change this template use File | Settings | File Templates.
 */
package common.view {
import common.controller.FieldController;
import common.model.IsoGrid;
import common.model.IsoTile;

import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;

import utils.DebugUtils;
import utils.MovieClipHelper;

public class IsoGridView extends Sprite{

    private var _grid:IsoGrid;
    private var _tile_renderer:IsoTileRenderer = new IsoTileRenderer(apply_axises);

    private var _debug_fields:Array = [];
    private var _used_debug_fields:Array = [];

    public function IsoGridView() {
    }

    public function draw():void{
        if(!_grid)
            throw new Error("IsoGridView -> draw(): grid is null" );

        clear_debug_fields();

        graphics.clear();

        DebugUtils.start_profile_block("IsoGridView -> draw()");
        var self:Sprite = this;
        _grid.tiles.forEach(function (v:Vector.<IsoTile>, index:int, vector:Vector.<Vector.<IsoTile>>):void{
            v.forEach(function (tile:IsoTile, index:int, vector:Vector.<IsoTile>):void{
                _tile_renderer.draw(tile, self);
                _tile_renderer.draw_debug_info(tile, self, create_debug_field());
            });
        });

        align_by_bounds();
        DebugUtils.stop_profile_block("IsoGridView -> draw()")
    }

    private function create_debug_field():TextField{
        var debug_field:TextField = _debug_fields.pop();
        if(!debug_field)
            debug_field = new TextField();

        debug_field.mouseEnabled = false;
        _used_debug_fields.push(debug_field);

        return debug_field;
    }

    private function clear_debug_fields():void {
        for each(var p:TextField in _used_debug_fields){
            MovieClipHelper.try_remove(p);
        }
        _debug_fields =_debug_fields.concat(_used_debug_fields);
        _used_debug_fields = [];
    }

    private function align_by_bounds():void{
        var bounds:Rectangle = getBounds(this);
        x = -bounds.x;
        y = -bounds.y;
    }

    private var pnt:Point = new Point();
    public function apply_axises(tile:IsoTile):Point{
        pnt.x = apply_x_axis(tile);
        pnt.y = apply_y_axis(tile);
        return pnt;
    }

    public function apply_x_axis(tile:IsoTile):int{
        return tile.x * FieldController.TILE_HEIGHT;
    }

    public function apply_y_axis(tile:IsoTile):int{
        var y_inv:int = _grid.height - 1;
        return (y_inv - tile.y) * FieldController.TILE_HEIGHT;
    }

    public function get grid():IsoGrid {
        return _grid;
    }

    public function set grid(value:IsoGrid):void {
        _grid = value;
    }
}
}
