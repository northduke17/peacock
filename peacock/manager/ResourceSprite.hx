package peacock.manager;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import haxe.Json;
import haxe.Utf8;
import peacock.manager.BitmapDataJSONData;
import motion.Actuate;
/**
 * ...
 * read textpacker`s json and image
 * ResourceSprite Singleton
 * @author g3
 */
class ResourceSprite
{
	
	private var FrameBitmapJson:Map<String,BitmapDataJSONData>;
	private static var _instance:ResourceSprite;
	
	public static function getInstance():ResourceSprite {
		if (_instance == null) {
			_instance = new ResourceSprite();
		}
		return _instance;
	}
	public function new() 
	{
		
		FrameBitmapJson = new Map< String, BitmapDataJSONData >();
	
		
	}
	
	/**
	 * texturepacker`s image and json read
	 * @param	name framename
	 * @param	bitmapDataString image path
	 * @param	jsondataString image json path
	 * @return
	 */
	public function setJSONBITMAPDate( name:String, bitmapDataString:String, jsondataString:String ):Bool {
		var jsonStr : String;	
		
		if ( FrameBitmapJson.exists( name ) ) {
			trace( "already exist frame name : " + name ); 
			return false;
		}else {
			if ( name == null || bitmapDataString == null || jsondataString == null ) {
				trace ( "not enough  info" );
				return false;
			}
		
			jsonStr = Assets.getText(jsondataString ) ;
			#if (android || ios) 
				jsonStr = Utf8.encode(jsonStr); 
			#end  
					
			var bitmapjson:BitmapDataJSONData =  new BitmapDataJSONData( Assets.getBitmapData( bitmapDataString ),  Json.parse(  jsonStr ));  	
			FrameBitmapJson.set( name, bitmapjson );
			return true;
		}
	}
	public function getJSONBITMAPData( name:String):BitmapDataJSONData{
		if ( FrameBitmapJson == null ) return null;
		return FrameBitmapJson.get( name );
	}
	public function removeJSONBITMAPData( name:String ) {
		if ( FrameBitmapJson == null ) return;
		FrameBitmapJson.get( name ).removeBitmap();
		FrameBitmapJson.remove( name );
	}
}