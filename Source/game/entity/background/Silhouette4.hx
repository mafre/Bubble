
package game.entity.background;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;
import utils.SWFHandler;

class Silhouette4 extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("backCoral4", xSpeed, ySpeed);
		type = EntityType.BACKGROUND;
		layer = 1;
		addBody = false;
	};
}