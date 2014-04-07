package game.sequence;

import haxe.ds.IntMap;
import box2D.dynamics.B2World;

import flash.events.EventDispatcher;
import flash.events.Event;
import flash.utils.Function;
import flash.display.Sprite;

import common.EventType;
import game.sequence.*;
import game.sequence.world1.AnchorSequence;
import game.sequence.world1.AnglerSequence;
import game.sequence.world1.BoatSequence;
import game.sequence.world1.ContainerSequence;
import game.sequence.world1.JellyFishSequence;
import game.sequence.world1.SandSequence;
import game.sequence.world1.SatelliteSequence;
import game.sequence.world1.Surface1Sequence;
import game.sequence.world1.Surface2Sequence;
import game.sequence.world1.Vegetation1Sequence;
import game.sequence.world1.Vegetation2Sequence;
import game.sequence.world1.SpeedSequence;

class SequenceHandler
{
	static public var __instance:SequenceHandler;

	public var dispatcher:EventDispatcher;
    private var queuedSequences:IntMap<SequenceVO>;
    private var activeSequences:Array<Sequence>;
    private var time:Int;
    private var worldId:String;
    private var classType:Class<Dynamic>;

    public function new():Void
    {
        dispatcher = new EventDispatcher();
        time = 0;
    }

    public function load(worldId:String):Void
    {
        this.worldId = worldId;
        queuedSequences = new IntMap<SequenceVO>();
        activeSequences = new Array<Sequence>();
        SequenceProperties.getInstance().load(worldId);

        for (vo in SequenceProperties.getInstance().sequences)
        {
            queuedSequences.set(vo.time, vo);
        }
    }

    public function reloadProperties():Void
    {
        SequenceProperties.getInstance().load(worldId);

        for (vo in SequenceProperties.getInstance().sequences)
        {
            queuedSequences.set(vo.time, vo);
        }

        for (vo in SequenceProperties.getInstance().sequences)
        {
            for (sequence in activeSequences)
            {
                if(vo.id == sequence.id)
                {
                    sequence.setSequenceProperties(vo);
                }
            }
        }
    }

    public function update():Void
    {
        time++;

        if(queuedSequences.exists(time))
        {
            var vo : SequenceVO = queuedSequences.get(time);
            var path:String = "game.sequence."+worldId+"."+vo.id;
            classType = Type.resolveClass(path);
            var sequence:Dynamic = Type.createInstance(classType, []);
            sequence.setSequenceProperties(vo);
            activeSequences.push(sequence);
        }

        for(sequence in activeSequences)
        {
            if(sequence.update())
            {
                activeSequences.remove(sequence);
            }
        }
    }

	public function addEventListener(type:String, listener:Function):Void
	{
        dispatcher.addEventListener(type, listener);
    }

    public function removeEventListener(type:String, listener:Function):Void
    {
        dispatcher.removeEventListener(type, listener);
    }

    public static function getInstance():SequenceHandler
    {
        if (SequenceHandler.__instance == null)
            SequenceHandler.__instance = new SequenceHandler();
        return SequenceHandler.__instance;
    }
}