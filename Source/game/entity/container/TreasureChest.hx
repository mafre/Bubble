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
import game.entity.score.Coin;

class TreasureChest extends Container
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		emitPosition = new Point(90, -15);
	}

	private override function setEmitter():Void
	{
		emitter = new MultiEmitter(Coin, 1, 10);
		var e:MultiEmitter = cast(emitter, MultiEmitter);
		e.setAmount(6, Math.PI/1.5);
	}

	private override function getPath():String
	{
		return "images/game/container/treasureChest";
	}
}