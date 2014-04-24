package game.entity.enemies;

import game.entity.enemies.Enemy;

import common.Image;
import utils.SWFHandler;

import box2D.common.math.B2Vec2;
import box2D.common.math.B2Mat22;
import box2D.common.math.B2Transform;

import common.StageInfo;

class Jellyfish extends Enemy
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("jellyfish", xSpeed, ySpeed);
		health = 5;
		info = "Will burn if touched";
	}

	public override function update():Void
	{
		if(dispose)
		{
			return;
		}

		if(addToStage)
		{
			count++;

			setXPosition(xSpeed + 3.5*Math.cos(Math.PI/2-count/10));
			setYPosition(ySpeed + 3.5*Math.sin(count/10));

			super.checkBoundaries();
		}

		super.updateBody();
	}
}