package peacock.manager;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLRequestHeader;
import openfl.net.URLLoaderDataFormat;
import openfl.net.URLVariables;
import openfl.net.URLRequestMethod;

import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.errors.SecurityError;
import openfl.events.SecurityErrorEvent;
import openfl.events.HTTPStatusEvent;
import openfl.events.IEventDispatcher;
import openfl.Assets;

import haxe.Utf8;
import haxe.Json;
import haxe.Constraints.Function;
import haxe.Ucs2;
import haxe.xml.Fast;
import unifill.Utf16;
/**
 * ...
 * @author NorthDuke
 */
class ResourceUrlInfo
{
 	private	var jsonStr : String;	
	private var urlinfomap : Map< String, UrlInfo >;
	private var urlinfofunctionmap : Map< String, Dynamic >;
	private var urlinfolist : Array<UrlInfo>;  
	private var parsedObject : Dynamic;	
//	private var gamemain:GameMain;
	private var failconnectfunc:Dynamic;
//	private var regist:Function = regist_urlLoader_complete;
//	private var login:Function = login_urlLoader_complete;
	private static var _instance:ResourceUrlInfo;
	
	public static function getInstance():ResourceUrlInfo {
		if (_instance == null) {
			_instance = new ResourceUrlInfo();
		}
		return _instance;
	}
	 
	public function new() 
	{
//		this.gamemain = GameMain.getInstance();
		urlinfolist = new Array<UrlInfo>();  
		urlinfomap = new  Map< String, UrlInfo >();		
		urlinfofunctionmap = new  Map< String, Dynamic >();		
		readJson_UrlInfo();
		 
	}
	private function readJson_UrlInfo(urllist:String , failconnectfunc:Dynamic) {
		var index:Int = 0;
		var i:UrlInfoData; 
		var urlinfo:UrlInfo;
		var data:Array<UrlInfoData>;

		jsonStr =  Assets.getText( urllist ) ;  
		this.failconnectfunc = failconnectfunc;
		parsedObject =  Json.parse(jsonStr);  
		data = parsedObject.data;
		for ( i in data)
		{  
			// android , ios decoding UTF-8
			

			//if aleady exist json key, print json message
			#if JSON
				if ( i.id == "" || i.id == null)
				{
					return;
				}
				Lib.trace("already exist json Key - CharacterData :" + i.id);
			#end
			
			#if (android || ios)
				i.displayedname = decodingString(i.displayedname);
			#end
		
			if (  i.paramlist.length == 0 ) i.paramlist = null;    
			urlinfo = new UrlInfo( i.id, i.displayedname , i.url, i.url_function, i.paramlist  );
	 		urlinfolist.push( urlinfo );
			urlinfomap.set( urlinfo.getDisplayedname() , urlinfo );			
 		}					
	}	
	public function failconnectfunction() {
		failconnectfunc;
	}
	private function decodingString(strSource:String):String
	{
		if (strSource != null)
		{
			return Utf8.decode(strSource);
		}
		return null;
	}		
	public function getUrl( displayedname:String, check:Bool , paramlist:Array<Dynamic> ):Bool {
		trace( "getURL : " + displayedname );
		var urlinfo:UrlInfo = urlinfomap.get( displayedname );
		
		if ( check == true && urlinfo.getConnect() == true ) return false;
//		if ( check == true && gamemain != null ) gamemain.loadingBackOn();
		if ( urlinfo == null ) {
			trace( "URL : no infomation : " + displayedname );
			return false;
		}else {
			trace( "URL name : " + displayedname );
			
			var url:String = urlinfo.getUrl();
		//	url = urlinfo.SetUrl( paramlist );
			trace( url );
			var urlRequest:URLRequest;
			var urlLoader:URLLoader;
			var urlRequestHearder:URLRequestHeader;
//			var urlStream:URLStrea;
			urlRequest = new URLRequest( url );
			urlRequest.method = URLRequestMethod.POST;			
			urlRequest.data =  urlinfo.SetData( paramlist );
			urlLoader = new URLLoader();
			
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			
			//set urlloader to urlinfo
			urlinfo.setUrlLoader ( urlLoader , urlinfofunctionmap.get( urlinfo.getUrlFunction()));		
			urlinfo.setUrlRequest( urlRequest );
			urlinfo.setConnect( check );

			
			urlinfo.startConnect();
			
			return true;
		}
	}
	
	public function getUrlInfoList():Array<UrlInfo> {
		return urlinfolist;
	}
	public function getUrlInfoMap():Map< String, UrlInfo > {
		return urlinfomap;
	} 
}