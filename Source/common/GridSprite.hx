package common;

import common.Image;
import flash.display.Sprite;
import flash.display.MovieClip;
import utils.SWFHandler;

class GridSprite extends Sprite
{
	private var images:Array<MovieClip>;
	private var areImagesSpecific:Bool;

	public function new(path:String, width:Float, height:Float, ?areImagesSpecific:Bool)
	{
		super();

		if(path == null)
		{
			return;
		}

		images = new Array<MovieClip>();

		if(areImagesSpecific != null)
		{
			this.areImagesSpecific = true;

			//topleft
			var c1:MovieClip = SWFHandler.getMovieclip(path+"TopLeft");
			addChild(c1);
			images.push(c1);

			//top
			var s1:MovieClip = SWFHandler.getMovieclip(path+"Top");
			addChild(s1);
			images.push(s1);

			//topright
			var c2:MovieClip = SWFHandler.getMovieclip(path+"TopRight");
			addChild(c2);
			images.push(c2);

			//left
			var s2:MovieClip = SWFHandler.getMovieclip(path+"Left");
			addChild(s2);
			images.push(s2);

			//center
			var c:MovieClip = SWFHandler.getMovieclip(path+"Center");
			addChild(c);
			images.push(c);

			//right
			var s3:MovieClip = SWFHandler.getMovieclip(path+"Right");
			addChild(s3);
			images.push(s3);

			//bottomleft
			var c3:MovieClip = SWFHandler.getMovieclip(path+"BottomLeft");
			addChild(c3);
			images.push(c3);

			//bottom
			var s4:MovieClip = SWFHandler.getMovieclip(path+"Bottom");
			addChild(s4);
			images.push(s4);

			//bottomright
			var c4:MovieClip = SWFHandler.getMovieclip(path+"BottomRight");
			addChild(c4);
			images.push(c4);

			setSize(width, height);
		}

		mouseChildren = false;
		buttonMode = false;
	}

	public function setSize(width:Float, height:Float):Void
	{
		if(areImagesSpecific)
		{
			//top
			images[1].x = images[0].width;
			images[1].width = width-images[0].width*2;

			//topright
			images[2].x = images[1].x+images[1].width;

			//left
			images[3].height = height-images[0].height*2;
			images[3].y = images[0].height;

			//center
			images[4].x = images[0].width;
			images[4].y = images[0].height;
			images[4].width = width-images[0].width*2;
			images[4].height = height-images[0].height*2;

			//right
			images[5].height = height-images[0].height*2;
			images[5].y = images[0].height;
			images[5].x = images[2].x;

			//bottomleft
			images[6].y = images[3].y+images[3].height;

			//bottom
			images[7].width = images[1].width;
			images[7].y = images[6].y;
			images[7].x = images[0].width;

			//bottomright
			images[8].y = images[7].y;
			images[8].x = images[7].x+images[7].width;
		}
		else
		{
			//top
			images[1].x = images[0].width;
			images[1].width = width-images[0].width*2;

			//topright
			images[2].rotation = 0;
			images[2].x = images[1].x+images[1].width+images[2].width;
			images[2].rotation = 90;

			//left
			images[3].rotation = 0;
			images[3].width = height-images[0].height*2;
			images[3].y = images[0].height + images[3].width;
			images[3].rotation = -90;

			//center
			images[4].x = images[0].width;
			images[4].y = images[0].height;
			images[4].width = width-images[0].width*2;
			images[4].height = height-images[0].height*2;

			//right
			images[5].rotation = 0;
			images[5].width = height-images[0].height*2;
			images[5].y = images[5].height;
			images[5].x = images[2].x;
			images[5].rotation = 90;

			//bottomleft
			images[6].rotation = 0;
			images[6].y = images[3].height+images[0].height*2;
			images[6].rotation = -90;

			//bottom
			images[7].rotation = 0;
			images[7].width = images[1].width;
			images[7].y = height;
			images[7].x = images[7].width+images[0].width;
			images[7].rotation = 180;

			//bottomright
			images[8].rotation = 0;
			images[8].y = images[5].height+images[0].height*2;
			images[8].x = images[1].width+images[0].width*2;
			images[8].rotation = 180;
		}
	}
}