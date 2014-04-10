
package game.entity.background;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;

class Coral4 extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EntityType.BACKGROUND;
		layer = 1;
		addBody = false;
	};

	private override function addImage():Void
	{
		image = new Image("images/game/background/floor0/coral4.png");
		addChild(image);
		image.scaleX = image.scaleY = 2;
	}
}