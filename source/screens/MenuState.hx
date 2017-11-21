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
		var copyright:FlxText = new FlxText(3, 585,0, "By: Abecaxis Alejandro & Perugini Leo",16);
		FlxG.sound.play(AssetPaths.menu__wav, 0.5);
		var fondo:FlxSprite = new FlxSprite (0, 0, AssetPaths.PORTADA__png);
		var butonNew:FlxButton = new FlxButton(575, 500, " ", onNew); //Boton de inicio
		butonNew.loadGraphic(AssetPaths.boton__png, true, 344, 60);
		
		var singlePlayer:FlxButton = new FlxButton(575, 435, " ", one);
		singlePlayer.loadGraphic(AssetPaths.single__png, true, 396, 60);
		
		add(fondo);
		add(butonNew);
		add(singlePlayer);
		add(copyright);
	}
	
	private function onNew(): Void
	{
		var levelSelector:LevelSelector = new LevelSelector();
		FlxG.switchState(levelSelector);	
	}
	private function one(): Void
	{
		var onelvl:OnePlayerGame = new OnePlayerGame();
		FlxG.switchState(onelvl);
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