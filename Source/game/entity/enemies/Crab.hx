package game.entity.enemies.crab;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.geom.Point;
import flash.text.TextField;

import common.Image;
import common.EventType;
import game.emitter.*;
import game.addon.Addon;
import utils.SoundHandler;
import utils.TextfieldFactory;
import common.StageInfo;

import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.common.math.B2Mat22;
import box2D.common.math.B2Transform;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;

class Crab extends Sprite
{
	private var image:Image;
	private var emitPoint:Point;
	private var emitter:Emitter;

	private var bodyDefinition:B2BodyDef;
	private var body:B2Body;
	private var collided:Bool;
	private var b2t:B2Transform;

	private var health:Int;
	private var healthTF:TextField;

	public function new()
	{
		super();

		image = new Image("images/game/crab.png");
		addChild(image);
		image.center();

		health = 2000;

		healthTF = TextfieldFactory.getDefault();
		addChild(healthTF);
		healthTF.text = "hp: "+health;

		emitPoint = new Point(0, 70);
	}

	public function addedToStage():Void
	{
		bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * StageInfo.stageRatio, y * StageInfo.stageRatio);
		
		bodyDefinition.type = B2Body.b2_staticBody;
		
		var circle = new B2CircleShape(100);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = circle;
		
		body = StageInfo.world.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		body.setUserData(this);
	}

	public function takeDamage():Void
	{
		health--;
		healthTF.text = "hp: "+health;

		if(health == 0)
		{
			dispose();
		}
	}

	public function getEmitPoint():Point
	{
		return this.localToGlobal(emitPoint);
	}

	public function setEmitter(emitter:Emitter):Void
	{
		this.emitter = emitter;
	}

	public function update():Void
	{
		//emitter.update(getEmitPoint().x, getEmitPoint().y, getAngleToTarget(this));
	}

	public function dispose():Void
	{
		if(this.parent != null)
		{
			this.parent.removeChild(this);
		}

		StageInfo.world.destroyBody(body);
	}
}