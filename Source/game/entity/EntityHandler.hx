package game.entity;

import flash.events.EventDispatcher;
import flash.events.Event;
import flash.utils.Function;
import flash.display.Sprite;

import common.EventType;
import common.StageInfo;
import game.entity.EntityProperties;
import game.entity.Entity;
import game.entity.EntityType;
import game.GameProperties;
import game.entity.enemies.Enemy;

import box2D.dynamics.B2World;

class EntityHandler
{
	static public var __instance:EntityHandler;

	public var dispatcher:EventDispatcher;
	public var container:Sprite;
	public var items:Array<Dynamic>;
    public var remove:Array<Dynamic>;
	public var world:B2World;
    public var layers:Array<Sprite>;

    public function new():Void
    {
        dispatcher = new EventDispatcher();
        items = new Array<Dynamic>();
    }

    public function setContainer(container:Sprite):Void
    {
        this.container = container;
        layers = new Array<Sprite>();

        for (i in 0...9)
        {
            var layer:Sprite = new Sprite();
            layers.push(layer);
            container.addChild(layer);
        }
    }

	public function addEventListener(type:String, listener:Function):Void
	{
        dispatcher.addEventListener(type, listener);
    }

    public function removeEventListener(type:String, listener:Function):Void
    {
        dispatcher.removeEventListener(type, listener);
    }

    public function addEntity(entity:Entity):Void
    {
        if(entity.addToItems)
        {
            items.push(entity);
        }

        if(entity.addBody)
        {
            entity.addedToStage();
        }

        if(entity.addToStage)
        {
            layers[entity.layer].addChild(entity);
        }

        switch (entity.type)
        {
            case EntityType.ENEMY:
                var enemy:Enemy = cast(entity, Enemy);
                EntityProperties.getInstance().enemySpawned(enemy);
        }
    }

    public function removeEntity(entity:Entity):Void
    {
        if(entity.addToStage && entity.parent != null)
        {
            entity.parent.removeChild(entity);
        }

        if(entity.addBody)
        {
            world.destroyBody(entity.body);
        }
        
        if(entity.addToItems)
        {
            items.remove(entity);
        }
    }

    public function update():Void
    {
        world.step(1/30, 10, 10);
        world.clearForces();
        //world.drawDebugData();

        remove = new Array<Dynamic>();

        for (entity in items)
        {
            if(entity.dispose)
            {
                remove.push(entity);
            }
        };

        if(remove.length > 0)
        {
            for (entity in remove)
            {
                removeEntity(entity);
            }
        }

        if(items.length % 200 == 0)
        {
            for (entity in items)
            {
                switch(entity.type)
                {
                    case EntityType.PROJECTILE:
                        removeEntity(entity);
                }
            }
        }

        for (entity in items)
        {
            entity.update();
        }
    }

    public static function getInstance():EntityHandler
    {
        if (EntityHandler.__instance == null)
            EntityHandler.__instance = new EntityHandler();
        return EntityHandler.__instance;
    }
}