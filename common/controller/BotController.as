/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/10/12
 * Time: 4:14 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import common.model.Bot;
import common.view.BotView;

import flash.geom.Point;

import utils.iso.IsoMathUtil;

public class BotController {

    private var _object:Bot;
    private var _view:BotView = new BotView();
    public function BotController() {
    }

    public function draw(apply_axises:Function):void{
        if(!_object)
            throw new Error("BotController -> draw(): object is null");

        _view.object = _object;
        _view.draw();

        var pnt:Point = apply_axises(_object);
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

}
}
