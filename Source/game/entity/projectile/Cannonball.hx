package game.entity.projectile;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;

import game.entity.Entity;
import game.entity.EntityType;
import common.StageInfo;
import game.entity.player.Player;
import utils.SoundHandler;
import utils.SWFHandler;
import game.entity.enemies.Enemy;

class Cannonball extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("cannonball", xSpeed, ySpeed);
		type = EntityType.PROJECTILE;
		layer = 8;
	};
	
	public override function handleCollision(entity:Entity):Void
	{
		switch (entity.type)
		{
			case EntityType.ENEMY:
				var enemy:Enemy = cast(entity, Enemy);
                enemy.takeDamage(3);
                SoundHandler.playEffect("pop");
                dispose = true;

			case EntityType.PLAYER:
				var player:Player = cast(entity, Player);
                player.takeDamage(3);
                SoundHandler.playEffect("pop");
                dispose = true;
		}
	}

	public override function update():Void
	{
		ySpeed += 0.98;
		super.update();
	}
}