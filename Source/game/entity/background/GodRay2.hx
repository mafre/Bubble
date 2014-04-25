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
import utils.SWFHandler;

class GodRay2 extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("godRay2", xSpeed, ySpeed);
		type = EntityType.BACKGROUND;
		layer = 1;
		addBody = false;

		mc.alpha = 0;
		mc.scaleX = mc.scaleY = ((GameProperties.worldBottom-GameProperties.worldTop)/mc.height);

		Actuate.tween(mc, 1, { alpha:0.02 }, false).ease(Quad.easeIn).onComplete(function()
		{
			Actuate.tween(mc, 0.5, { alpha:0.02 }, false).ease(Quad.easeIn).onComplete(function()
			{
				Actuate.tween(mc, 1, { alpha:0 }, false).ease(Quad.easeOut).onComplete(function()
				{
					dispose = true;
				});
			});
		});
	};
}