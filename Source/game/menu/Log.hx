package game.menu;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.geom.Point;

import haxe.ds.StringMap;

import utils.TextfieldFactory;
import utils.SoundHandler;
import utils.TextfieldFactory;
import utils.PositionHelper;
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

class Log extends Sprite
{
	private var background:GridSprite;
	private var container:Sprite;
	private var closeButton:LabelButton;

	private var enemyItems:Array<EnemyItem>;

	public function new():Void
	{
		super();

		background = new GridSprite("images/background/bg1/", 200, 200, true);
		addChild(background);

		container = new Sprite();
		addChild(container);

		closeButton = new LabelButton("images/buttons/button1/", "Close");
		closeButton.addEventListener(EventType.BUTTON_PRESSED, closeSelected);
		container.addChild(closeButton);

		enemyItems = new Array<EnemyItem>();

		var angler:Angler = new Angler(0, 0);
		addEnemyItem(angler);

		var jellyfish:Jellyfish = new Jellyfish(0, 0);
		addEnemyItem(jellyfish);

		PositionHelper.alignTiled(enemyItems, new Point(closeButton.x + closeButton.width + 10, closeButton.y), 10, StageInfo.stageWidth - closeButton.x - closeButton.width - 10);

		EntityProperties.getInstance().dispatcher.addEventListener(EventType.NEW_ENEMY_ENCOUNTER, unlockEnemy);

		for (item in enemyItems)
		{
			if(EntityProperties.getInstance().hasEnemySpawned(item.id))
			{
				item.unlock();
			}
		}

		StageInfo.addEventListener(EventType.STAGE_RESIZED, resize);
		resize();
	};

	private function addEnemyItem(enemy:Enemy):Void
	{
		var item:EnemyItem = new EnemyItem(enemy);
		container.addChild(item);
		enemyItems.push(item);
	}

	private function unlockEnemy(e:DataEvent):Void
	{
		var enemy:Enemy = cast(e.data, Enemy);

		for (item in enemyItems)
		{
			if(item.id == enemy.id)
			{
				item.unlock();
			}
		}
	}

	public function closeSelected(e:Event):Void
	{
		this.visible = false;
	};

	public function resize(?e:Event):Void
	{	
		background.setSize(StageInfo.stageWidth, StageInfo.stageHeight);
		container.x = StageInfo.stageWidth/2 - container.width/2;
		container.y = StageInfo.stageHeight/2 - container.height/2;
	};
}

class EnemyItem extends Sprite
{
	public var id:String;
	private var index:Int;
	private var titleText:TextField;
	private var image:Image;
	private var unlocked:Bool;

	public function new(enemy:Enemy):Void
	{
		super();

		id = enemy.id;
		unlocked = false;

		titleText = TextfieldFactory.getDefault();
		titleText.text = enemy.id;
		addChild(titleText);

		image = new Image(enemy.path);
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