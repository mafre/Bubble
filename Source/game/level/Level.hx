package game.level;

import flash.display.Sprite;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TouchEvent;

import haxe.ds.IntMap;

import hscript.Parser;
import hscript.Interp;

import common.StageInfo;
import common.GridSprite;
import common.Button;
import common.LabelButton;
import common.EventType;
import common.Image;
import game.Game;
import game.emitter.*;
import game.level.ILevel;
import game.sequence.Sequence;
import game.entity.satellite.*;
import game.entity.player.Player;
import game.entity.enemies.*;
import game.entity.background.*;
import game.entity.container.*;
import game.entity.boat.*;
import game.sequence.SequenceProperties;
import game.sequence.SequenceHandler;
import game.GameEngine;
import game.entity.EntityHandler;
import game.GameProperties;
import utils.SWFHandler;
import utils.SoundHandler;

class Level extends Sprite implements ILevel
{
	private var id:String;
	private var sky:MovieClip;
	private var water:MovieClip;
	private var sun:MovieClip;
	private var container:Sprite;
	private var player:Player;
	private var entityHandler:EntityHandler;
	private var touchStartX:Float;
	private var touchStartY:Float;
	private var playerStartX:Float;
	private var playerStartY:Float;
	private var dragging:Bool;

	public function new()
	{
		super();
		id = "world1";
	};

	public function init():Void
	{
		#if flash

			flash.Lib.current.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			flash.Lib.current.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			flash.Lib.current.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);

		#end
		
		#if !flash

			flash.Lib.current.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchStageBegin);
			flash.Lib.current.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			flash.Lib.current.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);

		#end

		SoundHandler.playMusic(id, true);

		SequenceHandler.getInstance().load(id);

		sky = SWFHandler.getMovieclip(id+"sky");
		sky.alpha = 0.3;
		addChild(sky);

		container = new Sprite();
		addChild(container);

		water = SWFHandler.getMovieclip(id+"water");
		container.addChild(water);
		water.y = GameProperties.worldTop;

		sun = SWFHandler.getMovieclip(id+"sun");
		container.addChild(sun);

		entityHandler = EntityHandler.getInstance();
		entityHandler.setContainer(container);

		GameEngine.getInstance().setContainer(container);

		player = new Player(0, 0);
		entityHandler.addEntity(player);

		GameProperties.playerWidht = player.width;
		GameProperties.playerHeight = player.height;
	}

	#if flash

		private function onMouseDown(e:MouseEvent):Void
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

		private function onMouseMove(e:MouseEvent):Void
		{
			var yPos:Float = (GameProperties.worldBottom) * (e.stageY / StageInfo.stageHeight);
			player.dragToPosition(e.stageX, yPos);
		};

		private function onMouseUp(e:MouseEvent):Void
		{
			dragging = false;
		};

	#end
	
	#if !flash

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

	#end

	public function reset(?e:Event):Void
	{
		player.setPosition(StageInfo.stageWidth/2-player.width/2, StageInfo.stageHeight/2-player.height/2);
		player.disposePlayer();
	};

	public function resize(?e:Event):Void
	{	
		sky.width = StageInfo.stageWidth;
		sky.height = GameProperties.worldBottom;
		water.width = StageInfo.stageWidth;
		water.height = GameProperties.worldBottom-GameProperties.worldTop;
		sun.x = StageInfo.stageWidth - sun.width - 50;
		sun.y = -GameProperties.worldTop + 10;
		reset();
	};

	public function update():Void
	{
		GameEngine.getInstance().update();
	}

	public function exit():Void
	{
		
	}
}