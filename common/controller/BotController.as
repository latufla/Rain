/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/10/12
 * Time: 4:14 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import com.greensock.TweenLite;

import common.model.Bot;
import common.model.IsoTile;
import common.view.BotView;

import flash.geom.Point;
import flash.utils.clearInterval;
import flash.utils.setInterval;

import utils.iso.IsoMathUtil;

public class BotController {

    private var _object:Bot;
    private var _view:BotView = new BotView();
    public function BotController() {
    }

    private var _apply_axises:Function;
    public function draw(apply_axises:Function):void{
        if(!_object)
            throw new Error("BotController -> draw(): object is null");

        _view.object = _object;
        _view.draw();

        _apply_axises = apply_axises;
        update_position();
    }

    private function update_position():void{
        var pnt:Point = _apply_axises(_object);
        pnt = IsoMathUtil.isoToScreen(pnt.x, pnt.y);
        _view.x = pnt.x;
        _view.y = pnt.y;
    }

    public function get view():BotView {
        return _view;
    }

    public function get object():Bot {
        return _object;
    }

    public function set object(value:Bot):void {
        _object = value;
    }

    public function move_to(end:IsoTile, resorter:Function):void{
        var path:Array = _object.find_path(end);
        path.shift();
        var self:BotController = this;
        var id:uint = setInterval(function():void{
            _object.x = path[0].x;
            _object.y = path[0].y;
            resorter(self);
            path.shift();
            if(path.length == 0)
                clearInterval(id);
        }, 200);
    }
}
}
