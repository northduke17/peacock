package peacock.manager;
 
 
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.geom.Rectangle;
import openfl.geom.Point;



/**
 * ...
 * @author g3
 */
class BitmapDataJSONData
{
	private var bitmap:BitmapData;
	private var jsonData:Dynamic;
	private var jsonMapData:Map< String,Dynamic>;
	private var shape:Shape;
	public function new(bitmap:BitmapData, jsonData:Dynamic) {
		this.bitmap = bitmap;
		this.jsonData = jsonData;
		this.jsonMapData = new Map<String, Dynamic>();
		this.shape = new Shape();

	
		
		var temp_jsonData:Array<Dynamic> = jsonData.frames;
		var temp_json:Dynamic;
		var k:Float = 100;
		for ( temp_json in temp_jsonData ) {
			jsonMapData.set( temp_json.filename , temp_json );
			var frame:Rectangle;
			if( temp_json.rotation == "false" )
				frame = new Rectangle( temp_json.frame.x , temp_json.frame.y , temp_json.frame.w, temp_json.frame.h );
			else 
				frame = new Rectangle( temp_json.frame.x , temp_json.frame.y , temp_json.frame.h, temp_json.frame.w );
			
			var sourceSize:Rectangle = new Rectangle( temp_json.sourceSize.x , temp_json.sourceSize.y , temp_json.sourceSize.w , temp_json.sourceSize.h );
			var spritesourcesize:Rectangle = new Rectangle( temp_json.spriteSourceSize.x , temp_json.spriteSourceSize.y , temp_json.spriteSourceSize.w , temp_json.spriteSourceSize.h );
			var pivot:Point =  new Point(temp_json.pivot.x, temp_json.pivot.y);

			#if flash
		//		sheet.addDefinition( temp_json.filename , spritesourcesize, bitmap);						
			#else
//				public function addDefinition(name:String, size:Rectangle, rect:Rectangle, center:Point)
		//		sheet.addDefinition( temp_json.filename ,sourceSize , frame , pivot);	
				
			#end
			
		//	k += 100;
		}
		
	//	layer = new TileLayer(sheet, false);

	}
	
	public function getBitmap():BitmapData {
		return bitmap;
	}
	public function removeBitmap() {
		bitmap.dispose();
		bitmap = null;
	}
	public function getJsonData():Dynamic {
		return jsonData;
	}
	public function getJsonMapData():Map< String,Dynamic> {
		return jsonMapData;
	}
}