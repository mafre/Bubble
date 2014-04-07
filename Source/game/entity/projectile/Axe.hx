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

import game.entity.enemies.Enemy;

class Axe extends Entity
{
	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EntityType.PROJECTILE;
		layer = 6;
	};

	private override function addImage():Void
	{
		image = new Image("images/game/projectile/axe2.png");
		addChild(image);
		image.center();
	}
	
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
		ySpeed += 1;
		this.rotation -= 30;
		super.update();
	}
}