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
	static public var speedMod:Float;
	static public var fireRate:Float;
	static public var fireSpeed:Float;
	static public var damage:Float;
	static public var health:Float;
	static public var stars:Int;

	private var so:SharedObject;

	public var speedModList:Array<Float>;
	public var fireRateList:Array<Float>;
	public var fireSpeedList:Array<Float>;
	public var damageList:Array<Float>;
	public var healthList:Array<Float>;

	public var cost:Array<Int>;

	public var speedModIndex:Int;
	public var fireRateIndex:Int;
	public var fireSpeedIndex:Int;
	public var damageIndex:Int;
	public var healthIndex:Int;

	public function new():Void
    {
        dispatcher = new EventDispatcher();
		so = SharedObject.getLocal("player");

		speedModList = [0.1, 0.2, 0.3, 0.4, 0.5];
		fireRateList = [7, 6, 5, 4, 3];
		fireSpeedList = [6, 8, 10, 13, 16];
		damageList = [1, 2, 3, 4, 5];
		healthList = [100, 200, 300, 400, 500];
		cost = [10, 20, 30, 40, 50];
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

		if(so.data.speedModIndex != null)
		{
			speedModIndex = so.data.speedModIndex;
		}
		else
		{
			so.data.speedModIndex = 0;
			so.flush();
		}

		if(so.data.fireRateIndex != null)
		{
			fireRateIndex = so.data.fireRateIndex;
		}
		else
		{
			so.data.fireRateIndex = 0;
			so.flush();
		}

		if(so.data.fireSpeedIndex != null)
		{
			fireSpeedIndex = so.data.fireSpeedIndex;
		}
		else
		{
			so.data.fireSpeedIndex = 0;
			so.flush();
		}

		if(so.data.damageIndex != null)
		{
			damageIndex = so.data.damageIndex;
		}
		else
		{
			so.data.damageIndex = 0;
			so.flush();
		}

		if(so.data.healthIndex != null)
		{
			healthIndex = so.data.healthIndex;
		}
		else
		{
			so.data.healthIndex = 0;
			so.flush();
		}

		if(so.data.stars != null)
		{
			stars = so.data.stars;
		}
		else
		{
			so.data.stars = 0;
			so.flush();
		}

		setProperties(properties);
		updateProperties();
	}

	private function setProperties(properties:Dynamic):Void
	{
		maxSpeed = properties.player.maxSpeed;
	}

	public function updateProperties():Void
	{
		so.data.speedModIndex = speedModIndex;
		so.data.fireRateIndex = fireRateIndex;
		so.data.fireSpeedIndex = fireSpeedIndex;
		so.data.damageIndex = damageIndex;
		so.data.healthIndex = healthIndex;
		so.flush();

		speedMod = speedModList[speedModIndex];
		fireRate = fireRateList[fireRateIndex];
		fireSpeed = fireSpeedList[fireSpeedIndex];
		damage = damageList[damageIndex];
		health = healthList[healthIndex];

		dispatcher.dispatchEvent(new Event(EventType.PLAYER_PROPERTIES_LOADED));
	}

	public function addStar():Void
	{
		stars++;
		so.data.stars = stars;
		so.flush();
		dispatcher.dispatchEvent(new Event(EventType.PLAYER_PROPERTIES_LOADED));
	}

	public function removeStar():Void
	{
		stars--;
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