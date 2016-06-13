package peacock.addon;


import openfl.display.DisplayObject;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.Lib;

/**
 * Stage size, taking into account retina scale
 * @author Philippe / http://philippe.elsass.me
 */

class Env 
{
//	static public var dpi:Float;
	static public var stageWidth:Float; 
	static public var stageHeight:Float; 
	static public var width_dpi:Float;
	static public var height_dpi:Float;
	static public var ratio:Bool;
	
	static public function setup( t_stagewidth:Float, t_stageheight:Float, t_ratio:Bool = true) 
	{ 
		//var stage = Lib.current.stage;
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.stage.addEventListener(Event.RESIZE, stage_resize);

		trace( Lib.current.stage.stageWidth+ " ygtest  " );
		trace( Lib.current.stage.stageHeight+ " ygtest  " );
	//	 142 284 426
//		var scaleX:Float =  Lib.current.stage.stageWidth / 426;
//		var scaleY:Float =  Lib.current.stage.stageHeight / 240;
		var scaleX:Float = 	Lib.current.stage.stageWidth/t_stagewidth;
		var scaleY:Float =  Lib.current.stage.stageHeight/t_stageheight;
//		var scaleX:Float =  Lib.current.stage.stageWidth / 960;
//		var scaleY:Float =  Lib.current.stage.stageHeight / 640;
			//1000 /100
	//	var scaleX:Float =   Lib.current.stage.width /Lib.current.stage.stageWidth;
	//	var scaleY:Float = Lib.current.stage.height / Lib.current.stage.stageHeight;

		//Env.hx:46: width : 375 height : 667 dpi : 0.587147887323944 
		//1000 / 100 = 10 / 0.7
		//500 / 100 = 5
		ratio = t_ratio;
		
		if( ratio ){
			if ( scaleX < scaleY)
			{
				width_dpi = scaleX;
				height_dpi = scaleX;
			}
			else
			{
				width_dpi = scaleY;
				height_dpi = scaleY;// stage.dpiScale;
			} 
	//		dpi = scaleY;// stage.dpiScale;
		}else {
			width_dpi = scaleX;
			height_dpi = scaleY;
		}
	
	//	dpi = scaleX;
		trace( "width : " +  Lib.current.stage.stageWidth  +" height : " +  Lib.current.stage.stageHeight + " dpi : " + width_dpi + ", " + height_dpi );
		trace( "Lib.current.scaleX : " +  Lib.current.scaleX  +" Lib.current.scaleY " +  Lib.current.scaleY    );
		#if DEBUG
	//		dpi = 0.3;
		#end
		
	//	if ( dpi <= 0 ) dpi = 1; 
	//	Lib.current.scaleX = width_dpi;
	//	Lib.current.scaleY = height_dpi;
		Lib.current.stage.scaleX = width_dpi;
		Lib.current.stage.scaleY = height_dpi;

	//	Lib.current.scaleY = Lib.current.scaleX = dpi;
	//	stage_resize(null);
		stageWidth = Lib.current.stage.stageWidth / width_dpi;
		stageHeight = Lib.current.stage.stageHeight / height_dpi; 
		
	}

	static private function stage_resize(e) 
	{
		setup( stageWidth, stageHeight );

		
	//	Lib.current.stage.width = stageWidth;
	//	Lib.current.stage.height = stageHeight;
	//	Lib.current.stage.scaleX = width_dpi;
	//	Lib.current.stage.scaleY = height_dpi;

	//	stageWidth = Math.ceil(Lib.current.stage.stageWidth );
	//	stageHeight = Math.ceil(Lib.current.stage.stageHeight );
//		trace( "resize - width : " +  stageWidth  +" height : " +  stageHeight + " dpi : " + dpi );

	}

}