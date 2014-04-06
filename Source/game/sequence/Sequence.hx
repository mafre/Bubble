package game.sequence;

import game.sequence.ISequence;
import game.emitter.Emitter;
import game.entity.projectile.Bubble;
import game.sequence.SequenceVO;

class Sequence implements ISequence
{
	private var vo:SequenceVO;
	public var id:String;
	public var time:Int;
	private var duration:Int;
	private var xPosition:Float;
	private var yPosition:Float;
	private var angle:Float;
	private var emitter:Dynamic;

	public function new():Void
	{
		//setSequenceProperties();
	};

	public function setSequenceProperties(vo:SequenceVO):Void
	{
		this.vo = vo;
		id = vo.id;
		time = vo.time;
		duration = vo.duration;
		xPosition = vo.xPosition;
		yPosition = vo.yPosition;
		angle = vo.angle;

		setEmitter();
	};

	public function setEmitter():Void
	{
		this.emitter = new Emitter(Bubble, 10, vo.speed);
	}

	public function update():Bool
	{
		emitter.setDuration(duration);

		if(emitter.update(xPosition, yPosition, angle))
		{
			duration--;

			if(duration == 0)
			{
				return true;
			}
		}
		
		return false;
	}
}