package game.entity.player;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.geom.Point;

import motion.Actuate;
import motion.easing.Quad;

import common.Image;
import common.EventType;
import utils.SoundHandler;
import game.entity.EntityHandler;
import game.entity.Entity;
import game.entity.satellite.Satellite;
import game.entity.EntityProperties;
import game.emitter.*;
import game.score.ScoreHandler;
import common.StageInfo;
import game.GameProperties;
import game.entity.player.PlayerProperties;
import game.entity.projectile.Orb1;
import common.Animation;
import utils.SWFHandler;

class Player extends Entity
{
	private var health:Float;
	private var emitPosition:Point;
	private var satellitePositions:Array<Point>;
	private var emitter:Emitter;
	private var satellites:Array<Satellite>;
	private var targetX:Float;
	private var targetY:Float;
	private var maxSatelliteCount:Int;
	private var invunerable:Bool;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super("turtle", xSpeed, ySpeed);

		health = 100;
		invunerable = false;

		type = EntityType.PLAYER;
		layer = 5;

		targetY = StageInfo.stageHeight/2;
		targetX = 100;

		mouseEnabled = true;

		maxSatelliteCount = 1;
		satellites = new Array<Satellite>();
		emitPosition = new Point(50, 0);

		satellitePositions = new Array<Point>();
		satellitePositions.push(new Point(0, 80));
		satellitePositions.push(new Point(0, -80));
		satellitePositions.push(new Point(0, 120));
		satellitePositions.push(new Point(0, -120));
		satellitePositions.push(new Point(-50, 100));
		satellitePositions.push(new Point(-50, -100));

		setEmitter(new Emitter(Orb1, 5, 15));

		PlayerProperties.getInstance().dispatcher.addEventListener(EventType.PLAYER_PROPERTIES_LOADED, setProperties);
	}

	private function setProperties(e:Event):Void
	{
		health = PlayerProperties.health;
		setEmitter(new Emitter(Orb1, PlayerProperties.fireRate, PlayerProperties.fireSpeed));
	}

	public override function handleCollision(entity:Entity):Void
	{
		switch (entity.type)
		{
			case EntityType.ENEMY:
				if(!invunerable)
				{
					takeDamage();
				}

			case EntityType.SATELLITE:
				var satellite:Satellite = cast(entity, Satellite);
                addSatellite(satellite);
		}
	}

	public function takeDamage(damage:Int = 1):Void
	{
		health -= damage;
		invunerable = true;
		ScoreHandler.getInstance().setHealth(health);
		GameProperties.getInstance().resetMultiplier();

		if(health <= 0)
		{
			//dispose = true;
		}

		var blinkDelay:Float = 0.04;
		this.alpha = 0;

		Actuate.timer(blinkDelay).onComplete(function()
		{
			this.alpha = 1;
			Actuate.timer(blinkDelay).onComplete(function()
			{
				this.alpha = 0;
				Actuate.timer(blinkDelay).onComplete(function()
				{
					this.alpha = 1;
					Actuate.timer(blinkDelay).onComplete(function()
					{
						this.alpha = 0;
						Actuate.timer(blinkDelay).onComplete(function()
						{
							this.alpha = 1;
							Actuate.timer(blinkDelay).onComplete(function()
							{
								this.alpha = 0;
								Actuate.timer(blinkDelay).onComplete(function()
								{
									this.alpha = 1;
									Actuate.timer(blinkDelay).onComplete(function()
									{
										this.alpha = 0;
										Actuate.timer(blinkDelay).onComplete(function()
										{
											this.alpha = 1;
											invunerable = false;
										});
									});
								});
							});
						});
					});
				});
			});
		});
	}

	public function addSatellite(aSatellite:Satellite):Void
	{
		aSatellite.dispose = true;
		var satellite:Dynamic = aSatellite.duplicate();
		satellite.addToItems = false;
		satellite.addBody = false;
		satellite.setState(Satellite.State_Added);
		EntityHandler.getInstance().addEntity(satellite);
		EntityProperties.getInstance().satelliteUsed(satellite);

		if(satellites.length == maxSatelliteCount)
		{
			var removed:Satellite = satellites.shift();
			removed.addToItems = true;
			removed.addToStage = true;
			removed.addBody = false;
			removed.setState(Satellite.State_Exit);
			EntityHandler.getInstance().addEntity(removed);
		}

		satellites.push(satellite);
	}

	public function getEmitPosition():Point
	{
		return this.localToGlobal(emitPosition);
	}

	public function getSatellitePosition(id:Int):Point
	{
		return this.localToGlobal(satellitePositions[id]);
	}

	public function setEmitter(emitter:Emitter):Void
	{
		this.emitter = emitter;
	}

	private function getAngle(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
	    var dx:Float = x2 - x1;
	    var dy:Float = y2 - y1;
	    return Math.atan2(dy,dx);
	}

	public override function setPosition(xPos:Float, yPos:Float):Void
	{

	}

	public function dragToPosition(xPos:Float, yPos:Float):Void
	{
		if(yPos < GameProperties.worldTop + mc.height/2)
		{
			yPos = GameProperties.worldTop + mc.height/2;
		}

		if(yPos > GameProperties.worldBottom)
		{
			yPos = GameProperties.worldBottom;
		}

		if(xPos < mc.width/2)
		{
			xPos = mc.width/2;
		}

		if(xPos > (StageInfo.stageWidth-mc.width/2))
		{
			xPos = StageInfo.stageWidth-mc.width/2;
		}

		targetX = xPos;
		targetY = yPos;
	}

	public override function update():Void
	{
		emitter.update(getEmitPosition().x, getEmitPosition().y - GameProperties.cameraYOffset, this.rotation/45);

		for (i in 0...satellites.length)
		{
			satellites[i].updateEmitter(0, getSatellitePosition(i));
		}

		for(satellite in satellites)
		{
			if(satellite.duration <= 0)
			{
				satellite.addToItems = true;
				satellite.addToStage = true;
				satellite.addBody = false;
				satellite.setState(Satellite.State_Exit);
				EntityHandler.getInstance().addEntity(satellite);				
				satellites.remove(satellite);
			}
		}

		this.x += PlayerProperties.speedMod*(targetX - this.x);
		this.y += PlayerProperties.speedMod*(targetY - this.y);
		this.rotation = (targetY - this.y)/7;

		GameProperties.getInstance().setPlayerYPosition(this.y - StageInfo.stageHeight/2);
		GameProperties.getInstance().setPlayerXPosition(this.x);

		super.update();
	}

	public function disposePlayer():Void
	{
		for(satellite in satellites)
		{
			satellite.disposeSatellite();
		}

		satellites = new Array<Satellite>();
	}
}