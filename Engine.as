/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:13 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import common.controller.SceneController;

public class Engine {

    private var _scene_c:SceneController;
    public function Engine() {
        init();
    }

    public function init():void{
        _scene_c = new SceneController();
    }
}
}
