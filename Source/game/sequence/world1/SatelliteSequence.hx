package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.RandomEmitter;
import game.entity.satellite.*;
import common.StageInfo;

class SatelliteSequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new RandomEmitter(
			[Dolphin, Seahorse],
			function():Int{return 200;},
			function():Int{return Math.floor(Math.random()*StageInfo.stageHeight*0.6-StageInfo.stageHeight*0.3);},
			4);
	}
}