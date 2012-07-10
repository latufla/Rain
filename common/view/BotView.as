/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/10/12
 * Time: 4:11 PM
 * To change this template use File | Settings | File Templates.
 */
package common.view {
import common.controller.FieldController;
import common.model.Bot;

import flash.display.Sprite;

import utils.iso.IsoRenderUtil;

public class BotView extends Sprite{

    private var _object:Bot;
    public function BotView() {
    }

    public function draw():void{
        if(!_object)
            throw new Error("BotView -> draw(): object is null" );

        var w:uint = _object.width * FieldController.TILE_WIDTH - 2;
        var l:uint = _object.length * FieldController.TILE_LENGTH - 2;
        var h:uint = _object.debug_height * FieldController.TILE_LENGTH;
        IsoRenderUtil.draw_iso_box(this, w, l, h, 0xC2C3C2);
    }

    public function get object():Bot{
        return _object;
    }

    public function set object(value:Bot):void {
        _object = value;
    }

}
}
