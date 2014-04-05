package;

import openfl.display.FPS;
import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.events.Event;
import flash.events.MouseEvent;
import utils.SoundHandler;

import game.Game;
import common.StageInfo;

@:font("F.ttf") class DefaultFont extends Font {}
@:font("OpenSans-Regular.ttf") class OpenSansFont extends Font {}

class Main extends Sprite
{
	private var fps:FPS;
	private var game:Game;

	public function new()
	{
		super ();

		var soundHandler:SoundHandler = new SoundHandler();

		Font.registerFont(OpenSansFont);
		
    	fps = new FPS();

    	game = new Game();
    	addChild(game);
    	game.init();

    	stage.addEventListener(Event.RESIZE, stageResize);
		stageResize();
	};

	private function stageResize(event:Event = null):Void
	{
		StageInfo.resize(this.stage.stageWidth, this.stage.stageHeight);
	};
}