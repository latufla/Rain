/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 10:39 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import flash.display.Sprite;
import flash.geom.Point;
import flash.utils.Dictionary;

import utils.MovieClipHelper;

import utils.creator.GameplayDemoFieldCreator;

public class SceneController {

    private var _windows:Dictionary = new Dictionary();

    private var _field_c:FieldController;
    private var _view:Sprite = new Sprite();

    public function SceneController() {
        Config.scene_c = this;
        init();
    }

    private function init():void {
        _field_c = GameplayDemoFieldCreator.create();
        _field_c.draw();

        _view.addChild(_field_c.view);
    }

    public function show_window(wnd_class:Class, key:*, params:Object):void{
        if(!key || window_already_shown(key))
            return;

        var wnd:* = new wnd_class(params);
        _windows[key] = wnd;
        _view.addChild(wnd);
    }

    private function window_already_shown(key:*):Boolean{
        var wnd:* = _windows[key];
        if(!wnd)
            return false;

        return wnd.hasOwnProperty("parent") && wnd.parent;
    }

    public function refresh_window(key:*, params:Object):void{
        if(!key)
            return;

        var wnd:* = _windows[key];
        if(!wnd)
            return;

        wnd.refresh(params);
    }

    public function remove_window(key:*):void{
        if(!key)
            return;

        var wnd:* = _windows[key];
        if(!wnd)
            return;

        MovieClipHelper.try_remove(wnd);
        delete _windows[key];
    }

    public function get field_gui_offset():Point{
        return _field_c.grid_view.offset;
    }

    public function get view():Sprite {
        return _view;
    }
}
}
