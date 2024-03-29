package game.entity.container;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;
import flash.geom.Point;

import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;
import game.entity.container.Container;
import game.emitter.MultiEmitter;
import game.entity.score.Star;
import utils.SWFHandler;

class Shoe extends Container
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("shoe", xSpeed, ySpeed);
		emitPosition = new Point(-10, -35);
	}

	private override function setEmitter():Void
	{
		emitter = new MultiEmitter(Star, 1, 15);
		var e:MultiEmitter = cast(emitter, MultiEmitter);
		e.setAmount(3, Math.PI/1.5);
	}
}