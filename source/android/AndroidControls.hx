package android;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSave;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.input.touch.FlxTouch;
import flixel.text.FlxText;
import android.flixel.FlxButton;
import android.flixel.FlxHitbox;
import android.flixel.FlxVirtualPad;

using StringTools;

/**
 * ...
 * @original author: luckydog
 * @modifications author: Saw (M.A. Jigsaw)
 */
class Config
{
	var save:FlxSave;

	public function new()
	{
		save = new FlxSave();
		save.bind('controls_android');
	}

	public function getcontrolmode():Int
	{
		if (save.data.buttonsmode != null)
			return save.data.buttonsmode[0];
		return 0;
	}

	public function setcontrolmode(mode:Int = 0):Int
	{
		if (save.data.buttonsmode == null)
			save.data.buttonsmode = new Array();

		save.data.buttonsmode[0] = mode;
		save.flush();
		return save.data.buttonsmode[0];
	}

	public function savecustom(_pad:FlxVirtualPad)
	{
		if (save.data.buttons == null)
		{
			save.data.buttons = new Array();
			for (buttons in _pad)
				save.data.buttons.push(FlxPoint.get(buttons.x, buttons.y));
		}
		else
		{
			var tempCount:Int = 0;
			for (buttons in _pad)
			{
				save.data.buttons[tempCount] = FlxPoint.get(buttons.x, buttons.y);
				tempCount++;
			}
		}
		save.flush();
	}

	public function loadcustom(_pad:FlxVirtualPad):FlxVirtualPad
	{
		if (save.data.buttons == null)
			return _pad;

		var tempCount:Int = 0;
		for (buttons in _pad)
		{
			buttons.x = save.data.buttons[tempCount].x;
			buttons.y = save.data.buttons[tempCount].y;
			tempCount++;
		}

		return _pad;
	}
}

class AndroidControls extends FlxSpriteGroup
{
	public var mode:ControlsGroup = VIRTUALPAD_RIGHT;

	public var hbox:FlxHitbox;
	public var vpad:FlxVirtualPad;

	var config:Config;

	public function new()
	{
		super();

		config = new Config();

		mode = getModeFromNumber(config.getcontrolmode());

		switch (mode)
		{
			case VIRTUALPAD_RIGHT:
				initControler(0);
			case VIRTUALPAD_LEFT:
				initControler(1);
			case VIRTUALPAD_CUSTOM:
				initControler(2);
			case DUO:
				initControler(3);
			case HITBOX:
				initControler(4);
			default:
		}
	}

	private function initControler(vpadMode:Int):Void
	{
		switch (vpadMode)
		{
			case 0:
				vpad = new FlxVirtualPad(RIGHT_FULL, NONE);
				add(vpad);
			case 1:
				vpad = new FlxVirtualPad(LEFT_FULL, NONE);
				add(vpad);
			case 2:
				vpad = new FlxVirtualPad(RIGHT_FULL, NONE);
				vpad = config.loadcustom(vpad);
				add(vpad);
			case 3:
				vpad = new FlxVirtualPad(BOTH_FULL, NONE);
				add(vpad);
			case 4:
				hbox = new FlxHitbox();
				add(hbox);
			default:
		}
	}

	public static function getModeFromNumber(modeNum:Int):ControlsGroup
	{
		return switch (modeNum)
		{
			case 0:
				VIRTUALPAD_RIGHT;
			case 1:
				VIRTUALPAD_LEFT;
			case 2:
				VIRTUALPAD_CUSTOM;
			case 3:
				DUO;
			case 4:
				HITBOX;
			case 5:
				KEYBOARD;
			default:
				VIRTUALPAD_RIGHT;
		}
	}
}

class Menu extends MusicBeatState
{
	var vpad:FlxVirtualPad;
	var hbox:FlxHitbox;
	var upPozition:FlxText;
	var downPozition:FlxText;
	var leftPozition:FlxText;
	var rightPozition:FlxText;
	var inputvari:PsychAlphabet;
	var funitext:PsychAlphabet;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var controlitems:Array<String> = ['Pad-Right', 'Pad-Left', 'Pad-Custom', 'Duo', 'Hitbox', 'Keyboard'];
	var curSelected:Int = 0;
	var buttonIsTouched:Bool = false;
	var bindButton:FlxButton;
	var resetButton:FlxButton;
	var config:Config;

	override function create()
	{
		config = new Config();
		curSelected = config.getcontrolmode();

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		var titleText:PsychAlphabet = new PsychAlphabet(0, 0, 'Android Controls', true, false, 0, 0.6);
		titleText.x += 60;
		titleText.y += 40;
		titleText.alpha = 0.4;
		add(titleText);

		resetButton = new FlxButton(FlxG.width - 200, 50, "Reset", function()
		{
			if (resetButton.visible)
				reset();
		});
		resetButton.setGraphicSize(Std.int(resetButton.width) * 3);
		resetButton.label.setFormat(null, 16, 0x333333, "center");
		resetButton.color = FlxColor.fromRGB(255, 0, 0);
		resetButton.visible = false;
		add(resetButton);

		vpad = new FlxVirtualPad(RIGHT_FULL, NONE);
		vpad.visible = false;
		add(vpad);

		hbox = new FlxHitbox();
		hbox.visible = false;
		add(hbox);

		funitext = new PsychAlphabet(0, 0, 'No Android Controls!', true, false, 0, 1);
		funitext.screenCenter();
		funitext.visible = false;
		add(funitext);

		inputvari = new PsychAlphabet(0, 50, controlitems[curSelected], false, false, 0.05, 0.8);
		inputvari.screenCenter(X);
		add(inputvari);

		leftArrow = new FlxSprite(inputvari.x - 60, inputvari.y + 50);
		leftArrow.frames = FlxAtlasFrames.fromSparrow('assets/android/menu/arrows.png', 'assets/android/menu/arrows.xml');
		leftArrow.animation.addByPrefix('idle', 'arrow left');
		leftArrow.animation.addByPrefix('press', 'arrow push left');
		leftArrow.animation.play('idle');
		add(leftArrow);

		rightArrow = new FlxSprite(inputvari.x + inputvari.width + 10, leftArrow.y);
		rightArrow.frames = FlxAtlasFrames.fromSparrow('assets/android/menu/arrows.png', 'assets/android/menu/arrows.xml');
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', 'arrow push right', 24, false);
		rightArrow.animation.play('idle');
		add(rightArrow);

		upPozition = new FlxText(10, FlxG.height - 104, 0, 'Button Up X:' + vpad.buttonUp.x + ' Y:' + vpad.buttonUp.y, 16);
		upPozition.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		upPozition.borderSize = 2.4;
		add(upPozition);

		downPozition = new FlxText(10, FlxG.height - 84, 0, 'Button Down X:' + vpad.buttonDown.x + ' Y:' + vpad.buttonDown.y, 16);
		downPozition.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		downPozition.borderSize = 2.4;
		add(downPozition);

		leftPozition = new FlxText(10, FlxG.height - 64, 0, 'Button Left X:' + vpad.buttonLeft.x + ' Y:' + vpad.buttonLeft.y, 16);
		leftPozition.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		leftPozition.borderSize = 2.4;
		add(leftPozition);

		rightPozition = new FlxText(10, FlxG.height - 44, 0, 'Button RIght x:' + vpad.buttonRight.x + ' Y:' + vpad.buttonRight.y, 16);
		rightPozition.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		rightPozition.borderSize = 2.4;
		add(rightPozition);

		var tipText:FlxText = new FlxText(10, FlxG.height - 24, 0, 'Press BACK on your phone to get back in options menu', 16);
		tipText.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tipText.borderSize = 2.4;
		tipText.scrollFactor.set();
		add(tipText);

		changeSelection();

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		leftArrow.x = inputvari.x - 60;
		rightArrow.x = inputvari.x + inputvari.width + 10;
		inputvari.screenCenter(X);

		for (touch in FlxG.touches.list)
		{
			if (touch.overlaps(leftArrow) && touch.justPressed)
				changeSelection(-1);
			else if (touch.overlaps(rightArrow) && touch.justPressed)
				changeSelection(1);

			var daChoice:String = controlitems[Math.floor(curSelected)];

			if (daChoice == 'Pad-Custom')
			{
				if (buttonIsTouched)
				{
					if (bindButton.justReleased && touch.justReleased)
					{
						buttonIsTouched = false;
						bindButton = null;
					}
					else
					{
						moveButton(touch, bindButton);
						positionsTexts();
					}
				}
				else
				{
					if (vpad.buttonUp.justPressed)
						moveButton(touch, vpad.buttonUp);

					if (vpad.buttonDown.justPressed)
						moveButton(touch, vpad.buttonDown);

					if (vpad.buttonRight.justPressed)
						moveButton(touch, vpad.buttonRight);

					if (vpad.buttonLeft.justPressed)
						moveButton(touch, vpad.buttonLeft);
				}
			}
		}

		if (FlxG.android.justReleased.BACK)
		{
			save();
			MusicBeatState.switchState(new options.OptionsState());
		}
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = controlitems.length - 1;
		if (curSelected >= controlitems.length)
			curSelected = 0;

		inputvari.changeText(controlitems[curSelected]);

		var daChoice:String = controlitems[Math.floor(curSelected)];

		switch (daChoice)
		{
			case 'Pad-Right':
				remove(vpad);
				vpad = new FlxVirtualPad(RIGHT_FULL, NONE);
				add(vpad);
			case 'Pad-Left':
				remove(vpad);
				vpad = new FlxVirtualPad(LEFT_FULL, NONE);
				add(vpad);
			case 'Pad-Custom':
				remove(vpad);
				vpad = new FlxVirtualPad(RIGHT_FULL, NONE);
				add(vpad);
				loadCustom();
			case 'Duo':
				remove(vpad);
				vpad = new FlxVirtualPad(BOTH_FULL, NONE);
				add(vpad);
			case 'Hitbox':
				vpad.visible = false;
			case 'Keyboard':
				remove(vpad);
				vpad.visible = false;
		}

		if (daChoice == 'Hitbox')
			hbox.visible = true;
		else
			hbox.visible = false;

		if (daChoice == 'Keyboard')
			funitext.visible = true;
		else
			funitext.visible = false;

		if (daChoice == 'Pad-Custom')
		{
			resetButton.visible = true;
			upPozition.visible = true;
			downPozition.visible = true;
			leftPozition.visible = true;
			rightPozition.visible = true;
		}
		else
		{
			resetButton.visible = false;
			upPozition.visible = false;
			downPozition.visible = false;
			leftPozition.visible = false;
			rightPozition.visible = false;
		}
	}

	function moveButton(touch:FlxTouch, button:FlxButton):Void
	{
		button.x = touch.x - button.width / 2;
		button.y = touch.y - button.height / 2;
		bindButton = button;
		buttonIsTouched = true;
	}

	function positionsTexts():Void
	{
		upPozition.text = 'Button Up X:' + vpad.buttonUp.x + ' Y:' + vpad.buttonUp.y;
		downPozition.text = 'Button Down X:' + vpad.buttonDown.x + ' Y:' + vpad.buttonDown.y;
		leftPozition.text = 'Button Left X:' + vpad.buttonLeft.x + ' Y:' + vpad.buttonLeft.y;
		rightPozition.text = 'Button Right x:' + vpad.buttonRight.x + ' Y:' + vpad.buttonRight.y;
	}

	function save():Void
	{
		config.setcontrolmode(curSelected);

		var daChoice:String = controlitems[Math.floor(curSelected)];

		if (daChoice == 'Pad-Custom')
			config.savecustom(vpad);
	}

	function reset():Void
	{
		vpad.buttonUp.x = FlxG.width - 258;
		vpad.buttonUp.y = FlxG.height - 408;
		vpad.buttonDown.x = FlxG.width - 258;
		vpad.buttonDown.y = FlxG.height - 201;
		vpad.buttonRight.x = FlxG.width - 132;
		vpad.buttonRight.y = FlxG.height - 309;
		vpad.buttonLeft.x = FlxG.width - 384;
		vpad.buttonLeft.y = FlxG.height - 309;
	}

	function loadCustom():Void
	{
		vpad = config.loadcustom(vpad);
	}
}

enum ControlsGroup
{
	VIRTUALPAD_RIGHT;
	VIRTUALPAD_LEFT;
	VIRTUALPAD_CUSTOM;
	DUO;
	HITBOX;
	KEYBOARD;
}
