/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 10:39 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import common.view.window.TargetWindow;
import utils.creator.GameplayDemoFieldCreator;

public class SceneController {

    private var _field_c:FieldController;
    public function SceneController() {
        Config.scene_c = this;
        init();
    }

    private function init():void {
        _field_c = GameplayDemoFieldCreator.create();
//        _field_c.create_grid(10, 10);

//        _field_c.create_building(2, 1, 1, 1);
//        _field_c.create_building(2, 2, 1, 1);

//        _field_c.debug_generate_random_buildings();
        _field_c.draw();

        RainProject.STAGE.addChild(_field_c.view);
    }

    public function show_target_window(params:Object):void{
        var target_wnd:TargetWindow = new TargetWindow();
        target_wnd.x = params.x + _field_c.grid_view.offset.x + 50;
        target_wnd.y = params.y;
        RainProject.STAGE.addChild(target_wnd);
    }
}
}
