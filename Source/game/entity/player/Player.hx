package game.entity.player;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.geom.Point;

import common.Image;
import common.EventType;
import utils.SoundHandler;
import game.entity.EntityHandler;
import game.entity.Entity;
import game.entity.satellite.Satellite;
import game.emitter.*;
import game.score.ScoreHandler;
import common.StageInfo;

class Player extends Entity
{
	private var health:Int;
	private var emitPosition:Point;
	private var satellitePositions:Array<Point>;
	private var emitter:Emitter;
	private var satellites:Array<Satellite>;

	public function new(xSpeed:Float, ySpeed:Float):Void
	{
		super(xSpeed, ySpeed);

		health = 100;

		type = EmitterType.PLAYER;
		layer = 8;

		mouseEnabled = true;

		satellites = new Array<Satellite>();
		emitPosition = new Point(50, 0);

		satellitePositions = new Array<Point>();
		satellitePositions.push(new Point(0, 80));
		satellitePositions.push(new Point(0, -80));
		satellitePositions.push(new Point(0, 120));
		satellitePositions.push(new Point(0, -120));
		satellitePositions.push(new Point(-50, 100));
		satellitePositions.push(new Point(-50, -100));
	}

	private override function addImage():Void
	{
		image = new Image("images/game/player/player.png");
		addChild(image);
		image.center();
	}

	public override function handleCollision(entity:Entity):Void
	{
		switch (entity.type)
		{
			case EmitterType.ENEMY:
				takeDamage();

			case EmitterType.SATELLITE:
				var satellite:Satellite = cast(entity, Satellite);
                addSatellite(satellite);
		}
	}

	public function takeDamage():Void
	{
		health--;
		ScoreHandler.getInstance().setHealth(health);

		if(health <= 0)
		{
			//dispose = true;
		}
	}

	public function addSatellite(aSatellite:Satellite):Void
	{
		aSatellite.dispose = true;
		var satellite:Dynamic = aSatellite.duplicate();
		satellite.addToItems = false;
		satellite.addBody = false;
		satellite.setState(Satellite.State_Added);
		EntityHandler.getInstance().addEntity(satellite);
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
		this.x = xPos;
		this.y = yPos;
	}

	public override function update():Void
	{
		emitter.update(getEmitPosition().x, getEmitPosition().y, 0);

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