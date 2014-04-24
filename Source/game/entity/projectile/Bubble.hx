package game.entity.projectile;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;
import utils.SoundHandler;
import game.entity.player.PlayerProperties;
import utils.SWFHandler;

import game.entity.enemies.Enemy;

class Bubble extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EntityType.PROJECTILE;
		layer = 8;
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
			case EntityType.ENEMY:
				var enemy:Enemy = cast(entity, Enemy);
                enemy.takeDamage(PlayerProperties.damage);
                SoundHandler.playEffect("pop");
                dispose = true;
		}
	}

	public override function checkBoundaries():Bool
	{
		if(this.x < -image.width || this.y < GameProperties.worldTop+25 || this.y > GameProperties.worldBottom-image.height)
		{
			dispose = true;
		}

		return dispose;
	}
}