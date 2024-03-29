package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.ContinuousEmitter;
import game.entity.background.Surface1;

class Surface2Sequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new ContinuousEmitter(Surface1, vo.distance, vo.speed);
	}
}