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
import game.entity.projectile.Axe;
import game.entity.EntityProperties;
import utils.SWFHandler;

class Viking extends Boat
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("viking", xSpeed, ySpeed);
		emitPosition = new Point(50, 70);
	};

	private override function setEmitter():Void
	{
		emitter = new RotationEmitter(Axe, EntityProperties.Boat_viking_fireRate, EntityProperties.Projectile_axe_speed);
	}
}