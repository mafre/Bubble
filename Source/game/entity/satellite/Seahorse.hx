package game.entity.satellite;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.geom.Point;

import common.Image;
import common.EventType;
import common.StageInfo;
import game.emitter.*;
import utils.SoundHandler;
import game.entity.EntityType;
import game.entity.satellite.Satellite;
import game.entity.projectile.Orb1;
import game.entity.player.Player;
import utils.SWFHandler;

class Seahorse extends Satellite
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("seaHorse", xSpeed, ySpeed);
		duration = 120;
		emitPosition = new Point(20, -25);
		info = "Sprays bullets";
	};

	private override function setEmitter():Void
	{
		emitter = new SprayEmitter(Orb1, 5, 10);
		var e:SprayEmitter = cast(emitter, SprayEmitter);
		e.setAmount(1, Math.PI/5);
	}

	public override function duplicate():Seahorse
	{
		var satellite:Seahorse = new Seahorse(xSpeed, ySpeed);
		satellite.x = this.x;
		satellite.y = this.y;
		satellite.rotation = this.rotation;
		return satellite;
	}
}