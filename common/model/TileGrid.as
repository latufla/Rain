/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 6/25/12
 * Time: 10:22 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;

public class TileGrid extends Sprite{

    private var _width:uint;
    private var _height:uint;

    private var _tiles:Vector.<Vector.<Tile>> = new Vector.<Vector.<Tile>>;

    public function TileGrid(w:uint, h:uint) {
        _width = w;
        _height = h;

        init();
    }

    private function init():void{
        for (var i:int = 0; i < _width; i++){
            tiles[i] = new Vector.<Tile>();
            for (var j:int = 0; j < _height; j++) {
                tiles[i][j] = new Tile(i, j);
            }
        }
    }

    public function debug_generate_random(disp:Number = 0.7):void{
        for (var i:int = 0; i < _width; i++){
            tiles[i] = new Vector.<Tile>();
            for (var j:int = 0; j < _height; j++) {
                tiles[i][j] = new Tile(i, j);

                if(Math.random() > disp)
                    tiles[i][j].is_reachable = false;
            }
        }
    }


    public function draw(layer:Sprite):void{
        graphics.clear();

        var self:Sprite = this;
        tiles.forEach(function (v:Vector.<Tile>, index:int, vector:Vector.<Vector.<Tile>>):void{
            v.forEach(function (tile:Tile, index:int, vector:Vector.<Tile>):void{
                tile.draw(self);
            });
        });

        layer.addChild(this);
    }

    public function get tiles():Vector.<Vector.<Tile>> {
        return _tiles;
    }

    // ort + dia
    public function get_eight_connected_tiles(tile:Tile):Array{
        var res:Array = [];

        var t_x:uint = tile.x;
        var t_y:uint = tile.y;

        for (var i:int = t_x - 1; i <= t_x + 1; i++) {
            if(i < 0 || i > tiles.length - 1)
                continue;

            var h_tiles:Vector.<Tile> = tiles[i];
            for (var j:int = t_y - 1; j <= t_y + 1; j++) {

                if(j < 0 || j > h_tiles.length - 1 || h_tiles[j] == tile || !h_tiles[j].is_reachable)
                    continue;

                res.push(h_tiles[j]);
            }
        }
        return res;
    }

    // ort
    public function get_four_connected_tiles(tile:Tile):Array{
        var res:Array = [];

        var tx:int = tile.x;
        var ty:int = tile.y;
        var tile_coords:Array = [{x:tx - 1, y:ty}, {x:tx + 1, y:ty}, {x:tx,  y:ty - 1}, {x:tx,  y:ty + 1}];

        for each (var p:Object in tile_coords){
            tx = p.x;
            ty = p.y;

            if(tx < 0 || tx > tiles.length - 1 || ty < 0 || ty > tiles[tx].length - 1)
                continue;

            if(!tiles[tx][ty].is_reachable)
                continue;

            res.push(tiles[tx][ty]);
        }

        return res;
    }

}
}
