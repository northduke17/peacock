package peacock.ui;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.Lib;
import peacock.manager.AnimationManager;
/**
 * ...
 * @author g3
 */
class ScrollPanal extends AnimationManager
{

	private var panal:Sprite;
	private var mouse_panal:Sprite;
	private var screen:Rectangle;
	private var storelastTick:Float;
	private var mouseDir:Float;
	private var mouseStartY:Float;
	private var mouseDown:Bool;
	private var storeleft_destY:Float;
	private var page:Float;
	public function new() 
	{
		super();
		
		panal = new Sprite();
		panal.x = 0;
		panal.y = 0;
		addChild( panal );
		
	//	mouse_panal = new Sprite();
		this.addEventListener( Event.ENTER_FRAME, enterFrame );		
		this.addEventListener( MouseEvent.MOUSE_DOWN, storeleft_onMouseDown );
		this.addEventListener( MouseEvent.MOUSE_MOVE, storeleft_onMouseMove );
		this.addEventListener( MouseEvent.MOUSE_UP, storeleft_onMouseUp );
		this.addEventListener( MouseEvent.MOUSE_OUT, storeleft_onMouseOut );	
	//	addChild( mouse_panal);
		
	}
	public function setPage( page:Float ) {
		this.page = page;
		panal.y = 0;
		storeleft_destY = panal.y;		
	}
	function enterFrame(e:Event){
		var delta = Lib.getTimer() - storelastTick;
	//	if ( mouseDown  ) 
		update(delta);
		storelastTick = Lib.getTimer();
	//	trace(nativetextfield.GetText());
/*		if ( nativetextfield.IsFocused() && join_textinput.text != nativetextfield.GetText() ) {
			join_textinput.text = nativetextfield.GetText();
			join_textinput.setTextFormat( format_input );
			trace( "enter : " + join_textinput.text);
			
		}*/
	//	trace( "enter");
	//	trace( join_textinput.text );
	//	join_textinput.setTextFormat( format_input );
		
	}

	function update(delta:Float) {
	 
		var speed = delta * 0.05;
	//	var page :Float= 0;
	//	if( weaponarray != null ) page = weaponarray.length / 10;	

		if ( Math.abs(storeleft_destY - panal.y) < Math.abs( speed ) ) { 
			if( speed > 0 )
				speed = Math.abs(storeleft_destY - panal.y);
			else
				speed = Math.abs(storeleft_destY - panal.y) * -1;
		}
		if( storeleft_destY != panal.y ){		
			if ( storeleft_destY >= panal.y )
				if ( panal.y + speed <= 0 ){
					panal.y +=  speed;
					trace("up");
				}else {
					panal.y = 0;
					storeleft_destY = panal.y;
					trace("up-max");
				}
			else {
				var t = (this.height) * page * -1 ;
				if ( panal.y - speed > (this.height  ) * page * -1 ){
					panal.y -=  speed;
				//	trace("down");
				}else {
					panal.y = (this.height ) * page * -1;
					storeleft_destY = panal.y;
					trace("down-max");
				}
			}
		}
		
	}
	private function storeleft_onMouseDown(e:MouseEvent) {
		mouseStartY = e.stageY;
		mouseDown = true;
	//	mouseDir = 0;
		trace("down mouseStartY : " + mouseStartY );
	}	
	private function storeleft_onMouseUp(e:MouseEvent) {
	//	mouseStartY = e.stageY;
		mouseDown = false;
	//	mouseDir = 0;
		trace("up mouseStartY : " + mouseStartY );
	}
	private function storeleft_onMouseOut(e:MouseEvent) {
	//	mouseStartY = e.stageY;
		mouseDown = false;
	//	mouseDir = 0;
		trace("out mouseStartY : " + mouseStartY );
	}
	public function storeleft_onMouseMove(e:MouseEvent) {
	//	mouseDown = true;
	//	mouseStartY = e.localY;
		var dir = 0;
	//	if( mouseStartY != 0 )
		mouseDir = mouseStartY - e.stageY;
	//	else mouseDir = 0;
		mouseStartY = e.stageY;
	
		
		var speed:Float = mouseDir * -1 * 5;
//		trace( Math.pow( speed ,2 )  );
		if ( Math.abs( speed )  > 10 )
			storeleft_destY = panal.y + speed;
 
		
		trace("move mouseStartY : " + mouseDir + "  mouseDown: " + mouseDown + " : " + storeleft_destY);
	}	
	public function getPanal():Sprite {
		return panal;
	}
	public function setScreen( rect:Rectangle ) {
		this.screen = rect;
		this.scrollRect = this.screen;
		
		this.graphics.beginFill( 0xFF0000, 0.0);
		this.graphics.drawRect( screen.x , screen.y, screen.width,screen.height);
		this.graphics.endFill();
		
	//	mouse_panal.graphics.beginFill( 0xFF0000, 0.5);
	//	mouse_panal.graphics.drawRect( screen.x , screen.y, screen.width,screen.height);
	//	mouse_panal.graphics.endFill();
		
	}
}