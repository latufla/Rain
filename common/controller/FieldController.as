/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 4:35 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import common.model.Bot;
import common.model.FieldObject;
import common.model.IsoGrid;
import common.model.IsoTile;
import common.view.IsoGridView;

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

import utils.ArrayUtils;

import utils.DebugUtils;

import utils.FieldUtils;
import utils.MovieClipHelper;
import utils.ZorderUtils;

import utils.ZorderUtils;

import utils.iso.IsoMathUtil;

public class FieldController {
    public static const TILE_WIDTH:uint = 50;
    public static const TILE_LENGTH:uint = 50;

    private var _grid:IsoGrid;
    private var _grid_view:IsoGridView = new IsoGridView();

    private var _all_objects:Array = [];
    private var _objects_view:Sprite = new Sprite();

    private var _buildings:Vector.<FieldObjectController> = new Vector.<FieldObjectController>();
    private var _bots:Vector.<BotController> = new Vector.<BotController>(); // draw on objects view

    private var _view:Sprite = new Sprite();

    public function FieldController() {
        init();
    }

    private function init():void {
        _view.addEventListener(MouseEvent.CLICK, on_click);
        _view.addEventListener(Event.ENTER_FRAME, on_ef_render);
        _view.addChild(_grid_view);
        _view.addChild(_objects_view);
    }

    // GRID
    public function create_grid(w:uint, h:uint):void{
        _grid = new IsoGrid(w, h);
        _grid.create();
        _grid_view.grid = _grid;
    }

    // ----
    // normally iso coords are both - and + by x
    // but we want display field view in 0, 0 of screen and
    // see all the field from the most left point
    // ----
    // next time we click on _view or add some objects we translate
    // coords with _x_grid_offset
    private var _x_grid_offset:int;
    public function draw_grid():void{
        _grid_view.draw();

        var bounds:Rectangle = _grid_view.getBounds(_grid_view);
        _grid_view.x = -bounds.x;
        _grid_view.y = -bounds.y;

        _x_grid_offset = -bounds.x;// TODO: Resolve Y offset needness
//        _grid_view.visible = false;
    }

    private var _buffer:Array = [new Bitmap(), new Bitmap()];
    private var _bd:BitmapData = new BitmapData(1280, 768, true, 0xFFFFFF);
    private function on_ef_render(e:Event):void {
        _bd = new BitmapData(1280, 768, true, 0xFFFFFF);
        draw_all_objects(true);
        _buffer[1].bitmapData = _bd;

        //swap
        var tmp:Bitmap;
        tmp = _buffer[0];
        _buffer[0] = _buffer[1];
        _buffer[1] = tmp;

        _objects_view.addChild(_buffer[0])
        MovieClipHelper.try_remove(_buffer[1]);
    }

    // BUILDINGS
    public function create_building(x:uint, y:uint, w:uint, l:uint):Boolean{
        // check if out of borders
        if(x + w > field_width || y + l > field_length)
            return false;

        // check if there is another object
        var obj_1:Object = {x: x, y: y, w: w, h: l};
        var obj_2:Object = {};
        var building:FieldObject;
        for each(var p:FieldObjectController in _buildings){
            building = p.object;
            obj_2.x = building.x;
            obj_2.y = building.y;
            obj_2.w = building.width;
            obj_2.h = building.length;

            if(FieldUtils.intersects(obj_1, obj_2))
                return false;
        }

        // create object and add to lists
        var building:FieldObject = new FieldObject(w, l, 2);
        building.move_to(x, y);

        var building_c:FieldObjectController = new FieldObjectController();
        building_c.object = building;
        _buildings.push(building_c);
        _all_objects.push(building_c);

        // fill tiles with additional info
        var tiles:Array = _grid.get_tiles_in_square(x, y, w, l);
        for each(var t:IsoTile in tiles){
            t.is_reachable = building.is_reachable;
            t.field_object_c = building_c;
        }

        //ZorderUtils.bin_insert_resort_single_object(building_c, _all_objects);
        return true;
    }

    public function resolve_spawn_points():void{
        var nearest_points:Array;
        var tile:IsoTile;
        for each(var p:FieldObjectController in _buildings){
            nearest_points = p.object.nearest_points;
            if(!nearest_points || nearest_points.length < 0)
                continue;

            for each(var s:Point in nearest_points){
                tile = _grid.get_tile(s.x, s.y);
                if(tile.is_reachable){
                    tile.is_spawn_point = true;
                    p.object.spawn_point = new Point(s.x, s.y);
                    break;
                }
            }
        }
    }

    public function draw_all_objects(update_only:Boolean = false):void{
        for each(var p:* in _all_objects){
            p.draw(_bd, update_only, _x_grid_offset);
        }
    }

    public function debug_generate_random_buildings():void{
        var fld:Array = FieldUtils.generate_field_with_objects(2, {w:field_width, h:field_length}, new Point(1, 1));
        for each(var o:Object in fld){
            create_building(o.x, o.y, o.w, o.h);
            trace("{ x:" + o.x + ", y:" + o.y + ", w:" + o.w + ", l:" + o.h + " }")
        }
    }

    public function create_bot(x:uint, y:uint, w:uint = 1, l:uint = 1):Boolean{
        if(x + w > field_width || y + l > field_length)
            return false;

        var obj_1:Object = {x: x, y: y, w: w, h: l};
        var obj_2:Object = {};
        var building:FieldObject;
        for each(var p:FieldObjectController in _buildings){
            building = p.object;
            obj_2.x = building.x;
            obj_2.y = building.y;
            obj_2.w = building.width;
            obj_2.h = building.length;

            if(FieldUtils.intersects(obj_1, obj_2))
                return false;
        }

        var bot:Bot = new Bot(1, _grid);
        bot.move_to(x, y);

        var bot_c:BotController = new BotController();
        bot_c.object = bot;
        bot_c.move_to_target(resort_single_object);
        _bots.push(bot_c);
//        _all_objects.push(bot_c);
        ZorderUtils.bin_insert_resort_single_object(bot_c, _all_objects);
        return true;
    }

    // RENDER
    public function draw(need_resort:Boolean = false):void{
        //if(need_resort)
        //_all_objects = ArrayUtils.shuffle(_all_objects);
        //z_sort();
        _all_objects = ZorderUtils.z_sort(_grid);

        draw_grid();
        draw_all_objects();
    }

    private function z_sort():void{
        ZorderUtils.custom_zorder(_all_objects);
    }

    private function resort_single_object(o_c:BotController):void{
        _all_objects.splice(_all_objects.indexOf(o_c), 1);
       ZorderUtils.bin_insert_resort_single_object(o_c, _all_objects);
    }

    public function get view():Sprite {
        return _view;
    }

    public function get grid():IsoGrid{
        return _grid;
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
       //process_grid_click(e)
//        process_building_click(e);
        //process_bot_click(e);
    }

    // TODO: don`t use before refactoring
    private function process_bot_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX, e.localY);
        var tile:IsoTile = _grid.get_tile(coords.x / TILE_WIDTH, coords.y / TILE_LENGTH);
//        _bots[0].object.find_path(tile);
        _bots[0].move_to(tile, resort_single_object);
        draw_grid();
    }

    private function process_building_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX - _x_grid_offset, e.localY);
        create_building(coords.x / TILE_WIDTH, coords.y / TILE_LENGTH, 2, 1);
    }

    private function process_grid_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX - _x_grid_offset, e.localY);  // TODO: resolve 748
        var tiles:Array = _grid.get_tiles_in_square(coords.x / TILE_WIDTH, coords.y / TILE_LENGTH, 1, 1);
        for each(var p:IsoTile in tiles){
            p.is_reachable = !p.is_reachable;
        }
        draw_grid();
    }

    public function get buildings():Vector.<FieldObjectController> {
        return _buildings;
    }
}
}
