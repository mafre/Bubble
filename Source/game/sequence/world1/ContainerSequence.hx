package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.LayerEmitter;
import game.entity.container.*;

class ContainerSequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new LayerEmitter(
			[Shoe, TreasureChest, Safe, Bottle],
			function():Int{return Math.floor(Math.random()*200+200);},
			function():Int{return Math.floor(Math.random()*5)+3;},
			14,
			vo.speed,
			true);
	}
}