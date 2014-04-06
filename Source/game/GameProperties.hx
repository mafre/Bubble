package game;

import flash.events.EventDispatcher;
import flash.media.*;
import flash.events.Event;
import flash.net.SharedObject;
import flash.utils.Function;

import common.EventType;

class GameProperties
{
	static public var __instance:GameProperties;
	public var dispatcher:EventDispatcher;
	public var debug:Bool;

	public function new():Void
    {
        dispatcher = new EventDispatcher();
        debug = true;
    }

    public function addEventListener(type:String, listener:Function):Void
	{
        dispatcher.addEventListener(type, listener);
    }

    public function removeEventListener(type:String, listener:Function):Void
    {
        dispatcher.removeEventListener(type, listener);
    }

	public static function getInstance():GameProperties
    {
        if (GameProperties.__instance == null)
            GameProperties.__instance = new GameProperties();
        return GameProperties.__instance;
    }
}