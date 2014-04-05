package game.emitter;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.utils.Function;

import common.Image;
import common.StageInfo;
import common.EventType;
import utils.SoundHandler;
import game.emitter.EmitterType;
import game.entity.EntityHandler;
import game.entity.Entity;

class LayerEmitter
{
	private var classes:Array<Class<Dynamic>>;
	private var time:Int;
	private var timeLimit:Int;
	private var timeLimitFunction:Function;
	private var layerFunction:Function;
	private var layerHeight:Float;
	private var speedMod:Float;
	private var duration:Int;
	private var alignBottom:Bool;

	public function new(classes:Array<Class<Dynamic>>, timeLimitFunction:Function, layerFunction:Function, layerHeight:Float, speedMod:Float, ?alignBottom:Bool)
	{
		this.classes = classes;
		this.timeLimitFunction = timeLimitFunction;
		this.layerFunction = layerFunction;
		this.layerHeight = layerHeight;
		this.speedMod = speedMod;
		timeLimit = timeLimitFunction();

		if(alignBottom != null)
		{
			this.alignBottom = alignBottom;
		}
		else
		{
			this.alignBottom = false;
		}

		time = 0;
	}

	public function setDuration(aDuration:Int):Void
	{
		duration = aDuration;
	}

	public function update(startX:Float, startY:Float, angle:Float):Bool
	{
		time++;
		if(time == timeLimit)
		{
			emit(startX, startY, angle);
			time = 0;
			timeLimit = timeLimitFunction();
			return true;
		};

		return false;
	}

	public function emit(startX:Float, startY:Float, angle:Float):Void
	{
		var xSpeed:Float = Math.cos(angle);
		var ySpeed:Float = Math.sin(angle);
		var i:Int = Math.floor(Math.random()*classes.length);
		var entity:Entity = Type.createInstance(classes[i], [xSpeed*speedMod, ySpeed*speedMod]);

		var layer:Int = layerFunction();
		entity.x = startX;
		entity.y = startY+layer*layerHeight+entity.offsetY;
		entity.layer = layer;

		if(alignBottom)
		{
			entity.y -= entity.height;
		}
		
		EntityHandler.getInstance().addEntity(entity);
	}
}