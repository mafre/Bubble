package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.Emitter;
import game.entity.background.Sand2;

class SandSequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new Emitter(Sand2, 12, 3);
	}
}