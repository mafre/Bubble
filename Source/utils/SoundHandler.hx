package utils;

import openfl.Assets;

import flash.media.*;
import flash.events.Event;

class SoundHandler
{
	static public var mute:Bool	= false;
	static public var st:SoundTransform;

	static public var musicTransform:SoundTransform;
	static public var music:Sound;
	static public var musicChannel:SoundChannel;

	public function new()
	{
		st = new SoundTransform(0.6);
		musicTransform = new SoundTransform(0.8);
	}

	public static function playSound(name:String, ?range:Int):Void
	{
		if(mute == true)
		{
			return;
		}

		var sound:Sound = Assets.getSound("assets/audio/"+name+".wav");
		sound.play(0,0,st);
	}

	public static function playMusic(name:String, ?repeat:Bool):Void
	{
		if(mute == true)
		{
			return;
		}

		music = Assets.getSound("assets/audio/"+name+".mp3");
		musicChannel = music.play(0, 0, musicTransform);

		if(repeat != null && repeat)
		{
			musicChannel.addEventListener(Event.COMPLETE, musicComplete);
		}
	}

	private static function musicComplete(e:Event):Void
	{
		trace("nuy");
		musicChannel = music.play(0, 0, musicTransform);
	}

	public static function stopMusic():Void
	{
		if(music != null && musicChannel != null)
		{
			musicChannel.removeEventListener(Event.COMPLETE, musicComplete);
			musicChannel.stop();
		}
	}

	public static function setMute(mute:Bool):Void
	{
		SoundHandler.mute = mute;
	}

	public static function setVolume(volume:Float):Void
	{
		st.volume = volume;
	}
}