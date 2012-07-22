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
import common.view.FieldObjectView;

import flash.display.BitmapData;

import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

import utils.iso.IsoMathUtil;
import utils.iso.IsoRenderUtil;

public class FieldObjectController {

    private var _object:FieldObject;
    private var _view:FieldObjectView = new FieldObjectView();

    private var _static_zordered:Boolean; // should be used once when field created

    public function FieldObjectController() {

    }

    public function draw(bd:BitmapData, update_only:Boolean = false, x_offset:Number = 0):void{
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

    public function apply_params_to_grid(grid:IsoGrid):void{
        var tiles:Array = grid.get_tiles_in_square(object.x, object.y, object.width, object.length);
        for each(var t:IsoTile in tiles){
            t.is_reachable = object.is_reachable;
            t.field_object_c = this;
        }
    }

    public function get view():Sprite {
        return _view;
    }

    public function get object():FieldObject {
        return _object;
    }

    public function set object(value:FieldObject):void {
        _object = value;
    }


    public function get static_zordered():Boolean {
        return _static_zordered;
    }

    public function set static_zordered(value:Boolean):void {
        _static_zordered = value;
    }
}
}
