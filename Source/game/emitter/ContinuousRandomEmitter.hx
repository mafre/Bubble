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

class ContinuousRandomEmitter
{
	private var previousEntity:Entity;
	private var classes:Array<Class<Dynamic>>;
	private var speedMod:Float;
	private var duration:Int;
	private var alignBottom:Bool;

	public function new(classes:Array<Class<Dynamic>>, speedMod:Float, ?alignBottom:Bool)
	{	
		this.classes = classes;
		this.speedMod = speedMod;

		if(alignBottom != null)
		{
			this.alignBottom = alignBottom;
		}
		else
		{
			this.alignBottom = false;
		}
	}

	public function setDuration(aDuration:Int):Void
	{
		duration = aDuration;
	}

	public function update(startX:Float, startY:Float, angle:Float):Bool
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

	public function emit(startX:Float, startY:Float, angle:Float):Void
	{
		var xSpeed:Float = Math.cos(angle);
		var ySpeed:Float = Math.sin(angle);
		var i:Int = Math.floor(Math.random()*classes.length);
		var entity:Entity = Type.createInstance(classes[i], [xSpeed*speedMod, ySpeed*speedMod]);
		entity.y = startY;

		if(previousEntity == null)
		{
			entity.x = startX;
		}
		else
		{
			entity.x = previousEntity.x + previousEntity.width;
		}

		if(alignBottom)
		{
			entity.y -= entity.height;
		}
		
		previousEntity = entity;
		EntityHandler.getInstance().addEntity(entity);
	}
}