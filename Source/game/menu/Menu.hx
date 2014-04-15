package game.menu;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import game.menu.Settings;
import game.menu.Stats;
import game.menu.Log;
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
import game.entity.player.PlayerProperties;

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
	private var statsButton:ImageButton;
	private var logButton:ImageButton;
	private var score:TextField;
	private var health:TextField;
	private var distance:TextField;
	private var multiplier:TextField;
	private var stars:TextField;
	private var settings:Settings;
	private var stats:Stats;
	private var log:Log;

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

		statsButton = new ImageButton("images/buttons/image/settings2.png");
		statsButton.addEventListener(EventType.BUTTON_PRESSED, statsSelected);
		addChild(statsButton);
		statsButton.x = propertiesButton.x + propertiesButton.width + 10;
		statsButton.y = 10;

		logButton = new ImageButton("images/buttons/image/settings2.png");
		logButton.addEventListener(EventType.BUTTON_PRESSED, logSelected);
		addChild(logButton);
		logButton.x = statsButton.x + statsButton.width + 10;
		logButton.y = 10;

		score = TextfieldFactory.getDefault();
		addChild(score);
		score.y = 10;
		score.x = logButton.x + logButton.width + 10;
		updateScore();

		health = TextfieldFactory.getDefault();
		addChild(health);
		health.x = score.x + score.width + 60;
		health.y = 10;
		updateHealth();

		distance = TextfieldFactory.getDefault();
		addChild(distance);
		distance.y = 10;
		distance.x = StageInfo.stageWidth - 120;
		updateDistance();

		multiplier = TextfieldFactory.getDefault();
		addChild(multiplier);
		multiplier.y = distance.y + distance.height + 10;
		multiplier.x = StageInfo.stageWidth - 120;
		updateMultiplier();

		stars = TextfieldFactory.getDefault();
		addChild(stars);
		stars.y = distance.y + distance.height + 10;
		stars.x = StageInfo.stageWidth - 200;
		updatePlayerProperties();

		settings = new Settings();
		addChild(settings);
		settings.visible = false;

		stats = new Stats();
		addChild(stats);
		stats.visible = false;

		log = new Log();
		addChild(log);
		log.visible = false;

		ScoreHandler.getInstance().addEventListener(EventType.UPDATE_SCORE, updateScore);
		ScoreHandler.getInstance().addEventListener(EventType.UPDATE_HEALTH, updateHealth);
		GameProperties.getInstance().dispatcher.addEventListener(EventType.UPDATE_DISTANCE, updateDistance);
		GameProperties.getInstance().dispatcher.addEventListener(EventType.UPDATE_MULTIPLIER, updateMultiplier);
		PlayerProperties.getInstance().dispatcher.addEventListener(EventType.PLAYER_PROPERTIES_LOADED, updatePlayerProperties);
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

	public function updateDistance(?e:Event):Void
	{
		distance.text = Std.string(GameProperties.distanceTravelled);
	}

	public function updateMultiplier(?e:Event):Void
	{
		multiplier.text = Std.string(GameProperties.multiplier);
	}

	public function updatePlayerProperties(?e:Event):Void
	{
		stars.text = Std.string(PlayerProperties.stars);
	}

	public function settingsSelected(e:Event):Void
	{
		settings.visible = true;
	};

	public function statsSelected(e:Event):Void
	{
		stats.visible = true;
	};

	public function logSelected(e:Event):Void
	{
		log.visible = true;
	};

	public function loadProperties(e:Event):Void
	{
		SequenceHandler.getInstance().reloadProperties();
		EntityProperties.getInstance().load();
		GameProperties.getInstance().load();
		PlayerProperties.getInstance().load();
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