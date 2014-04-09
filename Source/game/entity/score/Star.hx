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

class Star extends Score
{
	private var yComplete:Bool;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		yComplete = false;
		points = 5;
	};

	private override function addImage():Void
	{
		image = new Image("images/game/score/star.png");
		addChild(image);
		image.center();
	}

	private function getDistanceToPlayer(xPos:Float, yPos:Float):Float
	{
		var d:Float = Math.sqrt((GameProperties.playerX-xPos)*(GameProperties.playerX-xPos)+(GameProperties.playerY-(yPos+GameProperties.cameraYOffset))*(GameProperties.playerY-(yPos+GameProperties.cameraYOffset)));
		return d;
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
					xSpeed = -3;
				}
			}

			if(yComplete)
			{
				setXPosition(xSpeed);
			}
			else
			{
				xSpeed *= 0.9;
				setXPosition(xSpeed - 3);
			}

			//var d:Float = getDistanceToPlayer(this.x, this.y);
			//trace(d);

			if(this.x < 0 || this.y < 0 || this.x > StageInfo.stageWidth || this.y > GameProperties.height)
			{
				dispose = true;
				return;
			}
		}

		super.updateBody();
	}
}