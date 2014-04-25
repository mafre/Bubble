package;

import openfl.Assets;

import hscript.ScriptParser;

import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.events.Event;
import flash.events.MouseEvent;

import common.EventType;
import common.StageInfo;
import game.Game;
import game.GameProperties;
import game.entity.EntityProperties;
import game.GameEngine;
import game.sequence.SequenceProperties;
import game.entity.player.PlayerProperties;
import utils.SoundHandler;
import utils.SWFHandler;

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
		var swfHandler:SWFHandler = new SWFHandler();
		var entityProperties:EntityProperties = new EntityProperties();
		var gameProperties:GameProperties = new GameProperties();
		var gameEngine:GameEngine = new GameEngine();
		var sequenceProperties:SequenceProperties = new SequenceProperties();
		var scriptParser:ScriptParser = new ScriptParser();
		var playerProperties:PlayerProperties = new PlayerProperties();

		EntityProperties.getInstance().addEventListener(EventType.ENTITY_PROPERTIES_LOADED, entityPropertiesLoadedEvent);
		GameProperties.getInstance().addEventListener(EventType.GAME_PROPERTIES_LOADED, gamePropertiesLoadedEvent);

		EntityProperties.getInstance().load();
		GameProperties.getInstance().load();
		PlayerProperties.getInstance().load();
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
		var v1:Int = this.stage.stageWidth;
		var v2:Int = this.stage.stageHeight;

		if(v1 > v2)
		{
			StageInfo.resize(v1, v2);
		}
		else
		{
			StageInfo.resize(v2, v1);
		}
		
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