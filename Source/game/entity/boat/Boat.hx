package game.entity.boat;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;
import flash.geom.Point;

import game.entity.Entity;
import game.emitter.*;
import common.EventType;
import common.StageInfo;
import game.entity.projectile.Bubble;

class Boat extends Entity
{
	static public inline var State_Default:String				= "State.Default";

	private var state:String;
	private var emitPosition:Point;
	private var emitter:Emitter;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EntityType.BOAT;
		layer = 4;
		addBody = false;
		state = State_Default;
		emitPosition = new Point(40, 70);
		setEmitter();
		EntityProperties.getInstance().addEventListener(EventType.ENTITY_PROPERTIES_LOADED, reloadEmitter);
	};

	private function reloadEmitter(e:Event):Void
	{
		setEmitter();
	}

	private function getPath():String
	{
		return "";
	}

	private override function addImage():Void
	{
		image = new Image(getPath());
		addChild(image);
	}

	public function setState(aState:String):Void
	{
		state = aState;
	}

	private function setEmitter():Void
	{
		emitter = new Emitter(Bubble, 5, 30);
	}

	public function getEmitPosition():Point
	{
		return this.localToGlobal(emitPosition);
	};

	private function getAngle():Float
	{
		return Math.PI*1.3;
	}

	public override function update():Void
	{
		super.update();
		emitter.update(getEmitPosition().x, getEmitPosition().y, getAngle());
	}
}