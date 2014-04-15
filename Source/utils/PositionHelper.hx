package utils;

import flash.geom.Point;

class PositionHelper
{
	public static inline function alignHorizontally(items:Array<Dynamic>, position:Point, ?gap:Float, ?alignToBottom:Bool, ?alignVerticallyToItem:Dynamic):Void
	{
		var posX:Float = position.x;
		var posY:Float = position.y;

		for (item in items)
		{
			item.x = posX;

			if(alignVerticallyToItem != null)
			{
				item.y = posY + alignVerticallyToItem.height/2 - item.height/2;
			}
			else
			{
				item.y = posY;
			}

			if(alignToBottom != null && alignToBottom)
			{
				item.y -= item.height;
			}

			posX += item.width;
			if(gap != null)
			{
				posX += gap;
			}
		}
	}

	public static inline function alignVertically(items:Array<Dynamic>, position:Point, ?gap:Float):Void
	{
		var posX:Float = position.x;
		var posY:Float = position.y;

		for (item in items)
		{
			item.x = posX;
			item.y = posY;

			posY += item.height;
			if(gap != null)
			{
				posY += gap;
			}
		}
	}

	public static inline function alignTiled(items:Array<Dynamic>, position:Point, gap:Float, maxWidth:Float):Void
	{
		var posX:Float = position.x;
		var posY:Float = position.y;

		for (item in items)
		{
			item.x = posX;
			item.y = posY;

			posX += item.width + gap;
		}
	}
}