/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 4:35 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import common.model.FieldObject;
import common.model.FieldObjectsList;
import common.model.IsoGrid;
import common.model.IsoTile;
import common.view.FieldObjectView;
import common.view.IsoGridView;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import utils.iso.IsoMathUtil;

public class FieldController {
    public static const TILE_WIDTH:uint = 50;
    public static const TILE_LENGTH:uint = 50;

    private var _grid:IsoGrid;
    private var _grid_view:IsoGridView = new IsoGridView();

    private var _building:FieldObject;
    private var _building_c:FieldObjectController;
    private var _buildings_map:Sprite = new Sprite();

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

    public function create_building(x:uint, y:uint, w:uint, l:uint):void{
        _building = new FieldObject(w, l, 2);
        _building.x = x;
        _building.y = y;

        _building_c = new FieldObjectController();
        _building_c.object = _building;
        _building_c.draw();

        _buildings_map.x = _grid_view.x;
        _buildings_map.y = _grid_view.y;
        _buildings_map.addChild(_building_c.view);
        _view.addChild(_buildings_map);
    }

    public function draw_grid():void{
        _grid_view.draw();
        _view.addChild(_grid_view);

        create_building(5, 5, 1, 1);
    }

    private function on_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX, e.localY);
        var inv_y:uint = _grid.length;
        var tiles:Array = _grid.get_tiles_in_square(coords.x / TILE_WIDTH, inv_y - coords.y / TILE_LENGTH, 3, 2);
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
