package game.sequence;

import flash.events.EventDispatcher;
import flash.media.*;
import flash.events.Event;
import flash.net.SharedObject;
import flash.utils.Function;

import haxe.ds.StringMap;
import haxe.Json;

import openfl.Assets;

import hscript.ScriptParser;

import common.EventType;
import common.StageInfo;
import game.GameProperties;
import game.sequence.SequenceVO;

class SequenceProperties
{
    public var sequences:Array<SequenceVO>;

    static public var __instance:SequenceProperties;
    public var dispatcher:EventDispatcher;

	public function new():Void
    {
        dispatcher = new EventDispatcher();
        sequences = new Array<SequenceVO>();
    }

    public function load(id:String):Void
    {
        sequences = new Array<SequenceVO>();

        var properties:Dynamic = Json.parse(Assets.getText("assets/json/sequenceProperties9.json"));
        setProperties(Reflect.field(properties.sequences, id));

        dispatcher.dispatchEvent(new Event(EventType.SEQUENCE_PROPERTIES_LOADED));
    }

    private function setProperties(aSequences:Dynamic):Void
    {
        for (n in Reflect.fields(aSequences))
        {
            var sequence:Dynamic = Reflect.field(aSequences, n);
            var vo:SequenceVO = new SequenceVO();
            vo.id = Std.string(n);
            vo.time = Std.parseInt(sequence.time);
            vo.duration = Std.parseInt(sequence.duration);
            vo.delay = Std.parseInt(sequence.delay);
            vo.xPosition = parseProperty(Std.string(sequence.x));
            vo.yPosition = parseProperty(Std.string(sequence.y));
            vo.angle = parseProperty(Std.string(sequence.angle));
            vo.distance = parseProperty(Std.string(sequence.distance));
            vo.speed = parseProperty(Std.string(sequence.speed));
            sequences.push(vo);
        }
    }

    private function parseProperty(value:String):Dynamic
    {
        return ScriptParser.getInstance().parse(value);
    }

    public function addEventListener(type:String, listener:Function):Void
	{
        dispatcher.addEventListener(type, listener);
    }

    public function removeEventListener(type:String, listener:Function):Void
    {
        dispatcher.removeEventListener(type, listener);
    }

	public static function getInstance():SequenceProperties
    {
        if (SequenceProperties.__instance == null)
            SequenceProperties.__instance = new SequenceProperties();
        return SequenceProperties.__instance;
    }
}