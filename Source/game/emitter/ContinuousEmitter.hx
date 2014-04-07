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

class ContinuousEmitter extends Emitter
{
	private var previousEntity:Entity;

	public function new(classType:Class<Dynamic>, timeLimit:Int, speedMod:Float)
	{
		super(classType, timeLimit, speedMod);
	};

	public override function update(startX:Float, startY:Float, angle:Float):Bool
	{
		if(previousEntity == null)
		{
			emit(startX, startY, angle);
			return true;
		}
		else
		{
			if((previousEntity.x+previousEntity.width) < startX)
			{
				emit(startX, startY, angle);
				return true;
			}
		}

		return false;
	}

	public override function emit(startX:Float, startY:Float, angle:Float):Void
	{
		var xSpeed:Float = Math.cos(angle);
		var ySpeed:Float = Math.sin(angle);
		var entity:Entity = Type.createInstance(classType, [xSpeed*speedMod, ySpeed*speedMod]);
		entity.y = startY;

		if(previousEntity == null)
		{
			entity.x = startX;
		}
		else
		{
			entity.x = previousEntity.x + previousEntity.width;
		}
		
		previousEntity = entity;
		EntityHandler.getInstance().addEntity(entity);
	}
}