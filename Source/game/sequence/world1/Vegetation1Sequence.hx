package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.LayerEmitter;
import game.entity.background.*;

class Vegetation1Sequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new LayerEmitter(
			[Shell1, Shell2, Kelp1, Kelp2, Kelp3, Kelp1, Kelp2, Kelp3],
			function():Int{return Math.floor(Math.random()*30+15);},
			function():Int{return Math.floor(Math.random()*5)+3;},
			14,
			vo.speed,
			true);
	}
}