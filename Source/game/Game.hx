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

	private var sky:MovieClip;
	private var water:MovieClip;
	private var sun:MovieClip;
	private var container:Sprite;
	private var menu:Menu;
	private var player:Player;
	private var timer:Timer;
	private var multiTouchSupported : Bool;
	private var touches : IntMap<Sprite>;
	private var pickups:Array<Sprite>;
	private var add:Array<Sprite>;
	private var World:B2World;
	private var PhysicsDebug:Sprite;
	private var contactListener:ContactListener;
	private var entityHandler:EntityHandler;
	private var touchStartX:Float;
	private var touchStartY:Float;
	private var playerStartX:Float;
	private var playerStartY:Float;
	private var dragging:Bool;
	private var level:Level;

	public function new()
	{
		super ();

		SoundHandler.playMusic("lake", true);

		sky = SWFHandler.getMovieclip("sky1");
		sky.alpha = 0.3;
		addChild(sky);

		container = new Sprite();
		addChild(container);

		water = SWFHandler.getMovieclip("water1");
		container.addChild(water);
		water.y = GameProperties.worldTop;

		sun = SWFHandler.getMovieclip("sun1");
		container.addChild(sun);

		pickups = new Array<Sprite>();
		add = new Array<Sprite>();

		StageInfo.addEventListener(EventType.STAGE_RESIZED, resize);

		touches = new IntMap<Sprite>();
		
		multiTouchSupported = Multitouch.supportsTouchEvents;

		if (multiTouchSupported)
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		}

		World = new B2World (new B2Vec2 (0, 10.0), true);
		contactListener = new ContactListener();
		World.setContactListener(contactListener);
		World.setGravity(new B2Vec2(0, -5));
 	
 		PhysicsDebug = new Sprite();
		addChild(PhysicsDebug);
	 
		var debugDraw = new B2DebugDraw();
		debugDraw.setSprite(PhysicsDebug);
		debugDraw.setFlags(B2DebugDraw.e_shapeBit);
	 
		World.setDebugDraw(debugDraw);

		entityHandler = EntityHandler.getInstance();
		entityHandler.world = World;
		entityHandler.setContainer(container);

		GameEngine.getInstance().setContainer(container);

		var score:ScoreHandler = ScoreHandler.getInstance();

		player = new Player(0, 0);
		entityHandler.addEntity(player);

		GameProperties.playerWidht = player.width;
		GameProperties.playerHeight = player.height;

		resize();
	};

	public function init():Void
	{
		flash.Lib.current.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchStageBegin);
		flash.Lib.current.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		flash.Lib.current.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		flash.Lib.current.addEventListener(Event.ACTIVATE, resume);
		flash.Lib.current.addEventListener(Event.DEACTIVATE, pause);

		level = new Level();
		level.init(player, this);

		timer = new haxe.Timer(delay);
		timer.run = update;

		menu = new Menu();
		addChild(menu);
		menu.init(player, this);
		menu.y = 20;
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

	private function onTouchStageBegin(e:TouchEvent):Void 
	{
		if(dragging)
		{
			return;
		}

		touchStartX = e.stageX;
		touchStartY = e.stageY;
		playerStartX = player.x;
		playerStartY = player.y;
		dragging = true;
	};

	private function onTouchMove(e:TouchEvent):Void 
	{
		player.dragToPosition(playerStartX + (e.stageX-touchStartX), playerStartY + (e.stageY-touchStartY));
	};
	
	private function onTouchEnd(e:TouchEvent):Void 
	{	
		dragging = false;
	};

	public function reset(?e:Event):Void
	{
		player.setPosition(StageInfo.stageWidth/2-player.width/2, StageInfo.stageHeight/2-player.height/2);
		player.disposePlayer();
	};

	public function resize(?e:Event):Void
	{	
		sky.width = StageInfo.stageWidth;
		sky.height = StageInfo.stageHeight;
		water.width = StageInfo.stageWidth;
		water.height = StageInfo.stageHeight-GameProperties.worldTop;
		sun.x = StageInfo.stageWidth - sun.width - 50;
		sun.y = -GameProperties.worldTop + 10;
		reset();
	};

	private function update():Void
	{
		level.update();
	};
}