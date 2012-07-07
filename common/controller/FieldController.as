/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/7/12
 * Time: 4:35 PM
 * To change this template use File | Settings | File Templates.
 */
package common.controller {
import common.model.IsoGrid;
import common.view.IsoGridView;

import flash.display.Sprite;

public class FieldController {

    private var _grid:IsoGrid;
    private var _grid_view:IsoGridView = new IsoGridView();

    private var _view:Sprite = new Sprite();

    public function FieldController() {

    }

    public function create_grid(w:uint, h:uint):void{
        _grid = new IsoGrid(10, 10);
        _grid.create();
//        _grid.debug_generate_random(0.7);
        _grid.resize(5, 5);
        _grid.resize(11, 11);
        _grid_view.grid = _grid;
    }

    public function draw_grid():void{
        _grid_view.draw();
        _view.addChild(_grid_view);
    }

    public function get view():Sprite {
        return _view;
    }

    public function get grid():IsoGrid{
        return _grid;
    }
}
}
