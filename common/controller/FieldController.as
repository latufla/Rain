/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 4:35 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import common.model.IsoGrid;
import common.model.IsoTile;
import common.view.IsoGridView;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import utils.iso.IsoMathUtil;

public class FieldController {
    public static const TILE_WIDTH:uint = 50;
    public static const TILE_HEIGHT:uint = 50;

    private var _grid:IsoGrid;
    private var _grid_view:IsoGridView = new IsoGridView();

    private var _view:Sprite = new Sprite();

    public function FieldController() {
        init();
    }

    private function init():void {
        _view.addEventListener(MouseEvent.CLICK, on_click);
    }

    public function create_grid(w:uint, h:uint):void{
        _grid = new IsoGrid(w, h);
        _grid.create();
//        _grid.debug_generate_random(0.7);
//        _grid.resize(5, 5);
//        _grid.resize(11, 11);
        _grid_view.grid = _grid;
    }

    public function draw_grid():void{
        _grid_view.draw();
        _view.addChild(_grid_view);
    }

    private function on_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX, e.localY);
        var inv_y:uint = _grid.height;
        var tiles:Array = _grid.get_tiles_in_square(coords.x / TILE_WIDTH, inv_y - coords.y / TILE_HEIGHT, 3, 2);
        for each(var p:IsoTile in tiles){
            p.is_reachable = !p.is_reachable;
        }

        draw_grid();
    }

    public function get view():Sprite {
        return _view;
    }

    public function get grid():IsoGrid{
        return _grid;
    }
}
}
