package;

import openfl.Assets;

import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.events.Event;
import flash.events.MouseEvent;
import utils.SoundHandler;

import common.EventType;
import game.Game;
import game.GameProperties;
import common.StageInfo;
import game.entity.EntityProperties;
import game.GameEngine;
import game.sequence.SequenceProperties;
import hscript.ScriptParser;

@:font("F.ttf") class DefaultFont extends Font {}
@:font("OpenSans-Regular.ttf") class OpenSansFont extends Font {}

class Main extends Sprite
{
	private var game:Game;

	private var stageResized:Bool;
	private var entityPropertiesLoaded:Bool;
	private var gamePropertiesLoaded:Bool;

	public function new()
	{
		super ();

		stageResized = false;
		entityPropertiesLoaded = false;
		gamePropertiesLoaded = false;

		Font.registerFont(OpenSansFont);

		var soundHandler:SoundHandler = new SoundHandler();
		var entityProperties:EntityProperties = new EntityProperties();
		var gameProperties:GameProperties = new GameProperties();
		var gameEngine:GameEngine = new GameEngine();
		var sequenceProperties:SequenceProperties = new SequenceProperties();
		var scriptParser:ScriptParser = new ScriptParser();

		EntityProperties.getInstance().addEventListener(EventType.ENTITY_PROPERTIES_LOADED, entityPropertiesLoadedEvent);
		GameProperties.getInstance().addEventListener(EventType.GAME_PROPERTIES_LOADED, gamePropertiesLoadedEvent);

		EntityProperties.getInstance().load();
		GameProperties.getInstance().load();
		stageResize();
	};

	private function entityPropertiesLoadedEvent(event:Event):Void
	{
		EntityProperties.getInstance().removeEventListener(EventType.ENTITY_PROPERTIES_LOADED, entityPropertiesLoadedEvent);
		entityPropertiesLoaded = true;
		checkLoaded();
	};

	private function gamePropertiesLoadedEvent(event:Event):Void
	{
		GameProperties.getInstance().removeEventListener(EventType.GAME_PROPERTIES_LOADED, gamePropertiesLoadedEvent);
		gamePropertiesLoaded = true;
		ScriptParser.getInstance().gamePropertiesLoaded();
		checkLoaded();
	};

	private function stageResize(event:Event = null):Void
	{
		StageInfo.resize(this.stage.stageWidth, this.stage.stageHeight);
		stageResized = true;
		checkLoaded();
	};

	private function checkLoaded():Void
	{
		if(stageResized && gamePropertiesLoaded && entityPropertiesLoaded)
		{
			game = new Game();
	    	addChild(game);
	    	game.init();
		}
	}
}