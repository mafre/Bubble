package game.entity.container;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;
import flash.geom.Point;

import game.GameProperties;
import game.entity.Entity;
import game.emitter.*;
import common.StageInfo;
import utils.SWFHandler;

class Container extends Entity
{
	static public inline var State_Closed:String				= "State.Closed";
	static public inline var State_Open:String					= "State.Open";

	private var state:String;
	private var emitter:Emitter;
	private var emitPosition:Point;
	private var health:Int;

	public function new(id:String, xSpeed:Float, ySpeed:Float)
	{
		super(id, xSpeed, ySpeed);
		type = EntityType.CONTAINER;
		layer = 3;
		health = 1;
		addBody = false;
		state = State_Closed;
		mouseEnabled = true;

		emitPosition = new Point(0, 0);
		setEmitter();

		addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
	};

	private function setEmitter():Void
	{

	}

	public function getEmitPosition():Point
	{
		return this.localToGlobal(emitPosition);
	};

	public function mouseDown(e:MouseEvent):Void
	{
		health--;

		if(health == 0)
		{
			toggle();
			emitter.update(getEmitPosition().x, (getEmitPosition().y-GameProperties.cameraYOffset), Math.PI*1.5);
		}
		else if(health < 0)
		{
			toggle();
		}
	}

	private function toggle():Void
	{
		setState((state == State_Closed) ? State_Open : State_Closed);
	}

	public function setState(aState:String):Void
	{
		state = aState;

		switch (state)
		{
			case State_Open:
				mc.parent.removeChild(mc);
				trace(id);
				trace(id+"_Open");
				mc = SWFHandler.getMovieclip(id+"_Open");
				addChild(mc);

			case State_Closed:
				mc.parent.removeChild(mc);
				mc = SWFHandler.getMovieclip(id+"_Closed");
				addChild(mc);
		}
	}
}