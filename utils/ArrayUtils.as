/**
 * Created with IntelliJ IDEA.
 * User: alexvasilyev
 * Date: 7/13/12
 * Time: 11:58 PM
 * To change this template use File | Settings | File Templates.
 */
package utils {
public class ArrayUtils {
    public function ArrayUtils() {
    }

    public function bin_search(a:Array, e:*, cmp:Function): int{
        var leftIndex:int;
        var rightIndex:int = a.length - 1;
        var middleIndex:int;
        var middleElement:*;

        var cmp_res:int;

        //[1, 2, 5, 6, 8, 12, 21];

        while (leftIndex <= rightIndex)
        {
            middleIndex = (rightIndex + leftIndex) / 2;
            middleElement = a[middleIndex];

            cmp_res = cmp(e, middleElement);

            if(cmp_res == -1){
                rightIndex = middleIndex - 1;
            } else {
                leftIndex = middleIndex + 1;
            }
        }

        if(cmp_res == -1)
            return middleIndex;

        return middleIndex + 1;
    }

}
}
