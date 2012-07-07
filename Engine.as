/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:13 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import common.model.IsoTile;
import common.view.IsoTileRenderer;

import flash.display.Sprite;

public class Engine {
    public function Engine() {
    }

    public function init():void{
        var sp:Sprite = new Sprite();
        RainProject.STAGE.addChild(sp);

        var t:IsoTile = new IsoTile(0, 0);
        var t_rend:IsoTileRenderer = new IsoTileRenderer();
        t_rend.draw(t, sp);
        t_rend.draw(new IsoTile(1, 0), sp);
        t_rend.draw(new IsoTile(2, 0), sp);
        t_rend.draw(new IsoTile(3, 0), sp);

    }
}
}
