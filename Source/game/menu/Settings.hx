package game.menu;

import flash.display.Sprite;
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;
import flash.geom.Point;

import utils.TextfieldFactory;
import utils.SoundHandler;
import utils.TextfieldFactory;
import utils.PositionHelper;
import utils.SWFHandler;
import common.StageInfo;
import common.GridSprite;
import common.Button;
import common.LabelButton;
import common.ToggleButton;
import common.EventType;
import common.Image;
import common.Slider;

class Settings extends Sprite
{
	private var muteEffects:ToggleButton;
	private var effectsVolumeSlider:Slider;
	private var effectsVolumeText:TextField;

	private var muteMusic:ToggleButton;
	private var musicVolumeSlider:Slider;
	private var musicVolumeText:TextField;

	private var background:MovieClip;
	private var container:Sprite;
	private var closeButton:LabelButton;

	public function new():Void
	{
		super();

		background = SWFHandler.getMovieclip("sky1");
		addChild(background);

		container = new Sprite();
		addChild(container);

		closeButton = new LabelButton("button1", "Close");
		closeButton.addEventListener(EventType.BUTTON_PRESSED, closeSelected);
		container.addChild(closeButton);

		effectsVolumeText = TextfieldFactory.getDefault();
		effectsVolumeText.text = "Effects";
		container.addChild(effectsVolumeText);

		muteEffects = new ToggleButton();
		container.addChild(muteEffects);
		muteEffects.setEnabled(!SoundHandler.muteEffects);
		muteEffects.addEventListener(EventType.BUTTON_PRESSED, toggleMuteEffects);

		effectsVolumeSlider = new Slider();
		container.addChild(effectsVolumeSlider);
		effectsVolumeSlider.addEventListener(EventType.SLIDER_CHANGED, effectsVolumeChanged);
		effectsVolumeSlider.setValue(SoundHandler.effectsSoundTransform.volume);
		effectsVolumeSlider.enabled(!SoundHandler.muteEffects);

		musicVolumeText = TextfieldFactory.getDefault();
		musicVolumeText.text = "Music";
		container.addChild(musicVolumeText);

		muteMusic = new ToggleButton();
		container.addChild(muteMusic);
		muteMusic.setEnabled(!SoundHandler.muteMusic);
		muteMusic.addEventListener(EventType.BUTTON_PRESSED, toggleMuteMusic);

		musicVolumeSlider = new Slider();
		container.addChild(musicVolumeSlider);
		musicVolumeSlider.addEventListener(EventType.SLIDER_CHANGED, musicVolumeChanged);
		musicVolumeSlider.setValue(SoundHandler.musicSoundTransform.volume);
		musicVolumeSlider.enabled(!SoundHandler.muteMusic);

		PositionHelper.alignVertically([closeButton, effectsVolumeText, muteEffects, musicVolumeText, muteMusic], new Point(closeButton.x, closeButton.y), 10);
		PositionHelper.alignHorizontally([muteEffects, effectsVolumeSlider], new Point(effectsVolumeText.x, effectsVolumeText.y+effectsVolumeText.height+10) , 10, muteEffects);
		PositionHelper.alignHorizontally([muteMusic, musicVolumeSlider], new Point(0, musicVolumeText.y+musicVolumeText.height+10) , 10, muteMusic);

		StageInfo.addEventListener(EventType.STAGE_RESIZED, resize);
		resize();
	};

	public function closeSelected(e:Event):Void
	{
		this.visible = false;
	};

	private function effectsVolumeChanged(e:Event):Void
	{
		SoundHandler.setEffectsVolume(effectsVolumeSlider.percent);
		//SoundHandler.playEffect("spell0");
	}

	private function toggleMuteEffects(e:Event):Void
	{
		SoundHandler.setMuteEffects(!muteEffects.enabled);
		effectsVolumeSlider.enabled(muteEffects.enabled);
	}

	private function musicVolumeChanged(e:Event):Void
	{
		SoundHandler.setMusicVolume(musicVolumeSlider.percent);
		//SoundHandler.playEffect("spell0");
	}

	private function toggleMuteMusic(e:Event):Void
	{
		SoundHandler.setMuteMusic(!muteMusic.enabled);
		musicVolumeSlider.enabled(muteMusic.enabled);
	}

	public function resize(?e:Event):Void
	{	
		background.width = StageInfo.stageWidth;
		background.height = StageInfo.stageHeight;
		container.x = StageInfo.stageWidth/2 - container.width/2;
		container.y = StageInfo.stageHeight/2 - container.height/2;
	};
}