package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.TimedEmitter;
import game.entity.boat.Viking;
import game.entity.boat.Pirate;

class BoatSequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new TimedEmitter(
			[Viking, Pirate],
			function():Int{return 100;},
			function():Int{return 0;},
			vo.speed,
			true);
	}
}