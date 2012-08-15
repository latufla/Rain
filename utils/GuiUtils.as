/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 8/15/12
 * Time: 2:00 PM
 * To change this template use File | Settings | File Templates.
 */
package utils {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.Dictionary;

import utils.ObjectUtils;

public class GuiUtils {

    private static var _buttons:Dictionary = new Dictionary();
    public function GuiUtils() {
    }


    public static function set_button(button:ButtonDesign, text:String, cb:Function):void{
        var states:Array = [button.upState, button.overState, button.downState, button.hitTestState];
        for each(var p:Sprite in states){
            TextField(p.getChildAt(1)).text = text;
        }
        button.addEventListener(MouseEvent.CLICK, cb);
        _buttons[button] = cb;

        trace("_buttons");
        ObjectUtils.debug_trace(_buttons);
    }

    public static function unset_button(button:ButtonDesign):void{
        if(!_buttons[button])
            return;

        button.removeEventListener(MouseEvent.CLICK, _buttons[button]);
        delete _buttons[button];
    }
}
}
