/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/22/12
 * Time: 4:07 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import common.model.IsoGrid;
import common.model.ObjectBase;

import flash.display.BitmapData;

import flash.display.Sprite;

public class ControllerBase {

    protected var _static_zordered:Boolean; // should be used once when field created

    protected var _id_on_tile:int = -1;

    public function ControllerBase() {
    }

    public function draw(bd:BitmapData, update_only:Boolean = false, x_offset:Number = 0):void{
        // override me
    }

    public function apply_params_to_grid(grid:IsoGrid):void{
        // override me
    }

    public function get view():Sprite {
        return null;
    }

    public function get object():ObjectBase {
        return null;
    }

    public function set object(value:ObjectBase):void {
        // override me
    }

    public function get static_zordered():Boolean {
        return _static_zordered;
    }

    public function set static_zordered(value:Boolean):void {
        _static_zordered = value;
    }

    public function get id_on_tile():int {
        return _id_on_tile;
    }

    public function set id_on_tile(value:int):void {
        _id_on_tile = value;
    }
}
}
