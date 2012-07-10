/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 4:35 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import common.controller.FieldObjectController;
import common.model.Bot;
import common.model.FieldObject;
import common.model.IsoGrid;
import common.model.IsoTile;
import common.view.IsoGridView;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import utils.FieldUtils;

import utils.ZorderUtils;

import utils.iso.IsoMathUtil;

public class FieldController {
    public static const TILE_WIDTH:uint = 50;
    public static const TILE_LENGTH:uint = 50;

    private var _grid:IsoGrid;
    private var _grid_view:IsoGridView = new IsoGridView();

    private var _objects:Vector.<FieldObjectController> = new Vector.<FieldObjectController>();
    private var _objects_view:Sprite = new Sprite();

    private var _bots:Vector.<BotController> = new Vector.<BotController>(); // draw on objects view

    private var _view:Sprite = new Sprite();

    public function FieldController() {
        init();
    }

    private function init():void {
        _view.addEventListener(MouseEvent.CLICK, on_click);
        _view.addChild(_grid_view);
        _view.addChild(_objects_view);
    }

    // GRID
    public function create_grid(w:uint, h:uint):void{
        _grid = new IsoGrid(w, h);
        _grid.create();
        _grid_view.grid = _grid;
    }

    public function draw_grid():void{
        _grid_view.draw(apply_axises);
    }

    // BUILDINGS
    public function create_building(x:uint, y:uint, w:uint, l:uint):Boolean{
        if(x + w > field_width || y + l > field_length)
            return false;

        var obj_1:Object = {x: x, y: y, w: w, h: l};
        var obj_2:Object = {};
        var building:FieldObject;
        for each(var p:FieldObjectController in _objects){
            building = p.object;
            obj_2.x = building.x;
            obj_2.y = building.y;
            obj_2.w = building.width;
            obj_2.h = building.length;

            if(FieldUtils.intersects(obj_1, obj_2))
                return false;
        }

        var building:FieldObject = new FieldObject(w, l, 2);
        building.x = x;
        building.y = y;

        var building_c:FieldObjectController = new FieldObjectController();
        building_c.object = building;
        _objects.push(building_c);

        return true;
    }

    public function draw_buildings():void{
        for each(var p:FieldObjectController in _objects){
            p.draw(apply_axises);
            _objects_view.addChild(p.view);
        }

        _objects_view.x = _grid_view.x;
        _objects_view.y = _grid_view.y;
    }

    public function debug_generate_random_buildings():void{
        var fld:Array = FieldUtils.generate_field_with_objects(3, {w:field_width, h:field_length}, new Point(2, 2));
        for each(var o:Object in fld){
            create_building(o.x, o.y, o.w, o.h);
        }
    }

    public function create_bot(x:uint, y:uint, w:uint = 1, l:uint = 1):Boolean{
        if(x + w > field_width || y + l > field_length)
            return false;

        var obj_1:Object = {x: x, y: y, w: w, h: l};
        var obj_2:Object = {};
        var building:FieldObject;
        for each(var p:FieldObjectController in _objects){
            building = p.object;
            obj_2.x = building.x;
            obj_2.y = building.y;
            obj_2.w = building.width;
            obj_2.h = building.length;

            if(FieldUtils.intersects(obj_1, obj_2))
                return false;
        }

        var bot:Bot = new Bot(1, _grid);
        bot.x = x;
        bot.y = y;

        var bot_c:BotController = new BotController();
        bot_c.object = bot;
//        _objects.push(bot_c);
        _bots.push(bot_c);

        return true;
    }

    public function draw_bots():void{
        for each(var p:BotController in _bots){
            p.draw(apply_axises);
            _objects_view.addChild(p.view);
        }

        _objects_view.x = _grid_view.x;
        _objects_view.y = _grid_view.y;
    }

    // RENDER
    public function draw():void{
        ZorderUtils.custom_zorder(_objects);

        // set underbuilding tiles reachability
        var tiles:Array;
        for each(var p:FieldObjectController in _objects){
            tiles = _grid.get_tiles_in_square(p.object.x, p.object.y, p.object.width, p.object.length);
            for each(var t:IsoTile in tiles){
                t.is_reachable = p.object.is_reachable;
            }
        }
        draw_grid();
        draw_buildings();
        draw_bots();
    }

    public function get view():Sprite {
        return _view;
    }

    public function get grid():IsoGrid{
        return _grid;
    }

    // orient axis
    var pnt:Point = new Point();
    private function apply_axises(o:*):Point{
        pnt.x = apply_x_axis(o);
        pnt.y = apply_y_axis(o);
        return pnt;
    }

    private function apply_x_axis(o:*):int{
        return o.x * TILE_WIDTH;
    }

    private function apply_y_axis(o:*):int{
        var y_inv:int = _grid.length - 1;
        var l_inv:int = o.length - 1;
        return (y_inv - (o.y + l_inv)) * TILE_LENGTH;
    }

    // field width is same to grid width
    private function get field_width():uint{
        return _grid.width;
    }

    private function get field_length():uint{
        return _grid.length;
    }

    // test clicks processing
    private function on_click(e:MouseEvent):void {
//        process_grid_click(e)
//        process_building_click(e);
        process_bot_click(e);
    }

    private function process_bot_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX, e.localY);
        var inv_y:uint = _grid.length;
        var tile:IsoTile = _grid.get_tile(coords.x / TILE_WIDTH, inv_y - coords.y / TILE_LENGTH);
        _bots[0].object.find_path(tile);
        draw_grid();
    }

    private function process_building_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX, e.localY);
        var inv_y:uint = _grid.length;
        if(create_building(coords.x / TILE_WIDTH, inv_y - coords.y / TILE_LENGTH, 3, 2))
            draw();
    }

    private function process_grid_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX, e.localY);
        var inv_y:uint = _grid.length;
        var tiles:Array = _grid.get_tiles_in_square(coords.x / TILE_WIDTH, inv_y - coords.y / TILE_LENGTH, 3, 2);
        for each(var p:IsoTile in tiles){
            p.is_reachable = !p.is_reachable;
        }
        draw_grid();
    }
}
}
