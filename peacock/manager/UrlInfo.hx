package peacock.manager ;
import openfl.events.Event;
import openfl.utils.Timer;
import openfl.net.URLVariables;
import Xml;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.events.TimerEvent;
import openfl.errors.SecurityError;
import openfl.events.SecurityErrorEvent;
import openfl.events.HTTPStatusEvent;
import openfl.events.IEventDispatcher;
import openfl.events.IOErrorEvent;
import peacock.manager.ResourceUrlInfo;
/**
 * ...
 * @author NorthDuke
 */

typedef UrlInfoData= {
	var id:Int;
	var displayedname:String;
	var url:String;
	var paramlist:Array <Dynamic>; 
	var url_function:Dynamic;
	
}
class UrlInfo
{
  	private var id:Int;
	private var displayedname:String;
	private var url:String;
	private var paramlist:Array <Dynamic>; 
	private var url_function:Dynamic;
	private var connect:Bool;
	private var time:Int;
	private var urlRequest:URLRequest;
	private var urlLoader:URLLoader;
//	private var timer:Timer;
	private var complete:Dynamic;
	public function new(id:Int, displayedname:String, url:String, url_function:Dynamic, paramlist:Array<Dynamic>) 
	{
		this.id = id;
		this.displayedname = displayedname;
		this.url = url;
		this.paramlist = paramlist;
		this.url_function = url_function;
		this.connect = false;
		this.time = 0;
	//	this.timer = new Timer(2000);
	//	this.timer.addEventListener(TimerEvent.TIMER, loop);		
		
	}
	public function getId() {
		return id;
	}
	public function getUrl():String {
		return url;
	}
	public function SetData( paramlist:Array<Dynamic> ):URLVariables {
	 
		var i:Int = 0;
		var data:Xml = Xml.createElement( "data" );
		var url_string:String = "";
		if ( this.paramlist == null ) return null;
		if ( paramlist == null ) return null;

		for ( i in 0 ... this.paramlist.length ) {
			//data.addChild( this.paramlist[i] );
			var t_param:Xml = Xml.createElement( this.paramlist[i] );
			var t_p = this.paramlist[i];
			t_param.addChild( Xml.createPCData( paramlist[i] ));
		

			data.addChild( t_param );
	 
			if ( i != 0 ) url_string += "&";
			url_string = url_string + this.paramlist[i] + "=" + paramlist[i];
			
		}
		trace( url_string );
		var url_data:URLVariables = new URLVariables( url_string );
		return url_data;
	}
	
	public function getDisplayedname() {
		return displayedname;
	}
	public function getUrlFunction():Dynamic {
		return url_function;
	}
	public function setConnect(value:Bool ) {
		this.connect = value;
	}
	public function getConnect() {
		return connect;
	}
	public function setTime( value:Int ):Bool {
		if ( time > value ) {
			trace( "url - timeout : " + value );
			return false;
		}
		trace( "url - access time : " + value );
		time = value;
		return true;
	}
	/**
	 * 등록된 urlloader의 이벤트를 모두 해제하고
	 * 새로운 urlloader를 등록한다.
	 * @param	value
	 */
	public function setUrlLoader( value:URLLoader , complete:Dynamic) {
		if( urlLoader != null ){
			if( urlLoader.hasEventListener( Event.COMPLETE) ) urlLoader.removeEventListener(Event.COMPLETE , complete );
			if( urlLoader.hasEventListener( SecurityErrorEvent.SECURITY_ERROR) ) urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR ,securityErrorHandler);
			if( urlLoader.hasEventListener( HTTPStatusEvent.HTTP_STATUS) ) urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS ,httpStatusHandler);
			if( urlLoader.hasEventListener( IOErrorEvent.IO_ERROR) ) urlLoader.removeEventListener(IOErrorEvent.IO_ERROR ,ioErrorHandler );
		}		
		if( value != null ){
			if( !value.hasEventListener( Event.COMPLETE) ) value.addEventListener(Event.COMPLETE , complete );		
			if( !value.hasEventListener( SecurityErrorEvent.SECURITY_ERROR) ) value.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			if( !value.hasEventListener( HTTPStatusEvent.HTTP_STATUS) ) value.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			if( !value.hasEventListener( IOErrorEvent.IO_ERROR) ) value.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		this.complete = complete;
		urlLoader = value;
	
	 
	}
	/**
	 * url의 모든 event 제거
	 */
	public function completeUrl() {
		// timer.stop();
		
		if ( urlLoader == null ) return;
		if( urlLoader.hasEventListener( Event.COMPLETE) ) urlLoader.removeEventListener(Event.COMPLETE , complete );
		if( urlLoader.hasEventListener( SecurityErrorEvent.SECURITY_ERROR) ) urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR ,securityErrorHandler);
		if( urlLoader.hasEventListener( HTTPStatusEvent.HTTP_STATUS) ) urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS ,httpStatusHandler);
		if( urlLoader.hasEventListener( IOErrorEvent.IO_ERROR) ) urlLoader.removeEventListener(IOErrorEvent.IO_ERROR ,ioErrorHandler );
		connect = false;
		urlLoader = null;
		urlRequest = null;
		time = 0;
		trace("stop url send"); 
		
	}
	/**
	 * urlRequest 를 등록한다.
	 * @param	value
	 */
	public function setUrlRequest( value:URLRequest) {
		urlRequest = value;		
	}	
	public function getUrlLoader():URLLoader {
		return urlLoader;
	}
	public function loop(e:Event) {
		if ( urlLoader != null && urlRequest != null ) urlLoader.load(urlRequest);
	}
	public function startConnect() {
		if ( urlLoader == null || urlRequest == null ) return;
		urlLoader.load( urlRequest );
	//	timer.start();
	}
	private function errorHandler(e:IOErrorEvent):Void {
		trace( "Had problem loading the XML File.") ;
		completeUrl();
		/*
		if ( displayedname == "login" ) {
			Main.getInstance().failedLogin();
			return null;
		}
		if(  gamemain!= null &&  gamemain.getLoadingBack() != null )  gamemain.getLoadingBack().visible = false;
		if (  gamemain != null && gamemain.getLoadingBack() != null )  gamemain.getMessageUI().bring_onMessageDisconnect();
		if ( displayedname == "spendenergy" )
			if ( gamemain != null )  gamemain.button_onUpStageUI_EXIT();
		*/
		ResourceUrlInfo.getInstance().failconnectfunction();
	}
	private function securityErrorHandler(event:SecurityErrorEvent):Void {
		trace("securityErrorHandler: " +  event.target );
		completeUrl();
		/*if ( displayedname == "login" ) {
			Main.getInstance().failedLogin();
			return null;
		}
		if( gamemain != null &&  gamemain.getLoadingBack() != null )  gamemain.getLoadingBack().visible = false;
		if ( gamemain != null && gamemain.getLoadingBack() != null )  gamemain.getMessageUI().bring_onMessageDisconnect();
		if ( displayedname == "spendenergy" )
			if ( gamemain != null )  gamemain.button_onUpStageUI_EXIT();
		*/
		ResourceUrlInfo.getInstance().failconnectfunction();
	}
	private function httpStatusHandler(event:HTTPStatusEvent):Void {
		trace("httpStatusHandler: " + event.status);
	//	if( gamemain != null &&  gamemain.getLoadingBack() != null )  gamemain.getLoadingBack().visible = false;
	//	if ( gamemain != null && gamemain.getLoadingBack() != null )  gamemain.getMessageUI().bring_onMessageDisconnect();
	//	if ( displayedname == "spendenergy" )
	//		if ( gamemain != null )  gamemain.button_onUpStageUI_EXIT();
		ResourceUrlInfo.getInstance().failconnectfunction();
	}
	private function ioErrorHandler(event:IOErrorEvent):Void {
		trace("ioErrorHandler: " + event.target );
		completeUrl();
	/*	if ( displayedname == "login" ||displayedname == "regist" ) {
			Main.getInstance().failedLogin();
			return null;
		}
		if(  gamemain != null &&  gamemain.getLoadingBack() != null )  gamemain.getLoadingBack().visible = false;
		if (  gamemain != null && gamemain.getLoadingBack() != null )  gamemain.getMessageUI().bring_onMessageDisconnect();
		if ( displayedname == "spendenergy" )
			if ( gamemain != null )  gamemain.button_onUpStageUI_EXIT();
		*/
		ResourceUrlInfo.getInstance().failconnectfunction();		
	} 
	
}