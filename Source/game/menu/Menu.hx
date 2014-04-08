package game.menu;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import game.menu.Settings;
import utils.TextfieldFactory;
import common.StageInfo;
import common.GridSprite;
import common.Button;
import common.LabelButton;
import common.ImageButton;
import common.EventType;
import common.Image;
import game.Game;
import game.emitter.*;
import game.entity.EntityType;
import game.entity.player.Player;
import game.score.ScoreHandler;
import game.entity.EntityProperties;
import game.sequence.SequenceHandler;
import game.GameProperties;

class Menu extends Sprite
{
	private var player:Player;
	private var game:Game;
	private var normalShotButton:LabelButton;
	private var burstShotButton:LabelButton;
	private var sineShotButton:LabelButton;
	private var multiShotButton:LabelButton;
	private var sprayShotButton:LabelButton;
	private var resetButton:LabelButton;
	private var settingsButton:ImageButton;
	private var propertiesButton:ImageButton;
	private var score:TextField;
	private var health:TextField;
	private var settings:Settings;

	public function new()
	{
		super();

		settingsButton = new ImageButton("images/buttons/image/settings2.png");
		settingsButton.addEventListener(EventType.BUTTON_PRESSED, settingsSelected);
		addChild(settingsButton);
		settingsButton.x = settingsButton.y = 10;

		propertiesButton = new ImageButton("images/buttons/image/reload.png");
		propertiesButton.addEventListener(EventType.BUTTON_PRESSED, loadProperties);
		addChild(propertiesButton);
		propertiesButton.x = settingsButton.x + settingsButton.width + 10;
		propertiesButton.y = 10;

		score = TextfieldFactory.getDefault();
		addChild(score);
		score.y = 10;
		score.x = propertiesButton.x + propertiesButton.width + 10;
		updateScore();

		health = TextfieldFactory.getDefault();
		addChild(health);
		health.x = score.x + score.width + 30;
		health.y = 10;
		updateHealth();

		settings = new Settings();
		addChild(settings);
		settings.visible = false;

		ScoreHandler.getInstance().addEventListener(EventType.UPDATE_SCORE, updateScore);
		ScoreHandler.getInstance().addEventListener(EventType.UPDATE_HEALTH, updateHealth);

		/*
		normalShotButton = new LabelButton("images/buttons/button1/", "Normal");
		normalShotButton.addEventListener(EventType.BUTTON_PRESSED, shotNormalSelected);
		addChild(normalShotButton);

		burstShotButton = new LabelButton("images/buttons/button1/", "Burst");
		burstShotButton.addEventListener(EventType.BUTTON_PRESSED, shotBurstSelected);
		addChild(burstShotButton);
		burstShotButton.x = normalShotButton.width + 10;

		sineShotButton = new LabelButton("images/buttons/button1/", "Sine");
		sineShotButton.addEventListener(EventType.BUTTON_PRESSED, shotSineSelected);
		addChild(sineShotButton);
		sineShotButton.x = burstShotButton.x + burstShotButton.width + 10;

		multiShotButton = new LabelButton("images/buttons/button1/", "Multi");
		multiShotButton.addEventListener(EventType.BUTTON_PRESSED, shotMultiSelected);
		addChild(multiShotButton);
		multiShotButton.x = sineShotButton.x + sineShotButton.width + 10;
		
		sprayShotButton = new LabelButton("images/buttons/button1/", "Spray");
		sprayShotButton.addEventListener(EventType.BUTTON_PRESSED, shotSpraySelected);
		addChild(sprayShotButton);
		sprayShotButton.x = multiShotButton.x + multiShotButton.width + 10;

		resetButton = new LabelButton("images/buttons/button1/", "Reset");
		resetButton.addEventListener(EventType.BUTTON_PRESSED, resetSelected);
		addChild(resetButton);
		resetButton.x = sprayShotButton.x + sprayShotButton.width + 10;
		*/
	};

	public function init(player:Player, game:Game):Void
	{
		this.player = player;
		this.game = game;
	}

	public function updateScore(?e:Event):Void
	{
		score.text = ScoreHandler.getInstance().score + " points";
	}

	public function updateHealth(?e:Event):Void
	{
		health.text = ScoreHandler.getInstance().health + " hp";
	}

	public function settingsSelected(e:Event):Void
	{
		settings.visible = true;
	};

	public function loadProperties(e:Event):Void
	{
		SequenceHandler.getInstance().reloadProperties();
		EntityProperties.getInstance().load();
		GameProperties.getInstance().load();
	};

	public function shotNormalSelected(e:Event):Void
	{
		//player.setEmitter(new Emitter(EntityType.PROJECTILE, container, items, "images/game/bubble", 2, 1, 15));
	};

	public function shotBurstSelected(e:Event):Void
	{
		//player.setEmitter(new BurstEmitter(EntityType.PROJECTILE, container, items, "images/game/bubble", 2, 60, 15));
	};

	public function shotSineSelected(e:Event):Void
	{
		//player.setEmitter(new SineEmitter(EntityType.PROJECTILE, container, items, "images/game/bubble", 2, 5, 10));
	};

	public function shotMultiSelected(e:Event):Void
	{
		//player.setEmitter(new MultiEmitter(EntityType.PROJECTILE, container, items, "images/game/bubble", 2, 5, 15));
	};

	public function shotSpraySelected(e:Event):Void
	{
		//player.setEmitter(new SprayEmitter(EntityType.PROJECTILE, container, items, "images/game/bubble", 2, 5, 15));
	};

	public function resetSelected(e:Event):Void
	{
		game.reset();
	};
}