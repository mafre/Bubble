package game.level;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import haxe.ds.IntMap;

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
import game.entity.other.*;
import game.entity.boat.*;

class Level implements ILevel
{
	private var player:Player;
	private var game:Game;
	private var queuedSequences:IntMap<Sequence>;
	private var activeSequences:Array<Sequence>;
	private var time:Int;

	public function new()
	{
		queuedSequences = new IntMap<Sequence>();
		activeSequences = new Array<Sequence>();
		time = 0;
	};

	public function init(player:Player, game:Game):Void
	{
		this.player = player;
		this.game = game;

		var sequence:Sequence = new Sequence(50, 50, StageInfo.stageWidth, StageInfo.stageHeight-200, Math.PI+0.3);
		sequence.initEmitter(new Emitter(Jellyfish, 20, 5));
		queuedSequences.set(sequence.time, sequence);

		/*
		var sequence2:Sequence = new Sequence(400, 50, StageInfo.stageWidth, 100, Math.PI-0.2);
		sequence2.initEmitter(new Emitter(Jellyfish, 30, 5));
		queuedSequences.set(sequence2.time, sequence2);
	
		*/
		var angler:Sequence = new Sequence(1000, 100, StageInfo.stageWidth, 300, Math.PI);
		angler.initEmitter(new Emitter(Angler, 50, 4));
		queuedSequences.set(angler.time, angler);

		var sand:Sequence = new Sequence(1, 1000, StageInfo.stageWidth, StageInfo.stageHeight-50, Math.PI);
		sand.initEmitter(new Emitter(Sand2, 12, 3));
		queuedSequences.set(sand.time, sand);

		var other:Sequence = new Sequence(7, 5, StageInfo.stageWidth, StageInfo.stageHeight-25, Math.PI);
		other.initEmitter(new RandomEmitter(
			[Anchor],
			function():Int{return Math.floor(Math.random()*1000+1000);},
			function():Int{return Math.floor(Math.random()*20);},
			3,
			true)
		);
		queuedSequences.set(other.time, other);

		var treasure:Sequence = new Sequence(6, 30, StageInfo.stageWidth, StageInfo.stageHeight-25, Math.PI);
		treasure.initEmitter(new RandomEmitter(
			[Shoe, TreasureChest, Safe],
			function():Int{return Math.floor(Math.random()*200+200);},
			function():Int{return Math.floor(Math.random()*20);},
			3,
			true)
		);
		queuedSequences.set(treasure.time, treasure);

		var sequence3:Sequence = new Sequence(3, 1000, StageInfo.stageWidth, StageInfo.stageHeight-25, Math.PI);
		sequence3.initEmitter(new RandomEmitter(
			[Shell1, Shell2, Kelp1, Kelp2, Kelp3, Kelp1, Kelp2, Kelp3],
			function():Int{return Math.floor(Math.random()*30+15);},
			function():Int{return Math.floor(Math.random()*20);},
			3,
			true)
		);
		queuedSequences.set(sequence3.time, sequence3);

		var sequence4:Sequence = new Sequence(4, 1000, StageInfo.stageWidth, StageInfo.stageHeight-25, Math.PI);
		sequence4.initEmitter(new RandomEmitter(
			[Kelp1, Kelp2, Kelp3],
			function():Int{return Math.floor(Math.random()*30+30);},
			function():Int{return Math.floor(Math.random()*20);},
			3,
			true)
		);
		queuedSequences.set(sequence4.time, sequence4);

		var satellites:Sequence = new Sequence(100, 30, StageInfo.stageWidth, StageInfo.stageHeight/2, Math.PI);
		satellites.initEmitter(new RandomEmitter(
			[Dolphin, Seahorse],
			function():Int{return 200;},
			function():Int{return Math.floor(Math.random()*StageInfo.stageHeight*0.6-StageInfo.stageHeight*0.3);},
			4)
		);
		queuedSequences.set(satellites.time, satellites);

		var boats:Sequence = new Sequence(10, 30, StageInfo.stageWidth, StageInfo.stageHeight*0.1+40, Math.PI);
		boats.initEmitter(new RandomEmitter(
			[Viking],
			function():Int{return 400;},
			function():Int{return 0;},
			4,
			true)
		);
		queuedSequences.set(boats.time, boats);

		var surface0:Sequence = new Sequence(11, 1000, StageInfo.stageWidth, StageInfo.stageHeight*0.1, Math.PI);
		surface0.initEmitter(new Emitter(Surface0, 25, 4));
		queuedSequences.set(surface0.time, surface0);

		var surface1:Sequence = new Sequence(12, 1000, StageInfo.stageWidth, StageInfo.stageHeight*0.1+25, Math.PI);
		surface1.initEmitter(new Emitter(Surface1, 25, 4));
		queuedSequences.set(surface1.time, surface1);
	}

	public function update():Void
	{
		time++;

		if(queuedSequences.exists(time))
		{
			var sequence : Sequence = queuedSequences.get(time);
			activeSequences.push(sequence);
		}

		for(sequence in activeSequences)
		{
			if(sequence.update())
			{
				activeSequences.remove(sequence);
			}
		}
	}

	public function exit():Void
	{
		
	}
}