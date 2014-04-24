package game.entity.background;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;
import utils.SWFHandler;

class Surface0 extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("surface", xSpeed, ySpeed);
		type = EntityType.BACKGROUND;
		layer = 3;
		addBody = false;
	};
}