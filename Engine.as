/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:13 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import common.controller.FieldController;
import common.model.IsoTile;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import utils.iso.IsoMathUtil;

public class Engine {
    private var _field_c:FieldController;
    public function Engine() {
    }

    public function init():void{
        _field_c = new FieldController();
        _field_c.create_grid(15, 15);
        _field_c.draw_grid();
        RainProject.STAGE.addChild(_field_c.view);

        _field_c.view.addEventListener(MouseEvent.CLICK, on_click);
    }

    private function on_click(e:MouseEvent):void {
        var coords:Point = IsoMathUtil.screenToIso(e.localX, e.localY);
//        var tile:IsoTile = _field_c.grid.get_tile(coords.x / Field.TILE_WIDTH, coords.y / Field.TILE_HEIGHT);
//        tile.is_reachable = false;
        var tiles:Array = _field_c.grid.get_tiles_in_square(coords.x / Field.TILE_WIDTH, coords.y / Field.TILE_HEIGHT, 3, 2);
        for each(var p:IsoTile in tiles){
            p.is_reachable = !p.is_reachable;
        }

        _field_c.draw_grid();
    }

}
}
