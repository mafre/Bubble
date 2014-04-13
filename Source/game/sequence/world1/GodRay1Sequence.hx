package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.RandomEmitter;
import game.entity.background.*;
import common.StageInfo;

class GodRay1Sequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new RandomEmitter(
			[GodRay1, GodRay2],
			function():Float{return Math.random()*10+10;},
			function():Float{return Math.random()*StageInfo.stageWidth;},
			function():Float{return Math.random()*50;},
			vo.speed);
	}
}