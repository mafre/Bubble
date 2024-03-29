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

class Dolphin extends Satellite
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("dolphin", xSpeed, ySpeed);
		duration = 30;
		emitPosition = new Point(20, 0);
		info = "Shoots multiple shots at once";
	};

	private override function setEmitter():Void
	{
		emitter = new MultiEmitter(Orb1, 20, 10);
		var e:MultiEmitter = cast(emitter, MultiEmitter);
		e.setAmount(3, Math.PI/5);
	}

	public override function duplicate():Dolphin
	{
		var satellite:Dolphin = new Dolphin(xSpeed, ySpeed);
		satellite.x = this.x;
		satellite.y = this.y;
		satellite.rotation = this.rotation;
		return satellite;
	}
}