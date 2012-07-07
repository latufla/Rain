/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:29 AM
 * To change this template use File | Settings | File Templates.
 */
package common.view {
import common.model.IsoTile;
import common.view.IsoTileRenderer;

import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import utils.MovieClipHelper;
import utils.iso.IsoMathUtil;
import utils.iso.IsoRenderUtil;

public class IsoTileRenderer {
    private static const NON_REACHABLE_COLOR:uint = 0xFF0000;
    private static const REACHABLE_COLOR:uint = 0x00FF00;

    private static const DEBUG_COLORS:Array = [REACHABLE_COLOR, 0x0000FF, 0xC2C3C2];

    public function IsoTileRenderer() {
    }

    public function draw(tile:IsoTile, layer:Sprite):void {
        var color:uint = DEBUG_COLORS[tile.debug_type];

        if(!tile.is_reachable)
            color = NON_REACHABLE_COLOR;

        var size:Rectangle = new Rectangle (tile.x * Field.TILE_WIDTH, tile.y * Field.TILE_HEIGHT, Field.TILE_WIDTH - 2, Field.TILE_HEIGHT - 2);
        IsoRenderUtil.drawIsoRect(layer, size, 1, color, color, 0.2);
//        draw_debug_info(tile, layer, new TextField());
    }

    public function draw_debug_info(tile:IsoTile, layer:Sprite, debug_field:TextField):void {
        var iso:Point = IsoMathUtil.isoToScreen(tile.x * Field.TILE_WIDTH, tile.y * Field.TILE_HEIGHT);
        debug_field.x = iso.x - 15;
        debug_field.y = iso.y + 5;

        debug_field.autoSize = TextFieldAutoSize.LEFT;
        debug_field.text = "x" + tile.x + " y" + tile.y;
        layer.addChild(debug_field);
    }
}
}
