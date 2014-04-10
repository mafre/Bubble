package game.level;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

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

class Level implements ILevel
{
	private var player:Player;
	private var game:Game;

	public function new()
	{

	};

	public function init(player:Player, game:Game):Void
	{
		this.player = player;
		this.game = game;
		SequenceHandler.getInstance().load("world1");
	}

	public function update():Void
	{
		GameEngine.getInstance().update();
	}

	public function exit():Void
	{
		
	}
}