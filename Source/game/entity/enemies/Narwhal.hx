package game.entity.enemies;

import game.entity.enemies.Enemy;

import common.Image;

import box2D.common.math.B2Vec2;
import box2D.common.math.B2Mat22;
import box2D.common.math.B2Transform;

import common.StageInfo;

class Narwhal extends Enemy
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		health = 30;
		score = 10;
		id = "Narwhal";
		info = "Attacks with high speed";
	}

	private override function addImage():Void
	{
		path = "images/game/enemy/narwhal3.png";
		image = new Image(path);
		addChild(image);
		image.center();
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