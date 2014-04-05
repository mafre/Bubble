package game.entity.boat;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;
import flash.geom.Point;

import game.entity.Entity;
import game.emitter.*;
import common.StageInfo;
import game.entity.boat.Boat;

class Viking extends Boat
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
	};

	private override function getPath():String
	{
		return "images/game/boat/viking.png";
	}
}