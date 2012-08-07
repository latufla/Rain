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
import common.model.ObjectBase;
import common.model.SpawnPoint;
import common.model.TargetPoint;
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
import utils.iso.IsoMathUtil;

public class FieldController {
    public static const TILE_WIDTH:uint = 22;
    public static const TILE_LENGTH:uint = 22;

    private var _grid:IsoGrid;
    private var _grid_view:IsoGridView = new IsoGridView();

    private var _all_objects:Vector.<ControllerBase> = new Vector.<ControllerBase>();
    private var _objects_view:Sprite = new Sprite();

    private var _buildings:Vector.<FieldObjectController> = new Vector.<FieldObjectController>();
    private var _bots:Vector.<BotController> = new Vector.<BotController>(); // draw on objects view

    private var _view:Sprite = new Sprite();

    public function FieldController() {
        init();
    }

    // TODO: finish before use
    public function destroy(){
        remove_listeners();
    }

    private function init():void {
        Config.field_c = this;

        add_listeners();
        _view.addChild(_grid_view);
        _view.addChild(_objects_view);
    }

    private function add_listeners():void{
        _view.addEventListener(MouseEvent.CLICK, on_click);
        _view.addEventListener(MouseEvent.MOUSE_OVER, on_mouse_over);
        _view.addEventListener(MouseEvent.MOUSE_OUT, on_mouse_out);
        _view.addEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);

        _view.addEventListener(Event.ENTER_FRAME, on_ef_render);
    }

    private function remove_listeners():void{
        _view.removeEventListener(MouseEvent.CLICK, on_click);
        _view.removeEventListener(MouseEvent.MOUSE_OVER, on_mouse_over);
        _view.removeEventListener(MouseEvent.MOUSE_OUT, on_mouse_out);
        _view.removeEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);

        _view.removeEventListener(Event.ENTER_FRAME, on_ef_render);
    }

    // GRID
    public function create_grid(w:uint, h:uint):void{
        _grid = new IsoGrid(w, h);
        _grid.create();
        _grid_view.grid = _grid;
    }

    private var _buffer:Array = [new Bitmap(), new Bitmap()];
    private var _bd:BitmapData = new BitmapData(1280, 768, true, 0xFFFFFF);
    private function on_ef_render(e:Event):void {
        _bd = new BitmapData(1280, 768, true, 0xFFFFFF);
        _all_objects = z_sort();
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

    public function add_building(b:FieldObject, bot_count:uint = 0):Boolean{
        if(!can_add(b))
            return false;

        b.create_spawn_point(bot_count);

        var b_c:FieldObjectController = new FieldObjectController();
        b_c.object = b;
        b_c.start_spawn_bots(this);

        _buildings.push(b_c);
        _all_objects.push(b_c);

        return true;
    }

    // fuck zero here
    private function is_out(o:ObjectBase):Boolean{
        return o.x + o.width > field_width || o.y + o.length > field_length;
    }

    private function can_add(o:ObjectBase):Boolean{
        if(is_out(o))
            return false;

        for each(var p:FieldObjectController in _buildings){
            if(p.object.intersects(o))
                return false;
        }

        return true;
    }

    public function add_bot(b:Bot):Boolean{
        // check if out of borders
        if(!can_add(b))
            return false;

        var b_c:BotController = new BotController();
        b_c.object = b;
        b_c.move_to_target(null);

        _bots.push(b_c);
        _all_objects.push(b_c);

        return true;
    }

    // RENDER
    // first render
    public function draw(need_resort:Boolean = false):void{
        if(need_resort)
            _all_objects = z_sort();

        draw_grid();
        draw_all_objects();
    }

    // sort
    private function z_sort():Vector.<ControllerBase>{
        return ZorderUtils.z_sort_multi(_grid);
    }

    public function draw_grid():void{
        _grid_view.draw();
//        _grid_view.visible = false;
    }

    public function draw_all_objects(update_only:Boolean = false):void{
        for each(var p:ControllerBase in _all_objects){
            p.draw(_bd, update_only, _grid_view.offset.x);
        }
    }
    //RENDER END

    public function get view():Sprite {
        return _view;
    }

    public function get grid():IsoGrid{
        return _grid;
    }

    // field width is same to grid width
    public function get field_width():uint{
        if(!_grid)
            return 0;

        return _grid.width;
    }

    public function get field_length():uint{
        if(!_grid)
            return 0;

        return _grid.length;
    }

    public function get buildings():Vector.<FieldObjectController> {
        return _buildings;
    }

    public function get target_buildings():Vector.<FieldObject> {
        var b_cs = _buildings.filter(function (item:FieldObjectController, index:int, vector:Vector.<FieldObjectController>):Boolean{
            return (item.object as FieldObject).target_point;
        })

        var res:Vector.<FieldObject> = new Vector.<FieldObject>();
        for each(var b_c:FieldObjectController in b_cs){
            res.push(b_c.object);
        }

        // desc
        res.sort(function(a:FieldObject, b:FieldObject):int{
            var a_target_priority:int = a.target_point.priority;
            var b_target_priority:int = b.target_point.priority;

            if(a_target_priority > b_target_priority)
                return -1;

            if(a_target_priority < b_target_priority)
                return 1;

            return 0;
        });

        return res;
    }

    // test clicks processing
    private function on_click(e:MouseEvent):void {
        trace("click");

       //process_grid_click(e)
    //    process_building_click(e);
        //process_bot_click(e);
    }

    private function on_mouse_over(e:MouseEvent):void {
        trace("on_mouse_over");
    }

    private function on_mouse_out(e:MouseEvent):void{
        trace("on_mouse_out");
    }

    private function on_mouse_move(e:MouseEvent):void {
        trace("on_mouse_move");
    }

    // TODO: don`t use before refactoring
    private function process_bot_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX, e.localY);
        var tile:IsoTile = _grid.get_tile(coords.x / TILE_WIDTH, coords.y / TILE_LENGTH);
//        _bots[0].object.find_path(tile);
        _bots[0].move_to(tile, null);
        draw_grid();
    }

    private function process_building_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX - _grid_view.offset.x, e.localY);
        var b:FieldObject = new FieldObject(1, 1, 2);
        b.move_to(coords.x / TILE_WIDTH, coords.y / TILE_LENGTH);
        add_building(b);
    }

    private function process_grid_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX - _grid_view.offset.x, e.localY);  // TODO: resolve 748
        var tiles:Array = _grid.get_tiles_in_square(coords.x / TILE_WIDTH, coords.y / TILE_LENGTH, 1, 1);
        for each(var p:IsoTile in tiles){
            p.is_reachable = !p.is_reachable;
        }
        draw_grid();
    }
}
}
