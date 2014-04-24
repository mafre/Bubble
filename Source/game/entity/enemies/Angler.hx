package game.entity.enemies;

import game.entity.enemies.Enemy;

import common.Image;
import box2D.common.math.B2Vec2;
import box2D.common.math.B2Mat22;
import box2D.common.math.B2Transform;
import utils.SWFHandler;
import common.StageInfo;

class Angler extends Enemy
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("angler", xSpeed, ySpeed);
		health = 10;
		score = 10;
		info = "Will chase pray in proximity";
	}

	public override function update():Void
	{
		if(dispose)
		{
			return;
		}

		if(addToStage)
		{
			setXPosition(xSpeed);
			setYPosition(ySpeed);

			//attractToPlayer();

			super.checkBoundaries();
		}

		super.updateBody();
	}
}