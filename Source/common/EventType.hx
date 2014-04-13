package common;

class EventType
{	
	static public inline var BUTTON_PRESSED:String					= "ButtonPressed";
	static public inline var BUTTON_RELEASED:String					= "ButtonReleased";

	static public inline var SLIDER_MOVE:String						= "SliderMove";
	static public inline var SLIDER_CHANGED:String					= "SliderChanged";
	
	static public inline var STAGE_RESIZED:String					= "stageResized";
	static public inline var STAGE_INITIALIZED:String				= "stageInitialized";

	static public inline var UPDATE_SCORE:String					= "UpdateScore";
	static public inline var UPDATE_HEALTH:String					= "UpdateHealth";
	static public inline var UPDATE_DISTANCE:String					= "UpdateDistance";
	static public inline var UPDATE_MULTIPLIER:String				= "UpdateMultiplier";

	static public inline var ENTITY_PROPERTIES_LOADED:String		= "EntityPropertiesLoaded";
	static public inline var SEQUENCE_PROPERTIES_LOADED:String		= "SequencePropertiesLoaded";
	static public inline var GAME_PROPERTIES_LOADED:String			= "GamePropertiesLoaded";
}