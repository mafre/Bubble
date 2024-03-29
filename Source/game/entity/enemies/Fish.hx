package game.entity.enemies;

import game.entity.enemies.Enemy;

import common.Image;
import utils.SWFHandler;

import box2D.common.math.B2Vec2;
import box2D.common.math.B2Mat22;
import box2D.common.math.B2Transform;

import common.StageInfo;

class Fish extends Enemy
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		health = 5;
	}

	private override function addImage():Void
	{
		var i:Int = Math.floor(Math.random()*2)+1;
		image = new Image("images/game/enemy/fish"+i+".png");
		addChild(image);
		image.center();
	}

	public override function update():Void
	{
		if(dispose)
		{
			return;
		}

		count++;

		setXPosition(xSpeed + 3.5*Math.cos(Math.PI/2-count/10));
		setYPosition(ySpeed + 3.5*Math.sin(count/10));

		super.checkBoundaries();
		super.update();
	}
}