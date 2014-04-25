package game.menu;

import flash.display.Sprite;
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;
import flash.geom.Point;

import haxe.ds.StringMap;

import utils.TextfieldFactory;
import utils.SoundHandler;
import utils.TextfieldFactory;
import utils.PositionHelper;
import utils.SWFHandler;
import common.StageInfo;
import common.GridSprite;
import common.Button;
import common.LabelButton;
import common.ToggleButton;
import common.EventType;
import common.DataEvent;
import common.Image;
import common.Slider;
import game.entity.EntityProperties;
import game.entity.enemies.Enemy;
import game.entity.enemies.*;
import game.entity.Entity;
import game.entity.satellite.*;

class Log extends Sprite
{
	private var background:MovieClip;
	private var container:Sprite;
	private var closeButton:LabelButton;

	private var enemyIcons:Array<Icon>;
	private var satelliteIcons:Array<Icon>;

	public function new():Void
	{
		super();

		background = SWFHandler.getMovieclip("sky1");
		addChild(background);

		container = new Sprite();
		addChild(container);

		closeButton = new LabelButton("button1", "Close");
		closeButton.addEventListener(EventType.BUTTON_PRESSED, closeSelected);
		container.addChild(closeButton);

		enemyIcons = new Array<Icon>();
		satelliteIcons = new Array<Icon>();

		var angler:Angler = new Angler(0, 0);
		addEnemyIcon(angler);

		var jellyfish:Jellyfish = new Jellyfish(0, 0);
		addEnemyIcon(jellyfish);

		var narwhal:Narwhal = new Narwhal(0, 0);
		addEnemyIcon(narwhal);

		var seahorse:Seahorse = new Seahorse(0, 0);
		addSatelliteIcon(seahorse);

		var dolphin:Dolphin = new Dolphin(0, 0);
		addSatelliteIcon(dolphin);

		PositionHelper.alignTiled(enemyIcons, new Point(closeButton.x + closeButton.width + 10, closeButton.y), 10, StageInfo.stageWidth - closeButton.x - closeButton.width - 10);

		PositionHelper.alignTiled(satelliteIcons, new Point(closeButton.x + closeButton.width + 10, enemyIcons[enemyIcons.length-1].y + enemyIcons[enemyIcons.length-1].height + 20), 10, StageInfo.stageWidth - closeButton.x - closeButton.width - 10);

		EntityProperties.getInstance().dispatcher.addEventListener(EventType.NEW_ENEMY_ENCOUNTER, unlockEnemy);
		EntityProperties.getInstance().dispatcher.addEventListener(EventType.NEW_SATELLITE_ENCOUNTER, unlockSatellite);

		for (icon in enemyIcons)
		{
			if(EntityProperties.getInstance().hasEnemySpawned(icon.id))
			{
				icon.unlock();
			}
		}

		for (icon in satelliteIcons)
		{
			if(EntityProperties.getInstance().hasSatelliteSpawned(icon.id))
			{
				icon.unlock();
			}
		}

		StageInfo.addEventListener(EventType.STAGE_RESIZED, resize);
		resize();
	};

	private function addEnemyIcon(enemy:Enemy):Void
	{
		var icon:Icon = new Icon(enemy);
		container.addChild(icon);
		enemyIcons.push(icon);
	}

	private function unlockEnemy(e:DataEvent):Void
	{
		var enemy:Enemy = cast(e.data, Enemy);

		for (icon in enemyIcons)
		{
			if(icon.id == enemy.id)
			{
				icon.unlock();
			}
		}
	}

	private function unlockSatellite(e:DataEvent):Void
	{
		var satellite:Satellite = cast(e.data, Satellite);

		for (icon in satelliteIcons)
		{
			if(icon.id == satellite.id)
			{
				icon.unlock();
			}
		}
	}

	private function addSatelliteIcon(satellite:Satellite):Void
	{
		var icon:Icon = new Icon(satellite);
		container.addChild(icon);
		satelliteIcons.push(icon);
	}

	public function closeSelected(e:Event):Void
	{
		this.visible = false;
	};

	public function resize(?e:Event):Void
	{	
		background.width = StageInfo.stageWidth;
		background.height = StageInfo.stageHeight;
		container.x = StageInfo.stageWidth/2 - container.width/2;
		container.y = StageInfo.stageHeight/2 - container.height/2;
	};
}

class Icon extends Sprite
{
	public var id:String;
	private var index:Int;
	private var titleText:TextField;
	private var image:Image;
	private var unlocked:Bool;

	public function new(entity:Entity):Void
	{
		super();

		id = entity.id;
		unlocked = false;

		titleText = TextfieldFactory.getDefault();
		titleText.text = entity.id;
		addChild(titleText);

		image = new Image(entity.path);
		addChild(image);
		image.alpha = 0.5;

		var a:Array<Dynamic> = new Array<Dynamic>();
		a.push(titleText);
		a.push(image);

		PositionHelper.alignVertically(a, new Point(titleText.x, titleText.y), 10);
	};

	public function unlock():Void
	{
		unlocked = true;
		image.alpha = 1;
	}
}