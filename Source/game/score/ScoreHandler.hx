package game.score;

import flash.events.EventDispatcher;
import flash.events.Event;
import flash.utils.Function;

import common.EventType;

class ScoreHandler
{
	static public var __instance:ScoreHandler;

	public var dispatcher:EventDispatcher;
    public var score:Int;
    public var health:Int;

    public function new():Void
    {
        dispatcher = new EventDispatcher();
        score = 0;
        health = 100;
    }

    public function addScore(amount:Int):Void
    {
        score += amount;
        dispatcher.dispatchEvent(new Event(EventType.UPDATE_SCORE));
    }

    public function setHealth(health:Int):Void
    {
        this.health = health;
        dispatcher.dispatchEvent(new Event(EventType.UPDATE_HEALTH));
    }

	public function addEventListener(type:String, listener:Function):Void
	{
        dispatcher.addEventListener(type, listener);
    }

    public function removeEventListener(type:String, listener:Function):Void
    {
        dispatcher.removeEventListener(type, listener);
    }

    public static function getInstance():ScoreHandler
    {
        if (ScoreHandler.__instance == null)
            ScoreHandler.__instance = new ScoreHandler();
        return ScoreHandler.__instance;
    }
}