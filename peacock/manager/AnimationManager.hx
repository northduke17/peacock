package peacock.manager ;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.geom.ColorTransform;
import openfl.geom.Rectangle;
import openfl.geom.Matrix;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.utils.Timer;
import openfl.events.TimerEvent;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.filters.BitmapFilter;
//import openfl.filters.GlowFilter;
//import openfl.events.TouchEvent;

import peacock.manager.BitmapDataJSONData;
import peacock.manager.ResourceSprite;
import peacock.manager.ResourceSound;

/**
 * ...
 * @author ...
 */
class AnimationManager extends Sprite
{
	private var frame:Int; 
//	private var explosion:Sprite;
//	private var explosionBack:Sprite;
	private var animationTimer:Timer;
	private var effectTimer:Timer;	
	private var animationWidth:Float;
	private var animationHeight:Float;
	private var animationLoop:Int;
	private var animationType:Int;
	private var explosionBitmapJsonData:BitmapDataJSONData;	
	private var bitmap:Bitmap;
	private var resourcesprite:ResourceSprite;
	private var animationRotation:Float;
//	private var magiceffect:MagicEffect;
	private var removeanimation:Bool;
 
	private var textField:TextField;
//	private var sprite:TileSprite;
	
	private var sprite_frameX:Float;
	private var sprite_frameY:Float;
	private var sprite_frameWidth:Float;
	private var sprite_frameHeight:Float;
	private var sprite_sourceWidth:Float;
	private var sprite_sourceHeight:Float;
	private var sprite_sourceSpriteX:Float;
	private var sprite_sourceSpriteY:Float;
	private var sprite_sourceSpriteWidth:Float;
	private var sprite_sourceSpriteHeight:Float;
	private var spritename:String;
	private var animationFrame:Float;
	private var soundplay:String;

	private var drawX:Float = -1;
	private var drawY:Float = -1;
	private var drawWidth:Float = -1;
	private var drawHeight:Float = -1;
	private var moveX:Float = 0;
	private var moveY:Float = 0; 
	private var isanimation:Bool;
	
//	private static var magiccolor = [ 0xeb0d0d, 0xeb9f0d, 0xfcfe3b, 0x2ceb0d,0x366fff,  0xaa0deb, 0xeb0dbf ];	
	private var buttonmode:Bool;
//	private var buttonanimat
	private var lastTick:Float = 0;
	private var scale_lastTick:Float = 0;
	private var scale_tick:Float = 0;
	private var scale_scaleX:Float = 1;
	private var scale_scaleY:Float = 1;
	private var buttonanimation:Bool;
	private var ani_scaleX:Float = 1;
	private var ani_scaleY:Float = 1;
	private var e:Dynamic;
	public function new() 
	{
		super();
//		scaleX = 5;
//		scaleY = 5;
	//	this.resourcesprite = resourcesprite;
		resourcesprite = ResourceSprite.getInstance();
	//	this.magiceffect = magiceffect;
		buttonmode = false;
		isanimation = false;
	//	explosionBack = new Sprite();	
	//	explosionBack.mouseEnabled = false;
	//	addChild( explosionBack );
	//	this.mouseChildren = true;
		 
	//	explosion = new Sprite();		
	//	explosion.mouseEnabled = false;
	//	explosion.visible = false;
	//	explosion.cacheAsBitmap = true;
	//	addChild( explosion );
	//	#if !flash
	//	addEventListener( Event.ENTER_FRAME , onEnterFrame );
		//#end
	}
 	private function loop(e:Event)
	{
		
		var delta = Lib.getTimer() - lastTick;
		if ( delta < animationFrame ) return;
		lastTick = Lib.getTimer();
		
	//	trace("!!");		
		
		if ( explosionBitmapJsonData == null ) return ;
		
	//	if ( explosion == null ) return;
		
		this.rotation = animationRotation;
		this.graphics.clear();
		if ( frame == 0 ) {
			if ( ResourceSound.getInstance().getSound() ) ResourceSound.getInstance().playOneSoundData( soundplay, 1, 0);	
		}
//		drawGraphic( this.spritename , frame + "" , animationWidth, animationHeight, animationType, animationRotation );
		if (explosionBitmapJsonData.getJsonData().frames[frame] != null ) 
			draw( explosionBitmapJsonData.getBitmap() , explosionBitmapJsonData.getJsonData().frames[frame] , animationWidth , animationHeight );
	
		if(frame +1 < explosionBitmapJsonData.getJsonData().frames.length)
		{
			frame++;
		}else {
			if ( animationLoop > 0 ) {
				frame = 0;
				animationLoop = animationLoop - 1;
				return;
			}
			isanimation = false;
//			trace("end animation");
		//	frame = 0;
 		//	this.rotation = 0;
		//	rotation = 0;
		//	animationTimer.stop();
		//	animationTimer.removeEventListener(TimerEvent.TIMER, loop);
			this.removeEventListener( Event.ENTER_FRAME , loop );
			animationTimer = null;
		//	explosionImages = null;

			if (removeanimation ) stopAnimation(true);
		//	animationType = -1;
			animationLoop = 0;
//			explosion.x = 0;
//			explosion.y = 0;
//			explosion.scaleX = 1;
//			explosion.scaleY = 1;
//			explosion.rotation = 0;
	//		this.graphics.clear();
//			Actuate.timer(animationFrame).onComplete(this.graphics.clear);
//			explosion.graphics.endFill();	
		//	explosionBitmapJsonData = null;
		//	animationWidth = 0 ;
		//	animationHeight = 0;
//			explosion.visible = false;
//			if ( magiceffect != null)
//				magiceffect.removeAnimationlistBack( this );
			
		}
	}	
	
	/*
	 * start animation
	 * sprite name 
	 * drawing center is 0,0 /frame width/2 = 0 = x ,frame height/2 = 0 = y
	 * if you want change animation size : animation width, animationheight
	 * start delay : delay
	 * animation type : not use
	 * animation loop count : animationloop 
	 * animationFrame time, nomral is 1000 millisec ( if you : animationframe = 500 , frame animatino 0.5s ) : animationframe
	 * animationrotaion : change animation rotation, center (0,0)
	 * removeanimation : if you remove final animationframe , change true
	 * soundplay : set frame sound
	 * colortransform : change colortransform,( not perfect )
	 */ 
	public function startAnimation( spritename:String, animationWidth:Float = 0, animationHeight:Float = 0, delay:Float =0, animationType:Int = -1 ,animationLoop:Int=0,animationRotation:Float = 0, animationFrame:Float=0, removeanimation:Bool=false , soundplay:String = null , colortransform:ColorTransform = null, forced:Bool = true , ani_scaleX:Float = 1, ani_scaleY:Float = 1) {
		if ( isanimation && !forced ) return;	
		explosionBitmapJsonData = resourcesprite.getJSONBITMAPData( spritename );
		if ( explosionBitmapJsonData == null || explosionBitmapJsonData.getJsonData() ) {
			trace(spritename + " : no json/bitmap data" );
			return;
		}

		this.isanimation = true;
		this.spritename = spritename;
		this.animationRotation = animationRotation;
		this.animationWidth = animationWidth;		
		this.animationHeight = animationHeight;
		
		this.animationLoop = animationLoop;
		this.animationType = animationType;

		this.ani_scaleX = ani_scaleX;
		this.ani_scaleY = ani_scaleY;
		
		if ( colortransform != null ) this.transform.colorTransform = colortransform;
		else this.transform.colorTransform = new ColorTransform();
	//	this.soundplay = soundplay;
		this.removeanimation = removeanimation;
		if ( animationFrame == 0 ) 
			this.animationFrame = 1000 / explosionBitmapJsonData.getJsonData().frames.length;		
//			this.animationTimer = new Timer(1000 / explosionBitmapJsonData.getJsonData().frames.length);
		else this.animationFrame = animationFrame;
//			this.animationTimer = new Timer( animationFrame );
			
	//	if ( animationWidth == 0 ) this.animationWidth = explosionBitmapJsonData.getJsonData().frame[0].sourceSize.w;
	//	if ( animationHeight == 0 ) this.animationHeight = explosionBitmapJsonData.getJsonData().frame[0].sourceSize.h;


		frame = 0;
		lastTick = Lib.getTimer() + delay;
//		Actuate.timer(delay).onComplete(addEventListener ,[Event.ENTER_FRAME , loop ]  );
		addEventListener( Event.ENTER_FRAME , loop ) ;
//		trace("startanimation");
		
	}
	/**
	 * 그림을 그립니다. 
	 * json rotated의 경우 기준은 left top입니다.
	 * draw+x,y,width,height는 그릴 범위를 정합니다.
	 * @param	framename
	 * @param	spritename
	 * @param	animationWidth
	 * @param	animationHeight
	 * @param	animationType
	 * @param	animationRotation
	 * @param	drawX
	 * @param	drawY
	 * @param	drawWidth
	 * @param	drawHeight
	 */
	public function drawGraphic( framename:String, spritename:String, animationWidth:Float = 0, animationHeight:Float = 0 , animationType:Int = -1  , animationRotation:Float = 0 , t_drawX:Float = -1, t_drawY:Float = -1, t_drawWidth:Float= -1, t_drawHeight:Float = -1 , clear:Bool = true, t_moveX:Float = 0, t_moveY:Float = 0 , colortransform:ColorTransform = null, ani_scaleX:Float = 1, ani_scaleY:Float = 1 ) {
 		explosionBitmapJsonData = resourcesprite.getJSONBITMAPData( framename );
		 
		this.animationRotation = animationRotation;
		this.animationWidth = animationWidth;		
		this.animationHeight = animationHeight;
	//	this.framename = framename
		this.animationType = animationType;
		this.spritename = spritename;
  			
		if ( explosionBitmapJsonData == null ) return ;
//		if ( explosion == null ) return;
		
		this.rotation = 0;	 
		this.rotation = animationRotation;
		
		this.ani_scaleX = ani_scaleX;
		this.ani_scaleY = ani_scaleY;
		
		drawX = t_drawX;
		drawY = t_drawY;
		drawWidth = t_drawWidth;
		drawHeight = t_drawHeight;
		moveX = t_moveX;
		moveY = t_moveY;
		
		
		var temp_sprite:Dynamic =  explosionBitmapJsonData.getJsonMapData().get( spritename );
		if ( temp_sprite == null ) {
			trace(spritename + "sprite is null");
			return;
		}
		if ( animationWidth == 0 ) this.animationWidth = temp_sprite.sourceSize.w;
		if ( animationHeight == 0 ) this.animationHeight = temp_sprite.sourceSize.h;
		
		draw( explosionBitmapJsonData.getBitmap() , temp_sprite , this.animationWidth , this.animationHeight   , t_drawX , t_drawY , t_drawWidth , t_drawHeight , clear, t_moveX, t_moveY );
		if ( colortransform != null ) this.transform.colorTransform = colortransform;
		else this.transform.colorTransform = new ColorTransform();
	}
	private function draw( bitmap:BitmapData, temp_sprite:Dynamic, animationWidth:Float = 0, animationHeight:Float = 0 , t_drawX:Float = -1, t_drawY:Float = -1, t_drawWidth:Float= -1, t_drawHeight:Float = -1 , clear:Bool = true , t_moveX:Float = 0, t_moveY:Float = 0 , colortransform:ColorTransform = null ) {
			
		this.sprite_frameX = temp_sprite.frame.x;
		this.sprite_frameY = temp_sprite.frame.y;
		this.sprite_frameWidth = temp_sprite.frame.w;
		this.sprite_frameHeight = temp_sprite.frame.h;
		this.sprite_sourceWidth = temp_sprite.sourceSize.w;
		this.sprite_sourceHeight = temp_sprite.sourceSize.h;
		this.sprite_sourceSpriteWidth = temp_sprite.spriteSourceSize.w;
		this.sprite_sourceSpriteHeight = temp_sprite.spriteSourceSize.h;
		this.sprite_sourceSpriteX = temp_sprite.spriteSourceSize.x;
		this.sprite_sourceSpriteY = temp_sprite.spriteSourceSize.y;
		var drawX:Float;
		var drawY:Float;
		var drawWidth:Float;
		var drawHeight:Float;
		var temp_sprite_rotated = temp_sprite.rotated + "";
		
		if( clear ) this.graphics.clear();
		
		if ( temp_sprite_rotated == "false"){
			if ( t_drawX == -1 ) drawX = this.sprite_frameX;
			else drawX = this.sprite_frameX + t_drawX;// + drawX;
			if ( t_drawY == -1 ) drawY = this.sprite_frameY;
			else drawY = this.sprite_frameY + t_drawY;// + drawY;

		}else {		
		
			if ( t_drawX == -1 ) drawY = this.sprite_frameY;
			else drawY = this.sprite_frameY + t_drawX;
			
			
			if ( t_drawY == -1 )  drawX = this.sprite_frameX;
			else drawX = this.sprite_frameX + (this.sprite_sourceWidth - t_drawY );					
		}
		
		var drawWidth:Float;
		var drawHeight:Float;
		if ( t_drawWidth == -1 ) drawWidth = this.sprite_frameWidth;
		else drawWidth = t_drawWidth;	
		if ( t_drawHeight == -1 ) drawHeight = this.sprite_frameHeight;
		else drawHeight = t_drawHeight;
		
		var t_scaleX:Float = 1;
		var t_scaleY:Float = 1;
		if( animationWidth !=  0 ) t_scaleX = animationWidth / temp_sprite.sourceSize.w ;
		if( animationHeight != 0 ) t_scaleY = animationHeight / temp_sprite.sourceSize.h;							 
 
		t_scaleX = t_scaleX * ani_scaleX;
		t_scaleY = t_scaleY * ani_scaleY;
	//	if ( t_drawHeight == -1 && t_drawWidth == -1 && this.rotation == 0 && temp_sprite_rotated == "false") this.cacheAsBitmap = true;
	//	else this.cacheAsBitmap = false;
		
		if ( t_drawWidth == -1 ) drawWidth = this.sprite_sourceSpriteWidth;
		else drawWidth = t_drawWidth;
	
		if ( t_drawHeight == -1 ) drawHeight = this.sprite_sourceSpriteHeight;
		else drawHeight = t_drawHeight;
		
	
		var matrix:Matrix = new Matrix();
		if (  temp_sprite_rotated == "true" ) {				
			var matrixY:Float = -sprite_frameX - sprite_sourceSpriteHeight +sprite_sourceHeight/2 - sprite_sourceSpriteY;
			var matrixX:Float = -sprite_frameY -sprite_sourceWidth/2 + sprite_sourceSpriteX;		
			matrix.setTo(t_scaleY,0,0,t_scaleX,matrixY * t_scaleY - t_moveY  ,matrixX * t_scaleX + t_moveX);
			matrix.rotate( -Math.PI / 2);
			this.graphics.beginBitmapFill( bitmap , matrix, true, false);			
			this.graphics.drawRect(  (-sprite_sourceWidth/2 + sprite_sourceSpriteX) * t_scaleX + t_moveX,
										  (-sprite_sourceHeight/2 + sprite_sourceSpriteY) * t_scaleY + t_moveY  , 
										  drawWidth * t_scaleX, 
										  drawHeight * t_scaleY ); 					
			 
		}else {
			var matrixX:Float =  -sprite_frameX - sprite_sourceWidth / 2 + sprite_sourceSpriteX;
			var matrixY:Float =  -sprite_frameY - sprite_sourceHeight / 2 + sprite_sourceSpriteY;
			matrix.setTo(t_scaleX,0,0,t_scaleY,matrixX* t_scaleX + t_moveX  ,matrixY * t_scaleY + t_moveY );
			matrix.rotate( 0);
			this.graphics.beginBitmapFill( bitmap , matrix, true, false);			
			this.graphics.drawRect(  (-sprite_sourceWidth/2 + sprite_sourceSpriteX) * t_scaleX +t_moveX  ,
										  (-sprite_sourceHeight/2 + sprite_sourceSpriteY) * t_scaleY + t_moveY  , 
										  drawWidth * t_scaleX, 
										  drawHeight * t_scaleY ); 					
		}
		/*
		  this.graphics.drawRect(  (-sprite_sourceWidth/2  ) * t_scaleX,
		  (-sprite_sourceHeight/2 ) * t_scaleY, 
		  sprite_sourceWidth * t_scaleX, 
		  sprite_sourceHeight * t_scaleY ); 	
		*/
		this.graphics.endFill();
	//	this.cacheAsBitmap = true;
		
//	 	this.opaqueBackground = 0xffffff;	
	}
	/**
	 * remove all graphic and init all variable
	 */ 
	public function removeDrawGraphic() {
		 
			
		frame = 0;
		this.rotation = 0;
		rotation = 0;
	
		ani_scaleX = 1;
		ani_scaleY = 1;
		animationType = -1;
		animationLoop = 0;
//		explosion.x = 0;
//		explosion.y = 0;
//		explosion.scaleX = 1;
//		explosion.scaleY = 1;
//		explosion.rotation = 0;
		this.graphics.clear();
		this.graphics.endFill();	
		explosionBitmapJsonData = null;
		animationWidth = 0 ;
		animationHeight = 0;
//		explosion.visible = false;
		 
				
	}
	/**
	 *stop animation  
	 * if you force true, not finished animation 
	 * false is last loop finish
	 * @param force 
	 */ 
	public function stopAnimation(  force:Bool) {
	//	trace("stopanimation");
		if ( force ) {
			animationLoop = 0;
			frame = 0;
 			this.rotation = 0;
			rotation = 0;
//			animationTimer.stop();
//			animationTimer.removeEventListener(TimerEvent.TIMER, loop);
			this.removeEventListener( Event.ENTER_FRAME , loop );
			animationTimer = null;
		//	explosionImages = null;
			ani_scaleX = 1;
			ani_scaleY = 1;
			isanimation = false;
			animationType = -1;
//			explosion.x = 0;
//			explosion.y = 0;
//			explosion.scaleX = 1;
//			explosion.scaleY = 1;
//			explosion.rotation = 0;
			this.graphics.clear();
//			explosion.graphics.endFill();	
			explosionBitmapJsonData = null;
			animationWidth = 0 ;
			animationHeight = 0;
			frame = 0;
//			explosion.visible = false;
		}else {
			animationLoop = 1;
		}
	 
	}	
/*	public function viewImage( drawX:Float, drawY:Float, drawWidth:Float, drawHeight:Float ) {
	//	explosion.graphics.drawRect( drawX, drawY, drawWidth , drawHeight );
	//	explosion.focusRect = [ 0 , 0, 100 , 200 ];
	}
	public function remove() {
	//	this.explosion = null;
	//	this.this = null;
		this.explosionBitmapJsonData = null;
	}
*/	
	/**
	 * add mouse down event
	 * @param	e mouse event
	 */
	public function setAddMouseEvent( e:Dynamic ) {
		if ( e == null ) return;
			
	//	if ( explosion.hasEventListener(  MouseEvent.MOUSE_DOWN ) ) return;
			 
		this.mouseEnabled = true;
		this.addEventListener( MouseEvent.MOUSE_DOWN,  e );
		 
	}
	/**
	 *remove mouse down event 
	 * @param	e mouse event
	 */ 
	public function setRemoveMouseEvent( e:Dynamic) {
		if ( e == null ) return;
		this.mouseEnabled = false;
		this.removeEventListener( MouseEvent.MOUSE_DOWN , e);
	 
	}
	/**
	 * add mouse up event
	 * @param e mouse event
	 */ 
	public function setAddMouseUpEvent( e:Dynamic ) {
		if ( e == null ) return;
		//	if (=explosion.hasEventListener( MouseEvent.MOUSE_UP ) ) return;

		this.mouseEnabled = true;
		this.addEventListener( MouseEvent.MOUSE_UP,  e );
	}
	/**
	 * remove mouse up event
	 * @param e mouse event
	 */ 
	public function setRemoveMouseUpEvent( e:Dynamic) {
		if ( e == null ) return;
		this.mouseEnabled = false;
		this.removeEventListener( MouseEvent.MOUSE_UP , e);
 
	}
	/**
	 * add mouse move event
	 * @param e mouse event
	 */ 
	public function setAddMouseMoveEvent( e:Dynamic ) {
		if ( e == null ) return;  
		//	if ( explosion.hasEventListener( MouseEvent.MOUSE_MOVE ) ) return;

		this.mouseEnabled = true;
		this.addEventListener( MouseEvent.MOUSE_MOVE,  e );
	}
	/**
	 * remove mouse move event
	 * @param e mouse event
	 */ 
	public function setRemoveMouseMoveEvent( e:Dynamic) {
		if ( e == null ) return;
		this.mouseEnabled = false;
		this.removeEventListener( MouseEvent.MOUSE_MOVE , e);
		
	}
	
	public function getFrameX():Float {
		return sprite_frameX;
	}
	public function getFrameY():Float {
		return sprite_frameY;
	}
	public function getFrameWidth():Float {
		
		return sprite_frameWidth;
	}
	public function getFrameHeight():Float {
		return sprite_frameHeight;
	}
	public function getSpriteName():String {
		return spritename;
	}
	
	public function setAddMouseClickEvent( e:Dynamic ) {
		if ( e == null ) return;
			
	//	if ( explosion.hasEventListener(  MouseEvent.MOUSE_DOWN ) ) return;
			 
		this.mouseEnabled = true;
		this.addEventListener( MouseEvent.CLICK,  e );
		 
	}
	public function setRemoveMouseClickEvent( e:Dynamic) {
		if ( e == null ) return;
		this.mouseEnabled = false;
		this.removeEventListener( MouseEvent.CLICK , e);
	 
	}
	/**
	 * set mouse button mode, add click animation , add main text
	 *  : e
	 *  : name
	 *  : format
	 *  : name_padding
	 * : filter
	 *  : buttonanimation
	 * @param	e mouse click event
	 * @param	name animation main text
	 * @param	format animation main text format
	 * @param	name_padding animation main text down padding
	 * @param	filter animatino main text filter 
	 * @param	buttonanimation animation buttonanimatino  , if your font bytesize is big, animation is very slow.
	 */ 
	public function setButtonMode( e:Dynamic , name:String = null, format:TextFormat = null , name_padding:Float = null , filter:Array<BitmapFilter> = null, buttonanimation:Bool = true ) {
	//	buttonmode = true;
		mouseEnabled = true;
		this.e = e;
		this.buttonanimation = buttonanimation;
		if ( e != null ) {
			if( buttonanimation ) addEventListener( MouseEvent.MOUSE_DOWN , selectAnimation );
			addEventListener( MouseEvent.CLICK, e );
		}
		if (name != null && textField == null ) {
			textField = new TextField();
			textField.width = this.width + 50;
			textField.height = 50;// this.getFrameHeight();
			textField.x = -textField.width / 2;
			textField.y = name_padding;
			textField.mouseEnabled = false;
			addChild( textField);
			if ( filter != null ) textField.filters = filter;
		}
		if ( name != null ){
			textField.text = name;
			textField.setTextFormat( format );
			textField.y = name_padding;	
		}else if(name == null && textField != null){
			textField.text = "";
		}
	}
	/**
	 * @deprecated
	 * @param	e
	 * @param	name
	 * @param	format
	 * @param	name_padding
	 * @param	filter
	 */
	/*
	public function setButtonTouchMode( e:Dynamic , name:String = null, format:TextFormat=null , name_padding:Float=null ,filter:Array<BitmapFilter> = null) {
		buttonmode = true;
		if ( e != null ) {
		//	#if flash
		//	addEventListener( MouseEvent.MOUSE_UP , e );			
		//	#else
			this.e = e;
			addEventListener( TouchEvent.TOUCH_BEGIN , selectAnimation );
		//	addEventListener( TouchEvent.TOUCH_END , selectAnimation2 );
		//	addEventListener( TouchEvent.TOUCH_OUT , selectAnimation2 );
		//	addEventListener( TouchEvent.TOUCH_BEGIN, e );
		//	#end
		}
		if (name != null && textField == null ) {
			textField = new TextField();
			textField.width = this.getFrameWidth() + 30;
			textField.height = 30;// this.getFrameHeight();
			if ( filter != null ) textField.filters = filter;
			textField.x = -textField.width / 2;
			textField.y = name_padding;
			textField.mouseEnabled = false;
		//	textField.text = name;
		//	textField.setTextFormat( format );
			addChild( textField);
		}
		if ( name != null ){
			textField.text = name;
			textField.setTextFormat( format );
			textField.y = name_padding;			
		}else if(name == null && textField != null){
			textField.text = "";
		}
	}
	*/
	public function removeButtonMode(   name:String = null, format:TextFormat=null , name_padding:Float=null ) {
		buttonmode = false;
//		#if flash
//		removeEventListener( MouseEvent.MOUSE_UP , e );			
//		#else		
		buttonanimation = false;
		if( buttonanimation ) removeEventListener( MouseEvent.MOUSE_DOWN , selectAnimation );
	//	removeEventListener( MouseEvent.MOUSE_OUT , selectAnimation2 );
	//	removeEventListener( MouseEvent.MOUSE_UP , selectAnimation2 );
		if( e != null )	removeEventListener( MouseEvent.CLICK, e );
//		#end
		if ( name != null ){
			textField = new TextField();
			textField.width = this.getFrameWidth();
			textField.x = -textField.width / 2;
			textField.y = name_padding;
			textField.mouseEnabled = false;
			textField.text = name;
			textField.setTextFormat( format );
			addChild( textField);
		}
	}
	public function isAnimationStart():Bool {
		return isanimation;
	}
	public function changeButtonName ( name:String , format:TextFormat , name_padding:Float ) {
		textField.text = name;
		textField.y = name_padding;
		textField.setTextFormat( format );
	}
	/**
	 * set select animation 
	 * @param	mouse
	 */
	public function selectAnimation( mouse:MouseEvent ) {
	//	trace( mouse );
	//	if ( !buttonanimation ) return;// = true;
	//	if ( buttonmode ) return;
		buttonmode = true;
		if ( e != null ) e;

		
		scale_tick = 50;
		scaleX = scale_scaleX = 0.9;
		scaleY = scale_scaleY = 0.9;
		addEventListener( Event.ENTER_FRAME , scale_loop );
		
		
	/*	
		var temp_sprite:Dynamic =  explosionBitmapJsonData.getJsonMapData().get( spritename );
		if ( temp_sprite == null ) {
			trace(spritename + "sprite is null");
			return;
		}
*/
	//	removeDrawGraphic();
	//	this.graphics.clear();
	//	draw( explosionBitmapJsonData.getBitmap() , temp_sprite , animationWidth * scale_scaleX, animationHeight * scale_scaleY  , drawX , drawY , drawWidth , drawHeight , true , moveX, moveY );	
	//	else 
	}
	private function selectAnimation2() {
		if (!buttonanimation ) return;// = true;
	//	if (buttonmode ) return;
		scale_scaleX += 0.05;
		scale_scaleY += 0.05;
		if ( scale_scaleX > 1 ) scale_scaleX = 1;
		if ( scale_scaleY > 1 ) scale_scaleY = 1;
		
		scaleX = scale_scaleX;
		scaleY = scale_scaleY;

	}
	
	private function scale_loop( e:Event ) {
		var delta = Lib.getTimer() - scale_lastTick;
		if ( scale_scaleX >= 1 ) {
			removeEventListener( Event.ENTER_FRAME , scale_loop );
			buttonmode = false;
			return;
		}
		scale_lastTick = Lib.getTimer();
		selectAnimation2();
		
	}
	public function getAnimationWidth():Float {
		return animationWidth;
	}
	public function getAnimationHeight():Float {
		return animationHeight;
	}
}