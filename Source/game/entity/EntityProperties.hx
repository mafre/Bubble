package game.entity;

import openfl.Assets;
import haxe.Json;
import sys.io.File;
import haxe.ds.StringMap;

import flash.events.EventDispatcher;
import flash.media.*;
import flash.events.Event;
import flash.net.SharedObject;
import flash.utils.Function;

import common.EventType;
import common.DataEvent;
import game.GameProperties;
import game.entity.enemies.Enemy;

class EntityProperties
{
	static public var __instance:EntityProperties;
	public var dispatcher:EventDispatcher;

	static public var Boat_viking_fireRate:Int;
	static public var Boat_pirate_fireRate:Int;

	static public var Projectile_axe_speed:Float;
	static public var Projectile_cannonball_speed:Float;

	static public var enemySpawnCount:StringMap<Int>;
	static public var enemyKillCount:StringMap<Int>;

	private var so:SharedObject;

	public function new():Void
    {
        dispatcher = new EventDispatcher();
		so = SharedObject.getLocal("entity");

		enemySpawnCount = new StringMap<Int>();
		enemyKillCount = new StringMap<Int>();
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

		if(so.data.enemySpawnCount != null)
		{
			enemySpawnCount = so.data.enemySpawnCount;
		}
		else
		{
			so.data.enemySpawnCount = enemySpawnCount;
			so.flush();
		}

		if(so.data.enemyKillCount != null)
		{
			enemyKillCount = so.data.enemyKillCount;
		}
		else
		{
			so.data.enemyKillCount = enemyKillCount;
			so.flush();
		}

		dispatcher.dispatchEvent(new Event(EventType.ENTITY_PROPERTIES_LOADED));
	}

	public function enemySpawned(enemy:Enemy):Void
	{
		if(enemySpawnCount.exists(enemy.id))
		{
			var count:Int = enemySpawnCount.get(enemy.id);
			count++;
			enemySpawnCount.set(enemy.id, count);
		}
		else
		{
			enemySpawnCount.set(enemy.id, 1);
			dispatcher.dispatchEvent(new DataEvent(EventType.NEW_ENEMY_ENCOUNTER, enemy));

			so.data.enemySpawnCount = enemySpawnCount;
			so.flush();
		}
	}

	public function enemyKilled(enemy:Enemy):Void
	{
		if(enemyKillCount.exists(enemy.id))
		{
			var count:Int = enemyKillCount.get(enemy.id);
			count++;
			enemyKillCount.set(enemy.id, count);
		}
		else
		{
			enemyKillCount.set(enemy.id, 1);

			so.data.enemyKillCount = enemyKillCount;
			so.flush();
		}
	}

	public function hasEnemySpawned(id:String):Bool
	{
		return enemySpawnCount.exists(id);
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