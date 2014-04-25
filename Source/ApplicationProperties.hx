package game;

import openfl.Assets;
import haxe.Json;

import flash.events.EventDispatcher;
import flash.media.*;
import flash.events.Event;
import flash.net.SharedObject;
import flash.utils.Function;

import common.EventType;
import common.StageInfo;

class ApplicationProperties
{
	static public var __instance:ApplicationProperties;
	static public var dispatcher:EventDispatcher;
	static public var debug:Bool = true;

	public function new():Void
    {
        dispatcher = new EventDispatcher();
    }

    public function addEventListener(type:String, listener:Function):Void
    {
        dispatcher.addEventListener(type, listener);
    }

    public function removeEventListener(type:String, listener:Function):Void
    {
        dispatcher.removeEventListener(type, listener);
    }

	public static function getInstance():ApplicationProperties
    {
        if (ApplicationProperties.__instance == null)
            ApplicationProperties.__instance = new ApplicationProperties();
        return ApplicationProperties.__instance;
    }
}