package utils;

import flash.text.TextFormat;
import flash.text.TextField;
import flash.text.TextFormatAlign;
import flash.text.TextFieldAutoSize;

import flash.filters.GlowFilter;
import flash.filters.BitmapFilterQuality;

class TextfieldFactory
{
	public static inline function getDefault():Dynamic
	{
		var format = new TextFormat();
        format.font = "Open Sans";
        format.color=0xFFFFFF;
        format.size = 24;

        var field = new TextField();
		field.defaultTextFormat = format;
        field.autoSize = TextFieldAutoSize.LEFT;
		field.mouseEnabled = false;

		//var outline:GlowFilter=new GlowFilter(0x000000,1,3,3,300);
		//field.filters=[outline];

		return field;
	}

	public static inline function getButtonLabel():Dynamic
	{
		var format = new TextFormat();
        format.font = "Open Sans";
        format.color=0xFFFFFF;
        format.size = 34;
        format.bold = true;

        var field = new TextField();
		field.defaultTextFormat = format;
        field.autoSize = TextFieldAutoSize.LEFT;
		field.mouseEnabled = false;

		return field;
	}

	public static inline function getMenuDefault():Dynamic
	{
		var format = new TextFormat();
        format.font = "Open Sans";
        format.color=0xFFFFFF;
        format.size = 24;

        var field = new TextField();
		field.defaultTextFormat = format;
        field.autoSize = TextFieldAutoSize.LEFT;
		field.mouseEnabled = false;

		var outline:GlowFilter=new GlowFilter(0x000000,1,3,3,300);
		field.filters=[outline];

		return field;
	}
}