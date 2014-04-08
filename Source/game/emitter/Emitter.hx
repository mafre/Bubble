package game.emitter;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;

import common.Image;
import common.StageInfo;
import common.EventType;
import utils.SoundHandler;
import game.entity.EntityType;
import game.entity.EntityHandler;
import game.entity.Entity;
import game.GameProperties;

class Emitter
{
	private var classType:Class<Dynamic>;
	public var distance:Int;
	private var previousEmitDistance:Float;
	private var speedMod:Float;
	private var duration:Int;

	public function new(classType:Class<Dynamic>, distance:Int, speedMod:Float)
	{
		this.classType = classType;
		this.distance = distance;
		this.speedMod = speedMod;

		previousEmitDistance = 0;
	}

	public function setDuration(aDuration:Int):Void
	{
		duration = aDuration;
	}

	public function update(startX:Float, startY:Float, angle:Float):Bool
	{
		if(previousEmitDistance+distance < GameProperties.distanceTravelled)
		{
			emit(startX, startY, angle);
			previousEmitDistance = GameProperties.distanceTravelled;
			return true;
		};

		return false;
	}

	public function emit(startX:Float, startY:Float, angle:Float):Void
	{
		var xSpeed:Float = Math.cos(angle);
		var ySpeed:Float = Math.sin(angle);
		var entity:Entity = Type.createInstance(classType, [xSpeed*speedMod, ySpeed*speedMod]);
		entity.x = startX;
		entity.y = startY;
		EntityHandler.getInstance().addEntity(entity);
	}
}