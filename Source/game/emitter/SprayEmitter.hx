package game.emitter;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;

import common.Image;
import common.StageInfo;
import common.EventType;
import game.emitter.Emitter;
import utils.SoundHandler;
import game.entity.EntityType;
import game.entity.Entity;
import game.entity.EntityHandler;

class SprayEmitter extends Emitter
{
	private var amount:Int;
	private var spread:Float;

	public function new(classType:Class<Dynamic>, timeLimit:Int, speedMod:Float)
	{
		super(classType, timeLimit, speedMod);
		amount = 3;
		spread = Math.PI/4;
	};

	public function setAmount(amount:Int, spread:Float):Void
	{
		this.amount = amount;
		this.spread = spread;
	};

	public function getSpread():Float
	{
		return spread*Math.random()-spread/2;
	}

	public override function emit(startX:Float, startY:Float, angle:Float):Void
	{
		for (i in 0...amount)
		{
			var xSpeed:Float = Math.cos(angle+getSpread());
			var ySpeed:Float = Math.sin(angle+getSpread());
			var entity:Entity = Type.createInstance(classType, [xSpeed*speedMod, ySpeed*speedMod]);
			entity.x = startX;
			entity.y = startY;
			EntityHandler.getInstance().addEntity(entity);
		}
	}
}