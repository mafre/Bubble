package game.entity.background;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import motion.Actuate;
import motion.easing.Quad;

import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;
import game.GameProperties;

class GodRay1 extends Entity
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
		image = new Image("images/game/background/water0/godRay1.png");
		addChild(image);
		image.alpha = 0;
		image.scaleX = image.scaleY = ((GameProperties.worldBottom-GameProperties.worldTop)/image.height);

		Actuate.tween(image, 1, { alpha:0.02 }, false).ease(Quad.easeIn).onComplete(function()
		{
			Actuate.tween(image, 0.5, { alpha:0.02 }, false).ease(Quad.easeIn).onComplete(function()
			{
				Actuate.tween(image, 1, { alpha:0 }, false).ease(Quad.easeOut).onComplete(function()
				{
					dispose = true;
				});
			});
		});
	}
}