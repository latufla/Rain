/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/10/12
 * Time: 4:14 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Linear;

import common.model.Bot;
import common.model.IsoGrid;
import common.model.IsoTile;
import common.model.ObjectBase;
import common.view.BotView;

import flash.display.BitmapData;
import flash.display.Sprite;

import flash.geom.Point;
import flash.geom.Rectangle;

import utils.iso.IsoMathUtil;

public class BotController extends ControllerBase{

    private var _object:Bot;
    private var _view:BotView = new BotView();

    // moving
    private var _moving_queue:TimelineLite = new TimelineLite();

    public function BotController() {
        super();
    }

    override public function draw(bd:BitmapData, update_only:Boolean = false, x_offset:Number = 0):void{
        if(!_object)
            throw new Error("FieldObjectController -> draw(): object is null");

        if(!update_only || !_view.bd){
            _view.object = _object;
            _view.draw();
        }

        update_position();
        bd.copyPixels(_view.bd,
                new Rectangle(0, 0, int(_view.bd.width), int(_view.bd.height)),
                new Point(int(_view.x + x_offset), int(_view.y)), null, null, true );
    }

    private function update_position():void{
        var pnt:Point = IsoMathUtil.isoToScreen(_object.x_px, _object.y_px);
        _view.x = pnt.x;
        _view.y = pnt.y;
    }

    override public function get view():Sprite{
        return _view;
    }

    override public function get object():ObjectBase{
        return _object;
    }

    override public function set object(value:ObjectBase):void {
        _object = value as Bot;
    }

    public function move_to(end:IsoTile, single_resorter:Function):void{
        clear_moving_queue();

        var path:Array = _object.find_path(end);
        path.shift();

        fill_moving_queue(path, single_resorter);
        start_moving_queue()
    }

    public function move_to_target(single_resorter:Function){
        move_to(_object.find_target(), single_resorter);
    }

    // procedurin` wrapper
    private function clear_moving_queue():void {
        _moving_queue.stop();
        _moving_queue.clear();
        _moving_queue.restart();
    }

    private function start_moving_queue():void{
        _moving_queue.play();
    }

    private function fill_moving_queue(path:Array, on_complete_resort:Function):void{
        var step:Object;
        for each(var p:IsoTile in path){
            step = {x_px:p.x_px, y_px:p.y_px, ease:Linear.easeNone, onComplete: on_complete_step};
            _moving_queue.append(new TweenLite(_object, 2, step));
        }

       var self:BotController = this;
        function on_complete_step():void{
            _grid.get_tile(_object.x, _object.y).remove_object(self);
            _object.move_to_px(_object.x_px, _object.y_px); // tweening via
            _grid.get_tile(_object.x, _object.y).add_object(self);

          //  on_complete_resort(self);
        }
    }


    private var _grid:IsoGrid;
    override public function apply_params_to_grid(grid:IsoGrid):void{
        _grid = grid;
        var t:IsoTile = grid.get_tile(object.x, object.y);
        t.add_object(this);
    }
}
}
