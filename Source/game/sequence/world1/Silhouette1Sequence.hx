package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.ContinuousRandomEmitter;
import game.entity.background.*;

class Silhouette1Sequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setEmitter():Void
	{
		emitter = new ContinuousRandomEmitter([Silhouette1, Silhouette2, Silhouette3, Silhouette4, Silhouette5], vo.speed, true);
	}
}