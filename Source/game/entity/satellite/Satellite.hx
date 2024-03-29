package game.entity.satellite;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.geom.Point;

import common.Image;
import common.EventType;
import common.StageInfo;
import game.emitter.*;
import utils.SoundHandler;
import game.entity.EntityType;
import game.entity.satellite.Satellite;
import game.entity.projectile.Orb1;
import game.entity.player.Player;
import game.GameProperties;
import utils.SWFHandler;

class Satellite extends Entity
{
	static public inline var State_Idle:String				= "State.Idle";
	static public inline var State_Added:String				= "State.Added";
	static public inline var State_Exit:String				= "State.Exit";

	private var emitPosition:Point;
	private var emitter:Emitter;
	public var duration:Int;
	public var state:String;

	private var exitDirection:Int;

	public function new(id:String, xSpeed:Float, ySpeed:Float):Void
	{
		super(id, xSpeed, ySpeed);
		state = State_Idle;

		type = EntityType.SATELLITE;
		layer = 7;
		duration = 50;

		emitPosition = new Point(0, -15);
		setEmitter();
	};

	private function setEmitter():Void
	{
		emitter = new Emitter(Orb1, 5, 15);
	}

	public function getEmitPosition():Point
	{
		return this.localToGlobal(emitPosition);
	};

	public function disposeSatellite():Void
	{
		dispose = true;
	}

	public function setState(aState:String):Void
	{
		state = aState;

		switch (state)
		{
			case State_Exit:
				mc.parent.removeChild(mc);
				/*
				image = new Image(getPath(), true);
				addChild(image);
				this.rotation = 0;
				image.center();
				*/
		}
	}

	public override function update():Void
	{
		switch (state)
		{
			case State_Idle:
				super.update();

			case State_Added:


			case State_Exit:
				setXPosition(-6);

				super.checkBoundaries();
		}
	}

	public function updateEmitter(angle:Float, satellitePosition:Point):Void
	{
		if(emitter.update(getEmitPosition().x, getEmitPosition().y - GameProperties.cameraYOffset, angle))
		{
			duration--;
		}

		this.x += 0.08*(satellitePosition.x - this.x);
		this.y += 0.08*(satellitePosition.y - this.y - GameProperties.cameraYOffset);
	}

	public function duplicate():Satellite
	{
		var satellite:Satellite = new Satellite(id, xSpeed, ySpeed);
		satellite.x = this.x;
		satellite.y = this.y;
		satellite.rotation = this.rotation;
		return satellite;
	}
}