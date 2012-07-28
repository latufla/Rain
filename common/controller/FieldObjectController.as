/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/8/12
 * Time: 11:55 AM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {

import common.model.Bot;
import common.model.FieldObject;
import common.model.IsoGrid;
import common.model.IsoTile;
import common.model.ObjectBase;
import common.view.FieldObjectView;

import flash.display.BitmapData;

import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.clearInterval;
import flash.utils.setInterval;

import utils.iso.IsoMathUtil;

public class FieldObjectController extends ControllerBase{

    private var _object:FieldObject;
    private var _view:FieldObjectView = new FieldObjectView();

    private var _spawn_interval:uint;

    public function FieldObjectController() {
        super();
    }

    override public function draw(bd:BitmapData, update_only:Boolean = false, x_offset:Number = 0):void{
        if(!_object)
            throw new Error("FieldObjectController -> draw(): object is null");

        if(!update_only || !_view.bd){
            _view.object = _object;
            _view.draw();
            update_position();
        }

        bd.copyPixels(_view.bd,
                new Rectangle(0, 0, _view.bd.width, _view.bd.height),
                new Point(_view.x + x_offset, _view.y), null, null, true);
    }

    private function update_position():void {
        var pnt:Point = IsoMathUtil.isoToScreen(_object.x_px, _object.y_px);
        _view.x = pnt.x;
        _view.y = pnt.y;
    }

    override public function apply_params_to_grid(grid:IsoGrid):void{
        var tiles:Array = grid.get_tiles_in_square(object.x, object.y, object.width, object.length);
        for each(var t:IsoTile in tiles){
            t.is_reachable = object.is_reachable;
            t.add_object(this);
        }
    }

    override public function get view():Sprite {
        return _view;
    }

    override public function get object():ObjectBase {
        return _object;
    }

    override public function set object(value:ObjectBase):void {
        _object = value as FieldObject;
    }

    public function start_spawn_bots(field_c:FieldController):void{
        var bot:Bot = _object.next_bot;
        if(!bot)
            return;

        _spawn_interval = setInterval(function ():void {
            if(bot)
                field_c.add_bot(bot);
            else
                stop_spawn_bots();

            bot = _object.next_bot;
        }, _object.spawn_interval);
    }

    public function stop_spawn_bots():void{
        clearInterval(_spawn_interval);
    }
}
}
