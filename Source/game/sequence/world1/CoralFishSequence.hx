package game.sequence.world1;

import common.StageInfo;
import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.RandomEmitter;
import game.entity.background.*;

class CoralFishSequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new RandomEmitter(
			[BigFish],
			function():Int{return 500;},
			function():Int{return Math.floor(Math.random()*StageInfo.stageHeight*0.6);},
			vo.speed);
	}
}