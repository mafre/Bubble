package game.sequence;

import game.sequence.ISequence;
import game.emitter.Emitter;

class Sequence implements ISequence
{
	public var time:Int;
	private var duration:Int;
	private var xPosition:Float;
	private var yPosition:Float;
	private var angle:Float;
	private var emitter:Dynamic;

	public function new(aTime:Int, aDuration:Int, aXPosition:Float, aYPosition:Float, aAngle:Float):Void
	{
		time = aTime;
		duration = aDuration;
		xPosition = aXPosition;
		yPosition = aYPosition;
		angle = aAngle;
	};

	public function initEmitter(aEmitter:Dynamic):Void
	{
		emitter = aEmitter;
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