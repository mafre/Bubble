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

class SineSatellite extends Satellite
{
	public function new(xSpeed:Float, ySpeed:Float):Void
	{
		super(xSpeed, ySpeed);
		duration = 3;
	};

	private override function setEmitter():Void
	{
		emitter = new SineEmitter(Orb1, 10, 10);
	}

	private override function addImage():Void
	{
		image = new Image("images/game/satellite/sineSatellite.png");
		addChild(image);
		image.center();
	}

	public override function duplicate():SineSatellite
	{
		var satellite:SineSatellite = new SineSatellite(xSpeed, ySpeed);
		satellite.x = this.x;
		satellite.y = this.y;
		satellite.rotation = this.rotation;
		return satellite;
	}
}