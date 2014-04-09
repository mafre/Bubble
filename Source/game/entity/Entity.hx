package game.entity;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;

import common.Image;
import common.EventType;
import common.StageInfo;
import game.GameProperties;
import game.entity.EntityHandler;
import game.entity.EntityProperties;
import utils.SoundHandler;
import flash.geom.Point;

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

class Entity extends Sprite
{
	private var image:Image;
	public var xSpeed:Float;
	public var ySpeed:Float;
	private var path:String;
	public var layer:Int;
	public var offsetY:Float;

	private var bodyDefinition:B2BodyDef;
	public var body:B2Body;
	private var b2t:B2Transform;

	private var maskBits:Int;
	private var categoryBits:Int;
	private var groupIndex:Int;

	public var type:String;
	public var count:Int;

	public var dispose:Bool;

	public var addBody:Bool;
	public var addToItems:Bool;
	public var addToStage:Bool;

	public function new(xSpeed:Float, ySpeed:Float)
	{
		super();

		dispose = false;

		addBody = true;
		addToItems = true;
		addToStage = true;

		layer = 9;

		maskBits = -1;
		categoryBits = -1;
		groupIndex = -1;

		count = 0;
		dispose = false;

		this.xSpeed = xSpeed;
		this.ySpeed = ySpeed;

		mouseEnabled = false;
		mouseChildren = false;

		offsetY = 0;

		addImage();
	};

	private function addImage():Void
	{

	}

	public function handleCollision(entity:Entity):Void
	{

	}

	public function addedToStage():Void
	{
		bodyDefinition = new B2BodyDef();
		bodyDefinition.position.set(this.x, this.y);
		bodyDefinition.type = B2Body.b2_dynamicBody;

		var polygon = new B2PolygonShape();
		polygon.setAsBox((image.width / 2), (image.height / 2));
		
		var fixtureDefinition = new B2FixtureDef();
		fixtureDefinition.shape = polygon;

		if(maskBits != -1)
		{
			fixtureDefinition.filter.maskBits = maskBits;
		}
		
		if(categoryBits != -1)
		{
			fixtureDefinition.filter.categoryBits = categoryBits;
		}

		if(groupIndex != -1)
		{
			fixtureDefinition.filter.groupIndex = 1;
		}
		
		body = EntityHandler.getInstance().world.createBody(bodyDefinition);
		body.createFixture(fixtureDefinition);
		body.setUserData(this);
	}

	public function updateBody():Void
	{
		if(addBody)
		{
			b2t = new B2Transform(new B2Vec2(this.x, (this.y + GameProperties.cameraYOffset)), new B2Mat22());
			body.setTransform(b2t);
		}
	}

	public function updateImage():Void
	{
		if(addToStage)
		{
			setPosition(xSpeed, ySpeed);
			checkBoundaries();
		}
	}

	public function checkBoundaries():Bool
	{
		if(this.x < -image.width || this.y < -image.height || this.y > GameProperties.height)
		{
			dispose = true;
		}

		return dispose;
	}

	public function setPosition(xPos:Float, yPos:Float):Void
	{
		setXPosition(xPos);
		setYPosition(yPos);
	}

	public function setXPosition(xPos:Float):Void
	{
		this.x += xPos - GameProperties.globalSpeed;
	}

	public function setYPosition(yPos:Float):Void
	{
		this.y += yPos;
	}

	public function update():Void
	{
		updateImage();
		updateBody();
	}
}