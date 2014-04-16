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

class Seahorse extends Satellite
{
	public function new(xSpeed:Float, ySpeed:Float):Void
	{
		super(xSpeed, ySpeed);
		duration = 120;
		emitPosition = new Point(20, -25);
		id = "Seahorse";
		info = "Sprays bullets";
	};

	private override function getPath():String
	{
		return "images/game/satellite/seahorse.png";
	}

	private override function setEmitter():Void
	{
		emitter = new SprayEmitter(Orb1, 5, 10);
		var e:SprayEmitter = cast(emitter, SprayEmitter);
		e.setAmount(1, Math.PI/5);
	}

	private override function addImage():Void
	{
		image = new Image(getPath());
		addChild(image);
		image.center();
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