package peacock.ui;


import haxe.Resource;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.utils.Timer;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.Assets;

import peacock.manager.ResourceSprite;
import peacock.manager.AnimationManager;
import peacock.manager.BitmapDataJSONData;

import motion.Actuate;

/**
 * ...
 * @author g3
 */
class ProgressBar extends AnimationManager
{
	private var _min:Float = 0.0;
	private var _max:Float = 100;
	private var _width:Float = 100;
	private var _height:Float = 30;
	private var _leftpadding:Int = 0;
	private var _rightpadding:Int = 0;
	private var bgsprite:Sprite;
	private var frontsprite:Sprite;
	private var bitmapDatafront:BitmapData; 
	private var bitmapDatabg:BitmapData; 	
	private var _pos:Float = 0.0;
	private var _prev_pos:Float = 0.0;
	private var timer:Timer;
	private var force:Bool;
	
	private var framename:String;
	private var bgbitmapstring:String;
	private var frontbitmapstring:String;
	
	private var text_mid:TextField;

	private var icon:AnimationManager;
	private var icon_text:TextField;
	private var icon_button:AnimationManager;
	private var progressbar_animationwidth:Float;
	private var progressbar_animationheight:Float;
	private var front_resourcesprite:ResourceSprite;
	private var front_explosionBitmapJsonData:BitmapDataJSONData;	
	private var animationFront:AnimationManager;
	private var animationBack:AnimationManager;
	private var timer_frame:Int;
	private var start:Bool;
	private var lasttick:Float;
	private var deluminator:AnimationManager;
	private var on_deluminator:Bool;
	public function new(min:Int = 0, max:Float = 100 , framename:String = null, bgbitmapstring:String = null, frontbitmapstring:String = null , leftpadding:Int = 0, rightpadding:Int = 0 )  
	{	
		super();
		front_explosionBitmapJsonData = ResourceSprite.getInstance().getJSONBITMAPData( framename );
		
		animationFront = new AnimationManager();
		animationFront.mouseEnabled = false;
//		animationBack = new AnimationManager();
//		animationBack.mouseEnabled = false;
		
		this.on_deluminator = false;
		this.framename = framename;
		this.bgbitmapstring = bgbitmapstring;
		this.frontbitmapstring = frontbitmapstring;
		
		drawGraphic( this.framename  , this.bgbitmapstring, progressbar_animationwidth, progressbar_animationheight);
	//	drawGraphic( this.framename , this.frontbitmapstring , 0, 0, 0, 0, -1, -1, 0, -1);
		_width = getFrameWidth();
		_height = getFrameHeight();
		
	//	addChild( animationBack );
 		addChild( animationFront );
		
		text_mid = new TextField();
		text_mid.width = getFrameWidth();
//		text_mid.height =100;
		text_mid.x = leftpadding /2- rightpadding/2 - text_mid.width/2;
//		text_mid.y = -13;
		text_mid.mouseEnabled = false;
		addChild( text_mid );
		
		_leftpadding = leftpadding;
		_rightpadding = rightpadding;
		if ( max != 0 )
			_max = max;
		else
			_max = 100;
		
	 			 	 		
		icon = new AnimationManager();
		icon.mouseEnabled = false;
		addChild( icon );
	
		icon_button = new AnimationManager();
		icon_button.mouseEnabled = false;
		addChild( icon_button );
		
		icon_text = new TextField();
		icon_text.mouseEnabled = false;
		addChild( icon_text );
		
		deluminator = new AnimationManager();		
		deluminator.mouseEnabled = false;
		addChild( deluminator );

	//	timer = new Timer (10);
     //   timer.addEventListener (TimerEvent.TIMER, timer_onTimer);
     //   timer.start ();
		force = false;
		this.mouseEnabled = false;
		timer_frame = Lib.getTimer();
	}
//	public function setDeluminator() {
//	}
	public function getDeluminator():AnimationManager {
		return deluminator;
	}
	public function setProgress( min:Int = 0, max:Float = 100 , framename:String = null, bgbitmapstring:String = null, frontbitmapstring:String = null , leftpadding:Int = 0, rightpadding:Int = 0  , animationwidth:Float = 0, animationHeight:Float = 0) {
		front_explosionBitmapJsonData = ResourceSprite.getInstance().getJSONBITMAPData( framename );	
		animationFront.mouseEnabled = false;
		
		this.framename = framename;
		this.bgbitmapstring = bgbitmapstring;
		this.frontbitmapstring = frontbitmapstring;
		this.progressbar_animationwidth = animationWidth;
		this.progressbar_animationheight = animationHeight;
		drawGraphic( this.framename  , this.bgbitmapstring , progressbar_animationwidth , progressbar_animationheight);
		animationFront.drawGraphic( this.framename , this.frontbitmapstring , progressbar_animationwidth, progressbar_animationheight, 0, 0, -1, -1, 0, -1);
		_width = getFrameWidth();
		_height = getFrameHeight();
				
		text_mid.width = getFrameWidth();
		text_mid.x = leftpadding /2- rightpadding/2 - text_mid.width/2;
	//	text_mid.y = -13;
		text_mid.mouseEnabled = false;
		
		_leftpadding = leftpadding;
		_rightpadding = rightpadding;
		if ( max != 0 )
			_max = max;
		else
			_max = 100;
		
	 			 	 		
		icon.mouseEnabled = false;
		icon_button.mouseEnabled = false;
		icon_text.mouseEnabled = false;
		force = false;	
		deluminator.x = -this.width / 2 + _leftpadding;
		
	//	deluminator.x = -this.getFrameWidth() / 2 + _leftpadding;
	}
	/*
	public function startProgress() {
		if (start ) return;
		start = true;
		lasttick = Lib.getTimer();		
		addEventListener( Event.ENTER_FRAME , progressbar_loop );
	}
	public function stopProgress() {
		if ( !start ) return;
		start = false;
		removeEventListener( Event.ENTER_FRAME, progressbar_loop );
	}
	private function progressbar_loop( e:Event ) {
		var delta:Float = Lib.getTimer() - lasttick;
		lasttick = Lib.getTimer();
		
		var t:Float = _prev_pos - _pos;
		if ( t > 0 ) {
			t = -1;
		}else if ( t < 0 )
			t = 1;		
		else {
			force = false;
			t = 0;
		}
		if( _prev_pos != _pos ){
			var width_length:Float =  animationFront.getFrameWidth() - _leftpadding - _rightpadding;
			var percent:Float = width_length * ( _prev_pos + t ) / _max;
 
			animationFront.drawGraphic( framename, frontbitmapstring, 0, 0, 0, 0, _leftpadding, -1, percent, -1);			 
			_prev_pos = _prev_pos + t;
		}	
	}
	*/
	public function getMax():Float {
		return _max;
	}
	public function isFull():Bool {
		if ( _max == _prev_pos )
			return true;
		else
			return false;
	}
	public function seticon(filename:String, imagename:String, iconwidth:Float = 0, iconheight:Float= 0, posX:Float = 0 ,posY:Float = 0 ) {
		  posX = -getFrameWidth() / 2 + _leftpadding / 2 + posX;
		
		icon.x = posX;
		icon.y = posY;
		
		icon.drawGraphic( filename, imagename , iconwidth , iconheight ); 
		icon.mouseEnabled = false;
		icon_text.width = icon.getFrameWidth();
	//	icon_text.height = 100;
		icon_text.x = posX - icon_text.width/2;
		icon_text.y = posY - 20;
		
	}
	public function seticonButton(filename:String, imagename:String, iconwidth:Float = 0, iconheight:Float= 0, e:Dynamic , posX:Float = 0 ,posY:Float = 0  ) {
		posX =  getFrameWidth() / 2 - _rightpadding / 2 + posX;
		/*
		#if flash
		if( e != null ){
			icon_button.mouseEnabled = true;
			icon_button.addEventListener( MouseEvent.MOUSE_DOWN, e ); 
		}
		#end
		*/
		icon_button.x = posX;
		icon_button.y = posY;
		
		icon_button.drawGraphic( filename, imagename , iconwidth , iconheight ); 
		icon_button.setAddMouseEvent( e );
	}	
	
	public function getPrevpos():Float {
		return _prev_pos;
	}
	public function getPos():Float {
		return _pos;
	}
	/**
	 * 프로그래스 바의 위치를 pos로 이동시킵니다. force가 true인 경우 강제로 바를 이동시킵니다.
	 * frameimage가 있을 경우 progressbar의 frontimage를 해당 이미지로 변경합니다.
	 * @param	pos
	 * @param	force
	 * @param	frameimage
	 */
	public function setpos( pos:Float, force:Bool , frameimage:String = null) {
		this.force = force;
		if ( pos >= _max ) {
			_pos = _max;
		}else if( pos <= _min ) {
			_pos = _min;
		}else{
			_pos = pos;
		}
		var width_length:Float =  animationFront.getFrameWidth() - _leftpadding - _rightpadding;
		var percent:Float = width_length * ( _pos ) / _max;
		deluminator.x = -this.width / 2 + _leftpadding + percent;
		animationFront.drawGraphic( framename, frontbitmapstring, progressbar_animationwidth, progressbar_animationheight, 0, 0 , _leftpadding, -1 ,_leftpadding + percent, -1);			 
	}
	public function set_add_pos( add_pos:Float) {
		if ( force ) return;
		if ( _pos + add_pos >= _max ) {
			_pos = _max;
		}else if( _pos +  add_pos  <= _min ) {
			_pos = _min;
		}else{
			_pos += add_pos ;
		}

	}
	/*
	public function timer_onEnterFrame( delta:Float ) {
		
		var t:Float = _prev_pos - _pos;
		if ( t > 0 ) {
			t = -1;
		}else if ( t < 0 )
			t = 1;		
		else {
			force = false;
			t = 0;
		}
		if( _prev_pos != _pos ){
			var width_length:Float =  animationFront.getFrameWidth() - _leftpadding - _rightpadding;
			var percent:Float = animationFront.getFrameWidth() * ( _prev_pos + t ) / _max;
 
			animationFront.drawGraphic( framename, frontbitmapstring, 0, 0, 0, 0, _leftpadding, -1, percent, -1);			 
			_prev_pos = _prev_pos + t;
		}	
	}
	*/
	public function this_enterFrame( delta:Float ,speed:Float ) {
		var t_pos:Float = _pos + delta * speed;
		if ( t_pos <= 0 ) t_pos = 0;
		else if ( t_pos >= _max ) t_pos = _max;
		if ( _pos == t_pos ) return;
		
/*		
		var width_length:Float =  animationFront.getFrameWidth() - _leftpadding - _rightpadding;
		var percent:Float = animationFront.getFrameWidth() * ( t_pos ) / _max;
		var progress_percent:Float =  t_pos  / _max;
		
		if ( progress_percent > 0.99 && frontbitmapstring3 != null ) animationFront.drawGraphic( framename, frontbitmapstring3, 0, 0, 0, 0, _leftpadding, -1, percent, -1);
		else if ( progress_percent > 0.9 && frontbitmapstring2 != null ) animationFront.drawGraphic( framename, frontbitmapstring2, 0, 0, 0, 0, _leftpadding, -1, percent, -1);
		else animationFront.drawGraphic( framename, frontbitmapstring, 0, 0, 0, 0, _leftpadding, -1, percent, -1);
	*/
		var width_length:Float =  animationFront.getFrameWidth() - _leftpadding - _rightpadding;
		var percent:Float = width_length * ( t_pos ) / _max;
		deluminator.x = -this.width / 2 + _leftpadding + percent;
		animationFront.drawGraphic( framename, frontbitmapstring, progressbar_animationwidth, progressbar_animationheight, 0, 0 , _leftpadding, -1 ,_leftpadding + percent, -1);			 
	
		_pos = t_pos;
	}
	public function setText( text:String, textformat:TextFormat , filters:Dynamic , text_y:Float = -13) {
		if ( text_mid.text != text ) {
			text_mid.text = text;
			if ( textformat != null ) text_mid.setTextFormat( textformat );			
			if ( text_y != -13 ) text_mid.y = text_y;
			if ( filters != null && text_mid != null ) text_mid.filters = filters;
		}
	}
	public function getText():String {
		return text_mid.text;
	}
	public function setIconText( text:String, textformat:TextFormat , filters:Dynamic ) {
		icon_text.text = text;
		if ( filters != null ) icon_text.filters = filters;			
		icon_text.setTextFormat( textformat );
	}	
	public function add_forcedChange (val:Float):Void {
		
		val = _pos + val;
		
		if ( val <= _min ) {
			_prev_pos = 0;
			_pos = 0;
			val = 0;
		}else if (val >= _max) {
			_prev_pos = _max;
			_pos = _max;
			val = _max;
		}else {
			_prev_pos = val;
			_pos = val;
		}
		
		var width_length:Float =  animationFront.getFrameWidth() - _leftpadding - _rightpadding;
		var percent:Float = width_length * ( val ) / _max;
		deluminator.x = -this.width / 2 + _leftpadding + percent;
		animationFront.drawGraphic( framename, frontbitmapstring, progressbar_animationwidth, progressbar_animationheight, 0, 0 , _leftpadding, -1 ,_leftpadding + percent, -1);			 
		
    }	
	public function forcedChange (val:Float):Void {
		
		
		
		if ( val <= _min ) {
			_prev_pos = 0;
			_pos = 0;
			val = 0;
		}else if (val >= _max) {
			_prev_pos = _max;
			_pos = _max;
			val = _max;
		}else {
			_prev_pos = val;
			_pos = val;
		}
		
		var width_length:Float =  animationFront.getFrameWidth() - _leftpadding - _rightpadding;
		var percent:Float = width_length * ( val ) / _max;
		deluminator.x = -this.width / 2 + _leftpadding + percent;
		animationFront.drawGraphic( framename, frontbitmapstring, progressbar_animationwidth, progressbar_animationheight, 0, 0 , _leftpadding, -1 ,_leftpadding + percent, -1);			 
		
    }	
	public function getAnimationFront():AnimationManager {
		return animationFront;
	}
	public function getWidth():Float {
		return _width;
	}
	public function getHeight():Float {
		return _height;
	} 
}