package game.entity.score;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.emitter.EmitterType;
import common.StageInfo;
import game.score.ScoreHandler;

class Score extends Entity
{
	public var points:Int;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EmitterType.SCORE;
		layer = 3;
		points = 1;
	};

	public override function handleCollision(entity:Entity):Void
	{
		if(dispose)
		{
			return;
		}
		
		switch (entity.type)
		{
			case EmitterType.PLAYER:
				ScoreHandler.getInstance().addScore(points);
				dispose = true;
		}
	}
}