/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:18 PM
 * To change this template use File | Settings | File Templates.
 */
package common.view {
import as3isolib.geom.IsoMath;
import as3isolib.geom.Pt;

import common.controller.FieldController;
import common.model.FieldObject;

import flash.display.Graphics;
import flash.display.Sprite;

public class FieldObjectView extends Sprite{

    private var _object:FieldObject;
    public function FieldObjectView() {
    }

    public function draw():void{
        if(!_object)
            throw new Error("FieldObjectView -> draw(): object is null" );

        var color:uint = 0xC2C3C2;
        var g:Graphics = graphics;
        g.clear();
        g.lineStyle(2, 0x0000FF);

        var w:uint = _object.width * FieldController.TILE_WIDTH - 2;
        var l:uint = _object.length * FieldController.TILE_LENGTH - 2;
        var h:uint = _object.debug_height * FieldController.TILE_LENGTH;

        //all pts are named in following order "x", "y", "z" via rfb = right, front, bottom
        var lbb:Pt = IsoMath.isoToScreen(new Pt(0, 0, 0));
        var rbb:Pt = IsoMath.isoToScreen(new Pt(w, 0, 0));
        var rfb:Pt = IsoMath.isoToScreen(new Pt(w, l, 0));
        var lfb:Pt = IsoMath.isoToScreen(new Pt(0, l, 0));

        var lbt:Pt = IsoMath.isoToScreen(new Pt(0, 0, h));
        var rbt:Pt = IsoMath.isoToScreen(new Pt(w, 0, h));
        var rft:Pt = IsoMath.isoToScreen(new Pt(w, l, h));
        var lft:Pt = IsoMath.isoToScreen(new Pt(0, l, h));

        //front-left face
        g.moveTo(lfb.x, lfb.y);
        g.beginFill(color);
        g.lineTo(lft.x, lft.y);
        g.lineTo(rft.x, rft.y);
        g.lineTo(rfb.x, rfb.y);
        g.lineTo(lfb.x, lfb.y);
        g.endFill();

        //front-right face
        g.moveTo(rbb.x, rbb.y);
        g.beginFill(color);
        g.lineTo(rfb.x, rfb.y);
        g.lineTo(rft.x, rft.y);
        g.lineTo(rbt.x, rbt.y);
        g.lineTo(rbb.x, rbb.y);
        g.endFill();

        //top face
        g.moveTo(lbt.x, lbt.y);
        g.beginFill(color);
        g.lineTo(rbt.x, rbt.y);
        g.lineTo(rft.x, rft.y);
        g.lineTo(lft.x, lft.y);
        g.lineTo(lbt.x, lbt.y);
        g.endFill();
    }

    public function get object():FieldObject{
        return _object;
    }

    public function set object(value:FieldObject):void {
        _object = value;
    }
}
}
