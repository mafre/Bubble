package game.entity.boat;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;
import flash.geom.Point;

import game.entity.Entity;
import game.emitter.*;
import common.StageInfo;

class Boat extends Entity
{
	static public inline var State_Default:String				= "State.Default";

	private var state:String;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EmitterType.BOAT;
		layer = 4;
		addBody = false;
		state = State_Default;
	};

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
}