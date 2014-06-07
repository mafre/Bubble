package game;

import flash.display.Sprite;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import flash.geom.Point;

import haxe.ds.IntMap;
import haxe.Timer;

import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;

import utils.SoundHandler;
import common.StageInfo;
import common.GridSprite;
import common.Button;
import common.LabelButton;
import common.EventType;
import common.Image;
import game.emitter.*;
import game.satellite.*;
import game.entity.player.Player;
import game.menu.*;
import game.ContactListener;
import game.level.Level;
import game.entity.EntityType;
import game.entity.EntityHandler;
import game.entity.projectile.Orb1;
import game.score.ScoreHandler;
import game.GameEngine;
import game.GameProperties;
import utils.SWFHandler;

class Game extends Sprite
{
	static public inline var delay:Int = 25;

	private var menu:Menu;
	private var player:Player;
	private var timer:Timer;
	private var multiTouchSupported : Bool;
	private var World:B2World;
	private var PhysicsDebug:Sprite;
	private var contactListener:ContactListener;
	private var level:Level;

	public function new()
	{
		super ();

		StageInfo.addEventListener(EventType.STAGE_RESIZED, resize);
		
		multiTouchSupported = Multitouch.supportsTouchEvents;

		if (multiTouchSupported)
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		}

		World = new B2World (new B2Vec2 (0, 10.0), true);
		contactListener = new ContactListener();
		World.setContactListener(contactListener);
		World.setGravity(new B2Vec2(0, -5));
	
		EntityHandler.getInstance().world = World;
 	
 		PhysicsDebug = new Sprite();
		addChild(PhysicsDebug);
	 
		var debugDraw = new B2DebugDraw();
		debugDraw.setSprite(PhysicsDebug);
		debugDraw.setFlags(B2DebugDraw.e_shapeBit);
	 
		World.setDebugDraw(debugDraw);

		var score:ScoreHandler = ScoreHandler.getInstance();
	};

	public function init():Void
	{
		flash.Lib.current.addEventListener(Event.ACTIVATE, resume);
		flash.Lib.current.addEventListener(Event.DEACTIVATE, pause);

		level = new Level();
		addChild(level);
		level.init();

		menu = new Menu();
		addChild(menu);
		menu.init(this);
		menu.y = 20;

		resize();

		timer = new haxe.Timer(delay);
		timer.run = update;
	};

	private function pause(?e:Dynamic):Void
	{
		timer.stop();
	}

	private function resume(?e:Dynamic):Void
	{
		timer = new haxe.Timer(delay);
		timer.run = update;
	}

	public function reset(?e:Event):Void
	{
		level.reset();
	};

	public function resize(?e:Event):Void
	{	
		level.resize();
	};

	private function update():Void
	{
		level.update();
	};
}