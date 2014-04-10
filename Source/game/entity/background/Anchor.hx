package game.entity.background;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;

class Anchor extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EntityType.BACKGROUND;
		layer = 3;
		addBody = false;
	};

	private override function addImage():Void
	{
		image = new Image("images/game/background/floor1/anchor.png");
		addChild(image);
	}
}