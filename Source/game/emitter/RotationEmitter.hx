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
import game.GameProperties;

class RotationEmitter extends Emitter
{
	public function new(classType:Class<Dynamic>, distance:Int, speedMod:Float)
	{
		super(classType, distance, speedMod);
	};

	public override function emit(startX:Float, startY:Float, angle:Float):Void
	{
		var xSpeed:Float = Math.cos(angle);
		var ySpeed:Float = Math.sin(angle);
		var direction:Int = ((GameProperties.playerX-startX) < 0) ? -1 : 1;
		var entity:Entity = Type.createInstance(classType, [xSpeed*speedMod, ySpeed*speedMod, direction]);
		entity.x = startX;
		entity.y = startY;
		EntityHandler.getInstance().addEntity(entity);
	}
}