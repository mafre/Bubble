package game.entity.score;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;
import flash.geom.Point;

import game.GameProperties;
import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;
import game.entity.score.Score;
import game.score.ScoreHandler;
import game.entity.player.PlayerProperties;
import utils.SWFHandler;

class Star extends Score
{
	private var yComplete:Bool;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("star", xSpeed, ySpeed);
		yComplete = false;
		points = 5;
	};

	public override function handleCollision(entity:Entity):Void
	{
		if(dispose)
		{
			return;
		}
		
		switch (entity.type)
		{
			case EntityType.PLAYER:
				ScoreHandler.getInstance().addScore(points);
				PlayerProperties.getInstance().addStar();
				dispose = true;
		}
	}

	private function getDistanceToPlayer(xPos:Float, yPos:Float):Float
	{
		var xDelta:Float = getXDelta(xPos);
		var yDelta:Float = getYDelta(yPos);
		var d:Float = Math.sqrt(xDelta*xDelta+yDelta*yDelta);
		return d;
	}

	private function getXDelta(xPos:Float):Float
	{
		return GameProperties.playerX-xPos;
	}

	private function getYDelta(yPos:Float):Float
	{
		return GameProperties.playerY-(yPos+GameProperties.cameraYOffset);
	}

	private function getAttractionSpeed(distance:Float):Float
	{
		return 3*(3.5-(distance/100+0.5));
	}

	public override function update():Void
	{
		if(dispose)
		{
			return;
		}

		if(addToStage)
		{
			if(!yComplete)
			{
				if(Math.abs(ySpeed) > 0.2)
				{
					ySpeed *= 0.9;
					setYPosition(ySpeed);
				}
				else
				{
					yComplete = true;
					xSpeed = -GameProperties.globalSpeed*2;
				}
			}

			if(yComplete)
			{
				setXPosition(xSpeed);
			}
			else
			{
				xSpeed *= 0.9;
				setXPosition(xSpeed - 2*GameProperties.globalSpeed);
			}

			var d:Float = getDistanceToPlayer(this.x, this.y);

			if(d < 300)
			{
				setXPosition((getXDelta(this.x)/d)*getAttractionSpeed(d)+GameProperties.globalSpeed*2);
				setYPosition((getYDelta(this.y)/d)*getAttractionSpeed(d));
			}

			if(this.x < 0 || this.y < 0 || this.x > StageInfo.stageWidth || this.y > GameProperties.height)
			{
				dispose = true;
				return;
			}
		}

		super.updateBody();
	}
}