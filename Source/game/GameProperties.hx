package game;

import openfl.Assets;
import haxe.Json;

import flash.events.EventDispatcher;
import flash.media.*;
import flash.events.Event;
import flash.net.SharedObject;
import flash.utils.Function;

import common.EventType;
import common.StageInfo;

class GameProperties
{
	static public var __instance:GameProperties;
    static public var distanceTravelled:Float;
    static public var globalSpeed:Float;
    static public var height:Float;
    static public var cameraYOffset:Float;
    static public var minYOffset:Float;
    static public var maxYOffset:Float;
    static public var worldTop:Float;
    static public var worldBottom:Float;
    static public var playerX:Float;
    static public var playerY:Float;
    static public var playerWidht:Float;
    static public var playerHeight:Float;
    static public var multiplier:Float;

	public var dispatcher:EventDispatcher;
	public var debug:Bool;

	public function new():Void
    {
        dispatcher = new EventDispatcher();
        debug = true;
        cameraYOffset = 0;
        multiplier = 0;
        StageInfo.addEventListener(EventType.STAGE_RESIZED, stageResized);
    }

    public function load():Void
    {
        var properties:Dynamic = null;

        properties = Json.parse(Assets.getText("assets/json/gameProperties.json"));
        setProperties(properties);

        dispatcher.dispatchEvent(new Event(EventType.GAME_PROPERTIES_LOADED));
    }

    private function setProperties(properties:Dynamic):Void
    {
        height = properties.game.height;
        globalSpeed = properties.game.globalSpeed;
        distanceTravelled = properties.game.distanceTravelled;
        worldTop = properties.game.worldTop;
        worldBottom = height - properties.game.worldBottom;

        minYOffset = setMinYOffset();
        maxYOffset = setMaxYOffset();
    }

    private function setMinYOffset():Float
    {
        return 0;
    }

    private function setMaxYOffset():Float
    {
        return height;
    }

    public function setPlayerYPosition(playerYPos:Float):Void
    {
        playerY = playerYPos;

        if(playerYPos >= (GameProperties.height - StageInfo.stageHeight))
        {
            cameraYOffset = -(GameProperties.height - StageInfo.stageHeight);
            return;
        }

        cameraYOffset = Math.round(-playerYPos);
    }

    public function setPlayerXPosition(playerXPos:Float):Void
    {
        playerX = playerXPos;
    }

    public function increaseMultiplier():Void
    {
        multiplier++;
        dispatcher.dispatchEvent(new Event(EventType.UPDATE_MULTIPLIER));
    }

    public function resetMultiplier():Void
    {
        multiplier = 0;
        dispatcher.dispatchEvent(new Event(EventType.UPDATE_MULTIPLIER));
    }

    private function stageResized(e:Event):Void
    {
        minYOffset = setMinYOffset();
        maxYOffset = setMaxYOffset();
    }

    public function update():Void
    {
        distanceTravelled += globalSpeed;
        dispatcher.dispatchEvent(new Event(EventType.UPDATE_DISTANCE));
    }

    public function addEventListener(type:String, listener:Function):Void
	{
        dispatcher.addEventListener(type, listener);
    }

    public function removeEventListener(type:String, listener:Function):Void
    {
        dispatcher.removeEventListener(type, listener);
    }

	public static function getInstance():GameProperties
    {
        if (GameProperties.__instance == null)
            GameProperties.__instance = new GameProperties();
        return GameProperties.__instance;
    }
}