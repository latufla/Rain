/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 10:39 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import common.model.IsoTile;

import flash.events.MouseEvent;
import flash.geom.Point;

import utils.iso.IsoMathUtil;

public class SceneController {

    private var _field_c:FieldController;
    public function SceneController() {
        init();
    }

    private function init():void {
        _field_c = new FieldController();
        _field_c.create_grid(10, 10);

        _field_c.create_building(5, 5, 2, 3);
        _field_c.create_building(1, 0, 1, 1);

        _field_c.draw();

        RainProject.STAGE.addChild(_field_c.view);
    }
}
}
