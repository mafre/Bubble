package game.entity.background;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;

class Kelp1 extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EntityType.VEGETATION;
		layer = 1;
		addBody = false;
	};

	private override function addImage():Void
	{
		image = new Image("images/game/background/kelp1.png");
		addChild(image);
	}
}