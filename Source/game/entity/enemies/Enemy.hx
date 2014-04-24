package game.entity.enemies;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;

import Date;

import common.Image;
import common.EventType;
import common.StageInfo;
import utils.SoundHandler;
import flash.geom.Point;
import utils.SWFHandler;

import game.entity.Entity;
import game.entity.EntityProperties;
import game.entity.EntityType;
import game.score.ScoreHandler;
import game.GameProperties;

class Enemy extends Entity
{
	private var health:Float;
	private var score:Int;

	public function new(id:String, xSpeed:Float, ySpeed:Float)
	{
		super(id, xSpeed, ySpeed);

		health = 1;
		score = 5;
		type = EntityType.ENEMY;
		layer = 5;
	};

	private function getXDelta(xPos:Float):Float
	{
		return GameProperties.playerX-xPos;
	}

	private function getYDelta(yPos:Float):Float
	{
		return GameProperties.playerY-(yPos+GameProperties.cameraYOffset);
	}

	private function getDistance(xPos:Float, yPos:Float):Float
	{
		var xDelta:Float = getXDelta(xPos);
		var yDelta:Float = getYDelta(yPos);
		var d:Float = Math.sqrt(xDelta*xDelta+yDelta*yDelta);
		return d;
	}

	private function getAttractionSpeed(distance:Float):Float
	{
		return 3*(3.5-(distance/100+0.5));
	}

	private function attractToPlayer():Void
	{
		var d:Float = getDistance(this.x, this.y);

		if(d < 400)
		{
			setXPosition((getXDelta(this.x)/d)*getAttractionSpeed(d)+GameProperties.globalSpeed);
			setYPosition((getYDelta(this.y)/d)*getAttractionSpeed(d));
		}
	}

	public function takeDamage(damage:Float = 1):Void
	{
		health -= damage;

		if(health <= 0)
		{
			ScoreHandler.getInstance().addScore(score);
			GameProperties.getInstance().increaseMultiplier();
			EntityProperties.getInstance().enemyKilled(this);
			dispose = true;
		}
	}

	public override function handleCollision(entity:Entity):Void
	{
		
	}
}