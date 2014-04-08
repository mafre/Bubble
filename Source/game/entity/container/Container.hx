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

class Container extends Entity
{
	static public inline var State_Closed:String				= "State.Closed";
	static public inline var State_Open:String					= "State.Open";

	private var state:String;
	private var emitter:Emitter;
	private var emitPosition:Point;
	private var health:Int;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EntityType.CONTAINER;
		layer = 1;
		health = 1;
		addBody = false;
		state = State_Closed;
		mouseEnabled = true;

		emitPosition = new Point(0, 0);
		setEmitter();

		addEventListener(MouseEvent.MOUSE_DOWN, open);
	};

	private function setEmitter():Void
	{

	}

	public function getEmitPosition():Point
	{
		return this.localToGlobal(emitPosition);
	};

	private function getPath():String
	{
		return "";
	}

	private override function addImage():Void
	{
		image = new Image(getPath()+"_Closed.png");
		addChild(image);
	}

	public function setState(aState:String):Void
	{
		state = aState;

		switch (state)
		{
			case State_Open:
				image.parent.removeChild(image);
				image = new Image(getPath()+"_Open.png");
				addChild(image);

			case State_Closed:
				image.parent.removeChild(image);
				image = new Image(getPath()+"_Closed.png");
				addChild(image);
		}
	}

	public function open(e:MouseEvent):Void
	{
		health--;

		if(health == 0)
		{
			setState(State_Open);
			emitter.update(getEmitPosition().x, (getEmitPosition().y-GameProperties.cameraYOffset), Math.PI*1.5);
			removeEventListener(MouseEvent.MOUSE_DOWN, open);
		}
	}
}