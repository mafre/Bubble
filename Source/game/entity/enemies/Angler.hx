package game.entity.enemies;

import game.entity.enemies.Enemy;

import common.Image;

import box2D.common.math.B2Vec2;
import box2D.common.math.B2Mat22;
import box2D.common.math.B2Transform;

import common.StageInfo;

class Angler extends Enemy
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		health = 10;
		score = 10;
	}

	private override function addImage():Void
	{
		image = new Image("images/game/enemy/angler.png", true);
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
			setYPosition(ySpeed + 3.5*Math.sin(this.x/100));
			super.checkBoundaries();
		}

		super.updateBody();
	}
}