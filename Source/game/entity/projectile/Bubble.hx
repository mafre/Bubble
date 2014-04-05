package game.entity.projectile;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.emitter.EmitterType;
import common.StageInfo;
import utils.SoundHandler;

import game.entity.enemies.Enemy;

class Bubble extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EmitterType.BUBBLE;
		layer = 6;
	};

	private override function addImage():Void
	{
		var i:Int = Math.floor(Math.random()*2)+1;
		image = new Image("images/game/projectile/bubble/bubble"+i+".png");
		addChild(image);
		image.center();
	}
	
	public override function handleCollision(entity:Entity):Void
	{
		switch (entity.type)
		{
			case EmitterType.ENEMY:
				var enemy:Enemy = cast(entity, Enemy);
                enemy.takeDamage();
                SoundHandler.playSound("pop");
                dispose = true;
		}
	}
}