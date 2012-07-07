package utils.iso {

import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

public class IsoRenderUtil {
    // renders simple rect in iso
    // takes iso coordinates
    public static function drawIsoRect(layer:Sprite, size:Rectangle, borderWidth:int, color:uint, borderColor:uint, alpha:Number = 1):void {
        layer.graphics.beginFill(color, alpha);
        layer.graphics.lineStyle(borderWidth, borderColor);

        var addPoint:Point = IsoMathUtil.isoToScreen(size.x, size.y);
        layer.graphics.moveTo(addPoint.x, addPoint.y);

        addPoint = IsoMathUtil.isoToScreen(size.x + size.width, size.y);
        layer.graphics.lineTo(addPoint.x, addPoint.y);

        addPoint = IsoMathUtil.isoToScreen(size.x + size.width, size.y + size.height);
        layer.graphics.lineTo(addPoint.x, addPoint.y);

        addPoint = IsoMathUtil.isoToScreen(size.x, size.y + size.height);
        layer.graphics.lineTo(addPoint.x, addPoint.y);

        addPoint = IsoMathUtil.isoToScreen(size.x, size.y);
        layer.graphics.lineTo(addPoint.x, addPoint.y);

        layer.graphics.endFill();
    }
}
}