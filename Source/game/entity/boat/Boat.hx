package game.entity.boat;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import common.Image;
import flash.geom.Point;

import game.entity.Entity;
import game.GameProperties;
import game.emitter.*;
import common.EventType;
import common.StageInfo;
import game.entity.projectile.Bubble;

class Boat extends Entity
{
	static public inline var State_Default:String				= "State.Default";

	private var state:String;
	private var emitPosition:Point;
	private var emitter:Emitter;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super(xSpeed, ySpeed);
		type = EntityType.BOAT;
		layer = 4;
		addBody = false;
		state = State_Default;
		emitPosition = new Point(40, 0);
		setEmitter();
		EntityProperties.getInstance().addEventListener(EventType.ENTITY_PROPERTIES_LOADED, reloadEmitter);
	};

	private function reloadEmitter(e:Event):Void
	{
		setEmitter();
	}

	private function getPath():String
	{
		return "";
	}

	private override function addImage():Void
	{
		image = new Image(getPath());
		addChild(image);
	}

	public function setState(aState:String):Void
	{
		state = aState;
	}

	private function setEmitter():Void
	{
		emitter = new Emitter(Bubble, 5, 5);
	}

	public function getEmitPosition():Point
	{
		return this.localToGlobal(emitPosition);
	};

	private function getAngle():Float
	{
		var g:Float = 0.98;
		var dx:Float = -Math.abs(GameProperties.playerX - getEmitPosition().x);
		var dy:Float = GameProperties.playerY - getEmitPosition().y-GameProperties.cameraYOffset;
		var v1:Float = Math.pow(emitter.speedMod, 2);
		var v2:Float = Math.pow(emitter.speedMod, 4);
		var v3:Float = g*Math.pow(dx, 2);
		var v4:Float = 2*dy*Math.pow(emitter.speedMod, 2);
		var v5:Float = g*dx;
		var s1:Float = g * ( v3 + v4 );
		var s2:Float = v2 - s1;
		var s3:Float = Math.sqrt(Math.abs(s2));

		var a:Float = Math.atan((v1 + s3)/v5);
		if((GameProperties.playerX - getEmitPosition().x) <= 0)
		{
			a = Math.PI - a;
		}

		return a;
	}

	public override function update():Void
	{
		super.update();
		emitter.update(getEmitPosition().x, getEmitPosition().y-GameProperties.cameraYOffset, getAngle());
	}
}