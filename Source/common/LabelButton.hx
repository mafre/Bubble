package common;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.text.TextField;

import common.GridSprite;
import common.EventType;
import utils.TextfieldFactory;
import utils.SoundHandler;

class LabelButton extends Sprite
{
	private var path:String;	
	private var up:GridSprite;
	private var down:GridSprite;
	private var labelTF:TextField;
	private var event:String;
	public var index:Int;

	public function new(path:String, label:String, ?aWidth:Float, ?event:String)
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

		labelTF = TextfieldFactory.getButtonLabel();
		labelTF.text = label;

		up = new GridSprite("images/buttons/button1/button1up_", (aWidth != null) ? aWidth : labelTF.textWidth+30, labelTF.height+10, true);
		addChild(up);

		down = new GridSprite("images/buttons/button1/button1down_", (aWidth != null) ? aWidth : labelTF.textWidth+30, labelTF.height+10, true);
		addChild(down);
		down.visible = false;
		
		labelTF.x = up.width/2 - labelTF.width/2;
		labelTF.y = up.height/2 - labelTF.height/2;
		addChild(labelTF);

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