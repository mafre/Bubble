package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.TimedEmitter;
import game.entity.boat.Viking;
import game.entity.boat.Pirate;
import game.GameProperties;

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
			function():Int{return vo.delay;},
			function():Int{return 14;},
			vo.speed,
			true);
	}
}