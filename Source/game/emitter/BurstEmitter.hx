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

class BurstEmitter extends Emitter
{
	private var amount:Int;
	private var spread:Float;

	public function new(classType:Class<Dynamic>, distance:Int, speedMod:Float)
	{
		super(classType, distance, speedMod);
		amount = 40;
		spread = 3;
	};

	public function setBurst(amount:Int, spread:Float):Void
	{
		this.amount = amount;
		this.spread = spread;
	};

	public function getSpread():Float
	{
		return Math.random()*spread-spread/2;
	}

	public override function emit(startX:Float, startY:Float, angle:Float):Void
	{
		for (i in 0...amount)
		{
			var xSpeed:Float = Math.cos(angle);
			var ySpeed:Float = Math.sin(angle);
			var entity:Entity = Type.createInstance(classType, [xSpeed*speedMod+getSpread(), ySpeed*speedMod+getSpread()]);
			entity.x = startX;
			entity.y = startY;
			EntityHandler.getInstance().addEntity(entity);
		}
	}
}