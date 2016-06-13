package peacock.manager;

import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.SecurityErrorEvent;
import openfl.events.HTTPStatusEvent;
import openfl.events.IEventDispatcher;
import openfl.Assets;
import haxe.xml.Fast;
import flash.text.TextFormat;
import peacock.manager.new;

/**
 * ...
 * @author NorthDuke
 */
class ResourceFont
{

	private var fontmap:Map<String, TextFormat>;
	
	public static function getInstance():ResourceFont {
		if (_instance == null) {
			_instance = new ResourceFont();
		}
		return _instance;
	}
	 
	public function new() 
	{
		fontmap = new Map < String, TextFormat >();
	}
	public function getFont( fontname:String, fontalign:String, fontsize:Int, fontcolor:Int ) 
	{
		
	//	var font:TextFormat = 
	}
	 
}