package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.ContinuousRandomEmitter;
import game.entity.background.*;

class Coral2Sequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new ContinuousRandomEmitter([Coral1, Coral2, Coral3, Coral4, Coral5], vo.speed, true);
	}
}