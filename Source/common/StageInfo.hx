package common;

import flash.events.EventDispatcher;
import flash.events.Event;
import flash.utils.Function;

import common.EventType;

import box2D.dynamics.B2World;

class StageInfo
{
	static public var dispatcher:EventDispatcher	= new EventDispatcher();

	static public var initialized:Bool				= false;
	static public var stageWidth:Int				= 0;
	static public var stageHeight:Int				= 0;
	static public var stageRatio:Float				= 1;
	static public var touchEnabled:Bool				= false;

	public static function resize(width:Int, height:Int):Void
	{
		stageWidth = width;
		stageHeight = height;
		stageRatio = stageWidth/1136;
		dispatcher.dispatchEvent(new Event(EventType.STAGE_RESIZED));

		if(!initialized)
		{
			dispatcher.dispatchEvent(new Event(EventType.STAGE_INITIALIZED));
			initialized = true;
		}
	}

	public static function addEventListener(type:String, listener:Function):Void
	{
        dispatcher.addEventListener(type, listener);
    }

    public static function removeEventListener(type:String, listener:Function):Void
    {
        dispatcher.removeEventListener(type, listener);
    }
}