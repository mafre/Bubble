package game.entity.background;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.emitter.EmitterType;
import common.StageInfo;

class Grass2 extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EmitterType.VEGETATION;
		layer = 2;
		addBody = false;
	};

	private override function addImage():Void
	{
		image = new Image("images/game/background/grass2.png");
		addChild(image);
	}
}