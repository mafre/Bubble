package game.menu;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.geom.Point;

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
import common.Image;
import common.Slider;
import game.entity.player.PlayerProperties;

class Stats extends Sprite
{
	private var background:GridSprite;
	private var container:Sprite;
	private var closeButton:LabelButton;
	private var selectors:Array<StatsSelector>;
	private var speedModSelector:StatsSelector;
	private var fireRateSelector:StatsSelector;
	private var fireSpeedSelector:StatsSelector;
	private var damageSelector:StatsSelector;
	private var healthSelector:StatsSelector;

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

		selectors = new Array<StatsSelector>();

		speedModSelector = new StatsSelector("Speed", PlayerProperties.getInstance().speedModList, PlayerProperties.getInstance().cost);
		speedModSelector.addEventListener(EventType.BUTTON_RELEASED, updateStats);
		selectors.push(speedModSelector);
		container.addChild(speedModSelector);

		fireRateSelector = new StatsSelector("Fire rate", PlayerProperties.getInstance().fireRateList, PlayerProperties.getInstance().cost);
		fireRateSelector.addEventListener(EventType.BUTTON_RELEASED, updateStats);
		selectors.push(fireRateSelector);
		container.addChild(fireRateSelector);

		fireSpeedSelector = new StatsSelector("Fire speed", PlayerProperties.getInstance().fireSpeedList, PlayerProperties.getInstance().cost);
		fireSpeedSelector.addEventListener(EventType.BUTTON_RELEASED, updateStats);
		selectors.push(fireSpeedSelector);
		container.addChild(fireSpeedSelector);

		damageSelector = new StatsSelector("Damage", PlayerProperties.getInstance().damageList, PlayerProperties.getInstance().cost);
		damageSelector.addEventListener(EventType.BUTTON_RELEASED, updateStats);
		selectors.push(damageSelector);
		container.addChild(damageSelector);

		healthSelector = new StatsSelector("Health", PlayerProperties.getInstance().healthList, PlayerProperties.getInstance().cost);
		healthSelector.addEventListener(EventType.BUTTON_RELEASED, updateStats);
		selectors.push(healthSelector);
		container.addChild(healthSelector);

		PositionHelper.alignHorizontally(selectors, new Point((closeButton.x + closeButton.width + 10), closeButton.y), 10);

		StageInfo.addEventListener(EventType.STAGE_RESIZED, resize);
		resize();
	};

	public function updateStats(e:Event):Void
	{
		PlayerProperties.getInstance().speedModIndex = speedModSelector.getIndex();
		PlayerProperties.getInstance().fireRateIndex = fireRateSelector.getIndex();
		PlayerProperties.getInstance().fireSpeedIndex = fireSpeedSelector.getIndex();
		PlayerProperties.getInstance().damageIndex = damageSelector.getIndex();
		PlayerProperties.getInstance().healthIndex = healthSelector.getIndex();
		PlayerProperties.getInstance().updateProperties();
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

class StatsSelector extends Sprite
{
	private var index:Int;
	private var costs:Array<Int>;
	private var values:Array<Float>;
	private var selectedValue:Float;
	private var buttons:Array<LabelButton>;
	private var titleText:TextField;

	public function new(title:String, values:Array<Float>, costs:Array<Int>):Void
	{
		super();

		this.values = values;
		this.costs = costs;

		titleText = TextfieldFactory.getDefault();
		titleText.text = title;
		addChild(titleText);

		buttons = new Array<LabelButton>();

		for (i in 0...values.length)
		{
			var lvl:Int = i+1;
			var btn:LabelButton = new LabelButton("images/buttons/button1/", "Level " + lvl);
			btn.index = i;
			btn.addEventListener(EventType.BUTTON_PRESSED, buttonSelected);
			addChild(btn);
			buttons.push(btn);
		}

		PositionHelper.alignVertically(buttons, new Point(titleText.x, (titleText.y + titleText.height + 10)), 10);
	};

	public function buttonSelected(e:Event):Void
	{
		setIndex(e.target.index);
		dispatchEvent(new Event(EventType.BUTTON_RELEASED));
	}

	public function setIndex(aIndex:Int):Void
	{
		this.index = aIndex;
		selectedValue = values[index];
	}

	public function getIndex():Int
	{
		return index;
	}

	public function getSelectedValue():Float
	{
		return selectedValue;
	}
}