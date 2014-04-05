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
import game.emitter.EmitterType;
import game.entity.satellite.Satellite;
import game.entity.projectile.Bubble;
import game.entity.player.Player;

class SpraySatellite extends Satellite
{
	public function new(xSpeed:Float, ySpeed:Float):Void
	{
		super(xSpeed, ySpeed);
		duration = 50;
	};

	private override function setEmitter():Void
	{
		emitter = new SprayEmitter(Bubble, 5, 15);
	}

	private override function addImage():Void
	{
		image = new Image("images/game/satellite/spraySatellite.png");
		addChild(image);
		image.center();
	}

	public override function duplicate():SpraySatellite
	{
		var satellite:SpraySatellite = new SpraySatellite(xSpeed, ySpeed);
		satellite.x = this.x;
		satellite.y = this.y;
		satellite.rotation = this.rotation;
		return satellite;
	}
}