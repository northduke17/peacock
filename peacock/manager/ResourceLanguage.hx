package peacock.manager;

import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.SecurityErrorEvent;
import openfl.events.HTTPStatusEvent;
import openfl.events.IEventDispatcher;
import openfl.Assets;
import haxe.xml.Fast;
/**
 * ...
 * @author NorthDuke
 */
class ResourceLanguage
{
	public var STRINGMAP:Map<String,String>;
	private var languagemap:Map<String,String>;
	private static var _instance:ResourceLanguage;	
	public static function getInstance():ResourceLanguage {
		if (_instance == null) {
			_instance = new ResourceLanguage();
		}
		return _instance;
	}
	 
	public function new() 
	{
		languagemap = new Map<String, String>();
	}
	/**
	 * set language data
	 * @param	language 
	 * @param	language_url string_xml url
	 */
	public function setLANGUAGEData( language:String, language_url:String ) {
		languagemap.set( language , language_url );
	}
	/**
	 * select language
	 * @param	language
	 * @return
	 */
	public function setLanguage( language:String ):Bool {
		var xml:Xml;
		
		if (languagemap.get( language ) == null ) return false;
		
		xml = Xml.parse(  Assets.getText(  languagemap.get( language )  ) );
		var strings:Fast = new Fast(xml.firstElement());	
	
		STRINGMAP = new Map< String, String >();
		for (elem in strings.elements) {
			var str:String = StringTools.replace( Std.string(elem.innerData), "&#10;", "\n");
			STRINGMAP.set( elem.att.name, str.toString() );			
		}
		
		return true;
	}
}