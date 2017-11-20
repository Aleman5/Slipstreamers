package screens;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.ui.FlxButtonPlus;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState 
{
	private var fondo:FlxSprite;
	private var splash:FlxSprite;
	override public function create():Void
	{
		super.create();
		
		var fondo:FlxSprite = new FlxSprite (0, 0, AssetPaths.PORTADA__png);
		var butonNew:FlxButton = new FlxButton(675, 435, " ", onNew); //Boton de inicio
		butonNew.loadGraphic(AssetPaths.boton__png, true, 216, 100);
		
		add(fondo);
		add(butonNew);
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