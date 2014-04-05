package common;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import common.EventType;
import common.Image;
import common.GridSprite;
import utils.SoundHandler;

class ToggleButton extends Sprite
{	
	private var back:GridSprite;
	private var front:Image;
	public var enabled:Bool;

	public function new():Void
	{
		super();

		front = new Image("images/buttons/check/check.png");
		front.x = front.y = 5;

		back = new GridSprite("images/buttons/button1/button1up_", front.width+10, front.height+10, true);
		addChild(back);
		addChild(front);

		front.alpha = 0;

		isSelectable(true);
	};

	public function isSelectable(b:Bool):Void
	{
		if(b)
		{
			addEventListener(MouseEvent.MOUSE_DOWN, toggle);
		}
		else
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, toggle);
		}
	}

	public function setEnabled(enabled:Bool):Void
	{
		this.enabled = enabled;
		front.alpha = enabled ? 1 : 0;
	}

	public function toggle(e:Event):Void
	{
		e.stopImmediatePropagation();
		enabled = !enabled;
		front.alpha = enabled ? 1 : 0;

		//)SoundHandler.playEffect("btn0");

		dispatchEvent(new Event(EventType.BUTTON_PRESSED));
	}
}