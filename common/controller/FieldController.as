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

    private var _objects:Array = [];
    private var _objects_view:Sprite = new Sprite();

    private var _view:Sprite = new Sprite();

    public function FieldController() {
        init();
    }

    private function init():void {
        _view.addEventListener(MouseEvent.CLICK, on_click);
        _view.addChild(_grid_view);
        _view.addChild(_objects_view);
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
        var building:FieldObject = new FieldObject(w, l, 2);
        building.x = x;
        building.y = y;

        var building_c:FieldObjectController = new FieldObjectController();
        building_c.object = building;
        _objects.push(building_c);
    }

    public function draw_grid():void{
        _grid_view.draw();
    }

    public function draw_buildings():void{
        var inv_y:uint = _grid.length;

        for each(var p:FieldObjectController in _objects){
            p.draw();
            _objects_view.addChild(p.view);
        }

        draw_grid();
        _objects_view.x = _grid_view.x;
        _objects_view.y = _grid_view.y;
    }

    public function draw():void{
        draw_buildings();

        var tiles:Array;
        for each(var p:FieldObjectController in _objects){
            tiles = _grid.get_tiles_in_square(p.object.x, p.object.y, p.object.width, p.object.length);
            for each(var t:IsoTile in tiles){
                t.is_reachable = false;
            }
        }

        draw_grid();
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
