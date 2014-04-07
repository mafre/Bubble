package game.entity;

import openfl.Assets;
import haxe.Json;
import sys.io.File;

import flash.events.EventDispatcher;
import flash.media.*;
import flash.events.Event;
import flash.net.SharedObject;
import flash.utils.Function;

import common.EventType;
import game.GameProperties;

class EntityProperties
{
	static public var __instance:EntityProperties;
	public var dispatcher:EventDispatcher;

	static public var globalSpeed:Float;

	static public var Boat_viking_fireRate:Int;
	static public var Boat_pirate_fireRate:Int;

	static public var Projectile_axe_speed:Float;
	static public var Projectile_cannonball_speed:Float;

	public function new():Void
    {
        dispatcher = new EventDispatcher();
        globalSpeed = 2;
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
			properties = Json.parse(File.getContent("/Users/mathiasfredriksson/Library/Application Support/BubbleProperties/entityProperties.json"));
		}
		else
		{
			properties = Json.parse(Assets.getText("assets/json/entityProperties.json"));
		}

		setProperties(properties);

		dispatcher.dispatchEvent(new Event(EventType.ENTITY_PROPERTIES_LOADED));
	}

	private function setProperties(properties:Dynamic):Void
	{
		Boat_viking_fireRate = properties.entity.boat.viking.fireRate;
		Boat_pirate_fireRate = properties.entity.boat.pirate.fireRate;

		Projectile_axe_speed = properties.entity.projectile.axe.speed;
		Projectile_cannonball_speed = properties.entity.projectile.cannonball.speed;
	}

	public static function getInstance():EntityProperties
    {
        if (EntityProperties.__instance == null)
            EntityProperties.__instance = new EntityProperties();
        return EntityProperties.__instance;
    }
}