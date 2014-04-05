package game.entity.background;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.emitter.EmitterType;
import common.StageInfo;

class Sand2 extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EmitterType.VEGETATION;
		layer = 0;
		addBody = false;
	};

	private override function addImage():Void
	{
		image = new Image("images/game/background/sand3.png");
		addChild(image);
	}
}