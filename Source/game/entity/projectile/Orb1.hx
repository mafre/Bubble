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

class Orb1 extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("orb", xSpeed, ySpeed);
		type = EntityType.PROJECTILE;
		layer = 8;
	};
	
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
		if(this.x < -mc.width || this.y < GameProperties.worldTop+25 || this.y > GameProperties.worldBottom-mc.height)
		{
			dispose = true;
		}

		return dispose;
	}
}