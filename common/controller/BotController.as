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

//    private function update_position():void{
//        var pnt:Point = _apply_axises(_object);
//        pnt = IsoMathUtil.isoToScreen(pnt.x, pnt.y);
//        _view.x = pnt.x;
//        _view.y = pnt.y;
//    }

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

    private var _my_timeline:TimelineLite = new TimelineLite();
    public function move_to(end:IsoTile, resorter:Function):void{
        _my_timeline.stop();
        _my_timeline.clear();
        _my_timeline.restart();

        var path:Array = _object.find_path(end);
        path.shift();
        var pnt:Point;

        for each(var p:IsoTile in path){
            pnt = IsoMathUtil.isoToScreen(p.x * FieldController.TILE_WIDTH, (14 - p.y) * FieldController.TILE_LENGTH);
            _my_timeline.append(new TweenLite(_view, 1, {x:pnt.x, y:pnt.y, ease:Linear.easeNone}), 0);
        }
        _my_timeline.play();
     }
}
}
