package peacock.manager;

import openfl.Assets;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
import openfl.media.Sound;

import motion.Actuate;


typedef SoundData= {
	var sound:Sound;
	var tick:Int;
	var delay:Int;
}

/**
 * ...
 * @author g3
 */
class ResourceSound
{
	private var SoundMap:Map<String,Sound>;
	private var BGMMap:Map<String,Sound>;	
	private var soundEffect:Bool;
	
	private var introBGM:Sound;
	private var mainBGM:Sound;
	private var restBGM:Sound;
	private var kingBGM:Sound;
	private var killBGM:Sound;
	private var storyBGM:Sound;
	private var jumpBGM:Sound;

	private var marchBGM:Sound;
	private var introbgmtransform:SoundTransform;
	
	private var bgm:Sound;
	private var bgmtransform:SoundTransform;	
	private var soundMusic:Bool;
	
	private var bgmsound:Sound;
	private var channel:SoundChannel;
	private var channel2:SoundChannel;
	private var channel3:SoundChannel;
	private var bgmchannel:SoundChannel;
	private var channelarray:Array<SoundChannel>;
	private static var _instance:ResourceSound;
	
//	private var sound:Bool;
//	private var music:Bool;
	public static function getInstance():ResourceSound {
		if (_instance == null) {
			_instance = new ResourceSound();
		}
		return _instance;
	}
	
	public function new() 
	{
		SoundMap = new Map<String,Sound>();
		BGMMap = new Map<String, Sound>();
		 	
		
		bgmtransform = new SoundTransform( 1 );
		channelarray = new Array<SoundChannel>();
		soundEffect = true;
		soundMusic = true; 
	}
	public function setSoundData( name:String  , url:String ):Bool {
	 
		var sound:Sound;
		sound = new Sound();
		sound = Assets.getSound( url );
		SoundMap.set( name, sound );
		return true;
	 
	}	
	public function setBGMData( name:String  , url:String ):Bool {
	 
		var sound:Sound;
		sound = new Sound();
		sound = Assets.getSound( url );
		BGMMap.set( name, sound );
		return true;
	 
	}	
	public function getSoundData( name:String):Sound {
		if ( !soundEffect ) return null;
		if ( SoundMap == null ) return null;
		if ( SoundMap.get(name) == null ) return null;
		var sound:Sound = new Sound();
		sound =  SoundMap.get( name );
		return sound;
	}
	public function playBGMData( name:String , volumn:Float , starttime:Float = 0 ):Dynamic {
		if ( !soundMusic ) return null;
		if ( BGMMap == null ) return null;
		if ( BGMMap.get(name) == null ) return null;
		if ( channel != null ) channel.stop();
		var soundtransform:SoundTransform = new SoundTransform( volumn );	   
		bgmsound = BGMMap.get( name );
		channel = bgmsound.play( 0, 9999, bgmtransform );
//		Actuate.timer(delay).onComplete( channel.play, [0 ,0, soundtransform] );
//		channel.
 		return null;
		 
	}
	
	public function getSound():Bool {
		return soundEffect;
	}
	public function setSound( value:Bool ) {
		soundEffect = value;
	}

	public function getMusic():Bool {
		return soundMusic;
	}
	public function setMusic( value:Bool ) {
		soundMusic = value;
	}
	
	public function playOneSoundData( name:String , volumn:Float , delay:Float , starttime:Float = 0 ):Dynamic {
		if ( !soundEffect ) return null;
		if ( SoundMap == null ) return null;
		if ( SoundMap.get(name) == null ) return null;
		var soundtransform:SoundTransform = new SoundTransform( volumn );
		var sound:Sound = new Sound();
		var channel:SoundChannel;
		sound =  SoundMap.get( name );
		Actuate.timer(delay).onComplete( playChannel, [0 , 0, sound, soundtransform] );
 		return null;		 
	}
	public function playChannel( starttime:Float, loop:Int, sound:Sound, soundtransform:SoundTransform ) {
		var channel:SoundChannel = sound.play( starttime, loop , soundtransform);
	}
	/*
	public function effectsound_on() {
		soundEffect = true;
	}
	public function effectsound_off() {
		soundEffect = false;
	}
	public function getEffectsound() {
		return soundEffect;
	}
	*/
	/*
	public function play_storyBGM():Void {
		#if android
		if ( !soundMusic ) return null;		
		if( channel != null ) channel.stop();
		if( channel2 != null ) channel2.stop();
		if ( channel3 != null ) channel3.stop();
		if ( bgmchannel != null ) bgmchannel.stop();
		channel2 = mainBGM.play( 0, 9999, bgmtransform );
		#end
	}
	public function play_intro():Void {
		#if android	
		if ( !soundMusic ) return null;		
		if ( channel != null ) channel.stop();
		if ( bgmchannel != null ) bgmchannel.stop();
		channel = introBGM.play( 0, 9999, bgmtransform );
		#end
		
	}
	
	public function play_marchBGM():Void {
		#if android	
		if ( !soundMusic ) return null;		
		if( channel != null ) channel.stop();
		if( channel2 != null ) channel2.stop();
		if ( channel3 != null ) channel3.stop();
		if ( bgmchannel != null ) bgmchannel.stop();
		channel2 = marchBGM.play( 0, 9999, bgmtransform );
		#end
		
	}
	public function play_jumpBGM():Void {
		#if android	
		if ( !soundMusic ) return null;		
		if( channel != null ) channel.stop();
		if( channel2 != null ) channel2.stop();
		if ( channel3 != null ) channel3.stop();
		if ( bgmchannel != null ) bgmchannel.stop();
		channel2 = jumpBGM.play( 0, 9999, bgmtransform );
		#end
		
	}
	public function play_mainBGM():Void {
		#if android	
		if ( !soundMusic ) return null;		
		if( channel != null ) channel.stop();
		if( channel2 != null ) channel2.stop();
		if ( channel3 != null ) channel3.stop();
		if ( bgmchannel != null ) bgmchannel.stop();
		channel2 = mainBGM.play( 0, 9999, bgmtransform );
		#end
		
	}
	public function play_kingBGM():Void {
		#if android	
		if ( !soundMusic ) return null;		
		if( channel != null ) channel.stop();
		if( channel2 != null ) channel2.stop();
		if ( channel3 != null ) channel3.stop();
		if ( bgmchannel != null ) bgmchannel.stop();
		channel2 = kingBGM.play( 0, 9999, bgmtransform );
		#end
	}
	public function play_restBGM():Void {
		#if android	
		if ( !soundMusic ) return null;		
		if( channel != null ) channel.stop();
		if( channel2 != null ) channel2.stop();
		if ( channel3 != null ) channel3.stop();
		if ( bgmchannel != null ) bgmchannel.stop();
		channel3 = restBGM.play( 0, 9999, bgmtransform );
		#end
		
	}
	public function play_killBGM():Void {
		#if android	
		if ( !soundMusic ) return null;		
		if( channel != null ) channel.stop();
		if( channel2 != null ) channel2.stop();
		if ( channel3 != null ) channel3.stop();
		if ( bgmchannel != null ) bgmchannel.stop();
		channel3 = killBGM.play( 0, 9999, bgmtransform );
		#end
	}
	
	public function stop_music():Void {
		#if android
		if ( channel2 == null ) return;
		channel2.stop();
		#end	
	}
	public function stop_intro():Void {
		#if android	
		if ( channel == null ) return;
		channel.stop();
		#end
	}
	*/
	public function play_bgm():Void {
		#if android
		if ( !soundMusic ) return;	
		if ( bgmsound == null ) return;
		if( channel != null ) channel.stop();
	
		channel = bgmsound.play( 0 , 9999, bgmtransform );
		#end
	}
	
	
	public function stop_bgm():Void {
		#if android
		if ( channel == null ) return;
		channel.stop();
		#end
	}	
	
	/*
	public function setMusicsound_on() {
		soundMusic = true;
	}	
	public function setMusicsound_off() {
		soundMusic = false;
	}	
	*/
}
