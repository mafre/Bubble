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

class BurstSatellite extends Satellite
{
	public function new(xSpeed:Float, ySpeed:Float):Void
	{
		super(xSpeed, ySpeed);
		duration = 8;
	};

	private override function setEmitter():Void
	{
		emitter = new BurstEmitter(Orb1, 50, 10);
		var e:BurstEmitter = cast(emitter, BurstEmitter);
		e.setBurst(30, 3);
	}

	private override function addImage():Void
	{
		image = new Image("images/game/satellite/burstSatellite.png");
		addChild(image);
		image.center();
	}

	public override function duplicate():BurstSatellite
	{
		var satellite:BurstSatellite = new BurstSatellite(xSpeed, ySpeed);
		satellite.x = this.x;
		satellite.y = this.y;
		satellite.rotation = this.rotation;
		return satellite;
	}
}