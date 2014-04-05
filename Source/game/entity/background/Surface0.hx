package game.entity.background;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.emitter.EmitterType;
import common.StageInfo;

class Surface0 extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EmitterType.OTHER;
		layer = 3;
		addBody = false;
	};

	private override function addImage():Void
	{
		image = new Image("images/game/background/surface.png");
		addChild(image);
		image.alpha = 0.5;
	}
}