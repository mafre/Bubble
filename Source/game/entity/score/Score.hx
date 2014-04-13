package game.entity.score;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;
import game.score.ScoreHandler;
import game.entity.player.PlayerProperties;

class Score extends Entity
{
	public var points:Int;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EntityType.SCORE;
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
			case EntityType.PLAYER:
				ScoreHandler.getInstance().addScore(points);
				dispose = true;
		}
	}
}