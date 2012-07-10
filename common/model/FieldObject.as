/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 11:11 PM
 * To change this template use File | Settings | File Templates.
 */
package common.model {
public class FieldObject extends ObjectBase{

    private var _bots:Array;

    public function FieldObject(w:uint, l:uint, h:uint) {
        width = w;
        length = l;
        _debug_height = h;
    }

    public function get bots():Array {
        return _bots;
    }

    public function add_bot(bot:Bot):void{
        _bots.push(bot);
    }

    public function remove_last_bot():void{
        _bots.pop();
    }
}
}
