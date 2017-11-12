package screens;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.ui.FlxButtonPlus;
import flixel.text.FlxText;

class MenuState extends FlxState 
{
	private var fondo:FlxSprite;
	private var splash:FlxSprite;

	override public function create():Void
	{
		super.create();
		
		var fondo:FlxSprite = new FlxSprite (0, 0, AssetPaths.PORTADA__png);
		var butonNew = new FlxButtonPlus(649, 455, onNew, "Start!",230,65); //Boton de inicio
		add(butonNew);
		add(fondo);
	}
	
	private function onNew(): Void
	{
		var levelSelector:LevelSelector = new LevelSelector();
		FlxG.switchState(levelSelector);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}