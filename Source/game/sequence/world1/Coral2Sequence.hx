package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.RandomEmitter;
import game.entity.background.*;

class Coral2Sequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new RandomEmitter(
			[Coral1, Coral2, Coral3, Coral4, Coral5],
			function():Float{return Math.random()*100+60;},
			function():Float{return 0;},
			function():Float{return 15+Math.random()*5;},
			vo.speed,
			true);
	}
}