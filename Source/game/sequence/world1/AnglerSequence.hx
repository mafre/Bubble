package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.Emitter;
import game.entity.enemies.Angler;

class AnglerSequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new Emitter(Angler, 50, 4);
	}
}