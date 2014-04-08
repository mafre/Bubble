package game.emitter;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.utils.Function;

import common.Image;
import common.StageInfo;
import common.EventType;
import game.emitter.Emitter;
import utils.SoundHandler;
import game.entity.EntityType;
import game.entity.Entity;
import game.entity.EntityHandler;

class TimedEmitter
{
	private var time:Int;
	private var delayFunction:Function;
	private var delay:Int;
	private var classes:Array<Class<Dynamic>>;
	private var speedMod:Float;
	private var yFunction:Function;
	private var duration:Int;
	private var alignBottom:Bool;

	public function new(classes:Array<Class<Dynamic>>, delayFunction:Function, yFunction:Function, speedMod:Float, ?alignBottom:Bool)
	{
		this.classes = classes;
		time = 0;
		this.delayFunction = delayFunction;
		delay = delayFunction();
		this.speedMod = speedMod;
		this.yFunction = yFunction;

		if(alignBottom != null)
		{
			this.alignBottom = alignBottom;
		}
		else
		{
			this.alignBottom = false;
		}
	};

	public function setDuration(aDuration:Int):Void
	{
		duration = aDuration;
	}

	public function update(startX:Float, startY:Float, angle:Float):Bool
	{
		time++;

		if(time == delay)
		{
			delay = delayFunction();
			time = 0;
			emit(startX, startY, angle);
			return true;
		}

		return false;
	}

	public function emit(startX:Float, startY:Float, angle:Float):Void
	{
		var xSpeed:Float = Math.cos(angle);
		var ySpeed:Float = Math.sin(angle);
		var i:Int = Math.floor(Math.random()*classes.length);
		var entity:Entity = Type.createInstance(classes[i], [xSpeed*speedMod, ySpeed*speedMod]);
		entity.x = startX;
		entity.y = startY+yFunction()+entity.offsetY;

		if(alignBottom)
		{
			entity.y -= entity.height;
		}
		
		EntityHandler.getInstance().addEntity(entity);
	}
}