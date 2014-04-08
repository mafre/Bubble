package common;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.text.TextField;

import common.GridSprite;
import common.EventType;
import utils.TextfieldFactory;
import utils.SoundHandler;

class ImageButton extends Sprite
{
	private var path:String;	
	private var up:GridSprite;
	private var down:GridSprite;
	private var image:Image;
	private var event:String;

	public function new(path:String, ?event:String)
	{
		super();

		if(path == null)
		{
			return;
		};

		this.event = EventType.BUTTON_PRESSED;

		if(event != null)
		{
			this.event = event;
		};

		image = new Image(path);
		image.scaleX = image.scaleY = 1.5;

		up = new GridSprite("images/buttons/button1/button1up_", image.width+10, image.height+10, true);
		addChild(up);

		down = new GridSprite("images/buttons/button1/button1down_", image.width+10, image.height+10, true);
		addChild(down);
		down.visible = false;
		
		addChild(image);
		image.x = image.y = 5;

		this.path = path;

		addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		addEventListener(MouseEvent.MOUSE_UP, mouseUp);
	}

	public function mouseDown(e:MouseEvent):Void
	{
		down.visible = true;
		up.visible = false;
		addEventListener(MouseEvent.ROLL_OUT, mouseUp);
		SoundHandler.playEffect("button0");
		dispatchEvent(new Event(event));
	}

	public function mouseUp(e:MouseEvent):Void
	{
		down.visible = false;
		up.visible = true;
		removeEventListener(MouseEvent.ROLL_OUT, mouseUp);
		SoundHandler.playEffect("button2");
		dispatchEvent(new Event(EventType.BUTTON_RELEASED));
	}
}