package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.Emitter;
import game.entity.enemies.Jellyfish;

class JellyfishSequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new Emitter(Jellyfish, 20, 5);
	}
}