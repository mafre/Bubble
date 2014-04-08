package game;

import openfl.Assets;
import haxe.Json;
import sys.io.File;

import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.media.*;
import flash.events.Event;
import flash.net.SharedObject;
import flash.utils.Function;

import common.EventType;
import common.StageInfo;
import game.GameProperties;
import game.sequence.SequenceHandler;
import game.entity.EntityHandler;

class GameEngine
{
	static public var __instance:GameEngine;
	public var dispatcher:EventDispatcher;
	public var container:Sprite;

	public function new():Void
    {
        dispatcher = new EventDispatcher();
    }

    public function setContainer(container:Sprite):Void
    {
        this.container = container;
    }

    public function update():Void
    {
    	// update camera
    	container.y = GameProperties.cameraYOffset;

    	// increase distance travelled
    	GameProperties.getInstance().update();

    	// update sequences
		SequenceHandler.getInstance().update();

		//Update entities
		EntityHandler.getInstance().update();
    }

    public function addEventListener(type:String, listener:Function):Void
	{
        dispatcher.addEventListener(type, listener);
    }

    public function removeEventListener(type:String, listener:Function):Void
    {
        dispatcher.removeEventListener(type, listener);
    }

	public static function getInstance():GameEngine
    {
        if (GameEngine.__instance == null)
            GameEngine.__instance = new GameEngine();
        return GameEngine.__instance;
    }
}