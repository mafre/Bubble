package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.LayerEmitter;
import game.entity.background.*;

class Vegetation2Sequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new LayerEmitter(
			[Shell1, Shell2, Coral1, Coral2, Coral3, Coral4, Coral5, Kelp1, Kelp2, Kelp3],
			function():Int{return Math.floor(Math.random()*10+70);},
			function():Int{return Math.floor(Math.random()*5)+1;},
			14,
			vo.speed,
			true);
	}
}