/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/8/12
 * Time: 11:55 AM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {

import common.model.FieldObject;
import common.model.IsoGrid;
import common.model.IsoTile;
import common.model.ObjectBase;
import common.view.FieldObjectView;

import flash.display.BitmapData;

import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

import utils.iso.IsoMathUtil;

public class FieldObjectController extends ControllerBase{

    private var _object:FieldObject;
    private var _view:FieldObjectView = new FieldObjectView();

    public function FieldObjectController() {

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
                new Rectangle(0, 0, _view.bd.width, _view.bd.height),
                new Point(_view.x + x_offset, _view.y), null, null, true); // TODO: resolve 748
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
            t.field_object_c = this;
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
}
}
