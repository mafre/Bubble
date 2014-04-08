package game;

import flash.display.Sprite;
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
import game.entity.projectile.Bubble;
import game.score.ScoreHandler;

class Game extends Sprite
{
	static public inline var delay:Int = 20;

	private var sky:GridSprite;
	private var background:GridSprite;
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

		background = new GridSprite("images/background/bg1/", 200, 200, true);
		addChild(background);

		sky = new GridSprite("images/background/bg1/", 200, 200, true);
		sky.alpha = 0.3;
		addChild(sky);

		container = new Sprite();
		addChild(container);

		pickups = new Array<Sprite>();
		add = new Array<Sprite>();

		StageInfo.addEventListener(EventType.STAGE_RESIZED, resize);
		StageInfo.addEventListener(EventType.STAGE_INITIALIZED, stageInitialized);

		touches = new IntMap<Sprite>();
		
		multiTouchSupported = Multitouch.supportsTouchEvents;

		if (multiTouchSupported)
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		}

		World = new B2World (new B2Vec2 (0, 10.0), true);
		contactListener = new ContactListener();
		World.setContactListener(contactListener);
		World.setGravity(new B2Vec2(0, 0));
 	
 		PhysicsDebug = new Sprite();
		addChild(PhysicsDebug);
	 
		var debugDraw = new B2DebugDraw();
		debugDraw.setSprite(PhysicsDebug);
		debugDraw.setFlags(B2DebugDraw.e_shapeBit);
	 
		World.setDebugDraw(debugDraw);

		entityHandler = EntityHandler.getInstance();
		entityHandler.world = World;
		entityHandler.setContainer(container);

		var score:ScoreHandler = ScoreHandler.getInstance();

		player = new Player(0, 0);
		player.setEmitter(new Emitter(Bubble, 10, 15));
		entityHandler.addEntity(player);
		entityHandler.player = player;
	};

	public function init():Void
	{
		player.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchPlayerBegin);
		stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchStageBegin);
		stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		stage.addEventListener(Event.ACTIVATE, resume);
		stage.addEventListener(Event.DEACTIVATE, pause);
	};

	private function stageInitialized(e:Event):Void
	{
		level = new Level();
		level.init(player, this);

		timer = new haxe.Timer(delay);
		timer.run = update;

		menu = new Menu();
		addChild(menu);
		menu.init(player, this);
		menu.y = 20;
	}

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
		if(!touches.exists(e.touchPointID))
		{
			//trace(e.relatedObject);
		}

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

	private function onTouchPlayerBegin(e:TouchEvent):Void 
	{
		//touches.set(e.touchPointID, player);
	};

	private function onTouchMove(e:TouchEvent):Void 
	{
		player.x = playerStartX + (e.stageX-touchStartX);
		player.y = playerStartY + (e.stageY-touchStartY);

		return;
		if(touches.exists(e.touchPointID))
		{
			var touchSprite : Sprite = touches.get(e.touchPointID);

			if(touchSprite == player)
			{
				player.dragToPosition(e.stageX, e.stageY);
			}
		}
	};
	
	private function onTouchEnd(e:TouchEvent):Void 
	{	
		dragging = false;
		return;

		if(touches.exists(e.touchPointID))
		{
			var touchSprite : Sprite = touches.get(e.touchPointID);
			touches.remove(e.touchPointID);
		}
	};

	public function reset(?e:Event):Void
	{
		player.setPosition(StageInfo.stageWidth/2-player.width/2, StageInfo.stageHeight*0.7-player.height/2);
		player.disposePlayer();
	};

	public function resize(e:Event):Void
	{	
		sky.setSize(StageInfo.stageWidth, StageInfo.stageHeight*0.1);
		background.setSize(StageInfo.stageWidth, StageInfo.stageHeight*0.9);
		background.y = StageInfo.stageHeight*0.1;
		reset();
	};

	private function update():Void
	{
		level.update();
		entityHandler.update();
	};
}