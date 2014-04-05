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
import game.emitter.EmitterType;
import game.score.ScoreHandler;

class Enemy extends Entity
{
	private var health:Int;
	private var score:Int;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);

		health = 1;
		score = 5;
		type = EmitterType.ENEMY;
		layer = 5;
	};

	public function takeDamage():Void
	{
		health--;

		if(health <= 0)
		{
			ScoreHandler.getInstance().addScore(score);
			dispose = true;
		}
	}

	public override function handleCollision(entity:Entity):Void
	{
		
	}
}