package game.sequence.world1;

import game.sequence.ISequence;
import game.sequence.Sequence;
import game.emitter.LayerEmitter;
import game.entity.other.Anchor;
import game.entity.EntityProperties;

class SpeedSequence extends Sequence implements ISequence
{ 
	public function new():Void
	{
		super();
	};

	public override function setSequenceProperties(vo:SequenceVO):Void
	{
		this.vo = vo;
		id = vo.id;
		duration = vo.duration;
	};

	public override function update():Bool
	{
		duration--;

		EntityProperties.globalSpeed += vo.speed;

		if(duration == 0)
		{
			trace("nu");
			return true;
		}
		
		return false;
	}
}