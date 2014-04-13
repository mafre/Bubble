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

import game.entity.Entity;
import game.entity.EntityType;
import game.score.ScoreHandler;
import game.GameProperties;

class Enemy extends Entity
{
	private var health:Float;
	private var score:Int;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);

		health = 1;
		score = 5;
		type = EntityType.ENEMY;
		layer = 5;
	};

	public function takeDamage(damage:Float = 1):Void
	{
		health -= damage;

		if(health <= 0)
		{
			ScoreHandler.getInstance().addScore(score);
			GameProperties.getInstance().increaseMultiplier();
			dispose = true;
		}
	}

	public override function handleCollision(entity:Entity):Void
	{
		
	}
}