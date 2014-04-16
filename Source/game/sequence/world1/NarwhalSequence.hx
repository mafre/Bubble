package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.RandomEmitter;
import game.entity.enemies.Narwhal;

class NarwhalSequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new RandomEmitter(
			[Narwhal],
			function():Float{return vo.distance;},
			function():Float{return 0;},
			function():Float{return 50+Math.random()*300;},
			vo.speed,
			true);
	}
}