package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class Cache extends FlxState
{
	var bitmapData:Map<String, FlxGraphic>;
	var images:Array<String> = [];

	override function create()
	{
		FlxG.mouse.visible = false;

		FlxG.worldBounds.set(0, 0);

		bitmapData = new Map<String, FlxGraphic>();

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('loadingScreens/loadingscreen-' + FlxG.random.int(1, 4)));
		menuBG.screenCenter();
		add(menuBG);

		#if sys
		for (i in FileSystem.readDirectory(FileSystem.absolutePath(SUtil.getPath() + "assets/shared/images/characters")))
		{
			if (!i.endsWith(".png"))
				continue;
			images.push(i);
		}
		#end

		sys.thread.Thread.create(() ->
		{
			cache();
		});

		super.create();
	}

	override function update(elapsed)
	{
		super.update(elapsed);
	}

	function cache()
	{
		#if !linux
		#if !android
		for (i in images)
		{
			var data:BitmapData = BitmapData.fromFile(SUtil.getPath() + "assets/shared/images/characters/" + i);
			var graph = FlxGraphic.fromBitmapData(data);
			graph.persist = true;
			graph.destroyOnNoUse = false;
			bitmapData.set(i.replace(".png", ""), graph);
			trace(i);
		}
		#end
		#end
		FlxG.switchState(new TitleState());
	}
}
