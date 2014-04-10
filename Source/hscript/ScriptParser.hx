package hscript;

import flash.events.EventDispatcher;
import flash.media.*;
import flash.events.Event;
import flash.net.SharedObject;
import flash.utils.Function;

import common.EventType;
import common.StageInfo;
import game.GameProperties;

import hscript.Parser;
import hscript.Interp;

class ScriptParser
{
	static public var __instance:ScriptParser;
	
    private var parser:Parser;
    private var interp:Interp;

	public function new():Void
    {
        parser = new Parser();
        interp = new Interp();
        interp.variables.set("PI", Math.PI);
        interp.variables.set("Math", Math);
        
        StageInfo.addEventListener(EventType.STAGE_RESIZED, stageResized);
    }

    public function stageResized(?e:Event):Void
    {
        interp.variables.set("stageWidth", StageInfo.stageWidth);
    }

    public function gamePropertiesLoaded():Void
    {
        interp.variables.set("height", GameProperties.height);
        interp.variables.set("worldTop", GameProperties.worldTop);
        interp.variables.set("worldBottom", GameProperties.worldBottom);
        interp.variables.set("globalSpeed", GameProperties.globalSpeed);
    }

    public function parse(value:String):Dynamic
    {
        var program = parser.parseString(value);
        var result = interp.execute(program);
        return result;
    }

	public static function getInstance():ScriptParser
    {
        if (ScriptParser.__instance == null)
            ScriptParser.__instance = new ScriptParser();
        return ScriptParser.__instance;
    }
}