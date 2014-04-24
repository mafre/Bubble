package game.entity.boat;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.geom.Point;

import common.EventType;
import common.StageInfo;
import common.Image;
import game.entity.Entity;
import game.emitter.*;
import game.entity.boat.Boat;
import game.entity.projectile.Cannonball;
import game.entity.EntityProperties;
import utils.SWFHandler;

class Pirate extends Boat
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("pirate", xSpeed, ySpeed);
		emitPosition = new Point(40, 90);
		EntityProperties.getInstance().addEventListener(EventType.ENTITY_PROPERTIES_LOADED, reload);
	};

	private override function setEmitter():Void
	{
		emitter = new Emitter(Cannonball, EntityProperties.Boat_pirate_fireRate, EntityProperties.Projectile_cannonball_speed);
	}

	private function reload(e:Event):Void
	{
		setEmitter();
	}
}