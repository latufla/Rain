/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 8/12/12
 * Time: 2:51 PM
 * To change this template use File | Settings | File Templates.
 */
package common.view.window {
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

public class TargetWindow extends MainView{

    public function get image_container():MovieClip { return Image; }
    public function get desc_field():TextField { return Text; }

    public function TargetWindow(params:Object) {
        init(params);
    }

    private function init(params:Object):void {
        alpha = .7;
        x = params.x + Config.scene_c.field_gui_offset.x + 50;
        y = params.y;
        desc_text = params.text;

        desc_field.autoSize = TextFieldAutoSize.LEFT;
        desc_field.multiline = false;
        desc_field.wordWrap = false;
    }

    public function set desc_text(value:String):void{
        desc_field.text = value;
    }

    public function load_image(src:String):void{

    }

    public function refresh(params:Object){
        desc_text = params.text;
    }
}
}
