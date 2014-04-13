package game.entity.player;

import openfl.Assets;
import haxe.Json;
import sys.io.File;

import flash.events.EventDispatcher;
import flash.media.*;
import flash.events.Event;
import flash.net.SharedObject;
import flash.utils.Function;
import flash.net.SharedObject;

import common.EventType;
import game.GameProperties;

class PlayerProperties
{
	static public var __instance:PlayerProperties;
	public var dispatcher:EventDispatcher;

	static public var maxSpeed:Int;
	static public var stars:Int;

	private var so:SharedObject;

	public function new():Void
    {
        dispatcher = new EventDispatcher();
		so = SharedObject.getLocal("player");
    }

    public function addEventListener(type:String, listener:Function):Void
	{
        dispatcher.addEventListener(type, listener);
    }

    public function removeEventListener(type:String, listener:Function):Void
    {
        dispatcher.removeEventListener(type, listener);
    }

	public function load():Void
	{
		var properties:Dynamic = null;

		if(GameProperties.getInstance().debug)
		{
			properties = Json.parse(File.getContent("/Users/mathiasfredriksson/Library/Application Support/BubbleProperties/playerProperties.json"));
		}
		else
		{
			properties = Json.parse(Assets.getText("assets/json/playerProperties.json"));
		}

		setProperties(properties);

		if(so.data.stars != null)
		{
			stars = so.data.stars;
		}
		else
		{
			so.data.stars = 0;
			so.flush();
		}

		dispatcher.dispatchEvent(new Event(EventType.PLAYER_PROPERTIES_LOADED));
	}

	private function setProperties(properties:Dynamic):Void
	{
		maxSpeed = properties.player.maxSpeed;
	}

	public function addStar():Void
	{
		stars++;
		so.data.stars = stars;
		so.flush();
		dispatcher.dispatchEvent(new Event(EventType.PLAYER_PROPERTIES_LOADED));
	}

	public static function getInstance():PlayerProperties
    {
        if (PlayerProperties.__instance == null)
            PlayerProperties.__instance = new PlayerProperties();
        return PlayerProperties.__instance;
    }
}