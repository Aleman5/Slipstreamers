package screens;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;


class EndGame extends FlxState 
{
	var p1S:Int;
	var p2S:Int;
	var p3S:Int;
	var p4S:Int;
	var playersCant:Int;
	var scoreRed:FlxText;
	var scoreBlue:FlxText;
	var scoreGreen:FlxText;
	var scoreYellow:FlxText;
	var fondo:FlxSprite;

	override public function create():Void
	{
		p1S = Reg.p1Score;
		p2S = Reg.p2Score;
		p3S = Reg.p3Score;
		p4S = Reg.p4Score;
		playersCant = Reg.howMuch;
		
		scoreRed = new FlxText(650, 260, 0, "", 32, true);
		scoreRed.setFormat(AssetPaths.ELEMENTS__TTF,32);
		scoreRed.color = FlxColor.RED;
		scoreRed.text = "Player 1 : " + p1S;
		
		scoreBlue = new FlxText(650, scoreRed.y+40, 0, "", 32, true);
		scoreBlue.setFormat(AssetPaths.ELEMENTS__TTF,32);
		scoreBlue.color = FlxColor.BLUE;
		scoreBlue.text = "Player 2 : " + p2S;
		
		scoreGreen = new FlxText(650, scoreBlue.y+40, 0, "", 32, true);
		scoreGreen.setFormat(AssetPaths.ELEMENTS__TTF,32);
		scoreGreen.color = FlxColor.LIME;
		scoreGreen.text = "Player 2 : " + p3S;
		
		scoreYellow = new FlxText(650, scoreGreen.y+40, 0, "", 32, true);
		scoreYellow.setFormat(AssetPaths.ELEMENTS__TTF,32);
		scoreYellow.color = FlxColor.YELLOW;
		scoreYellow.text = "Player 4 : " + p4S;
		switch (playersCant)
		{
			case 2:
				if (p1S > p2S)
				{
					fondo = new FlxSprite(0, 0, AssetPaths.Winp1__png);
					add(fondo);
					add(scoreRed);
					add(scoreBlue);
				}
				if (p2S > p1S)
				{
					fondo = new FlxSprite(0, 0, AssetPaths.Winp2__png);
					add(fondo);
					add(scoreRed);
					add(scoreBlue);
				}
			case 3:
				if (p1S > p2S && p1S > p3S)
				{
					fondo = new FlxSprite(0, 0, AssetPaths.Winp1__png);
					add(fondo);
					add(scoreRed);
					add(scoreBlue);
					add(scoreGreen);
				}
				if (p2S > p1S && p2S > p3S)
				{
					fondo = new FlxSprite(0, 0, AssetPaths.Winp2__png);
					add(fondo);
					add(scoreRed);
					add(scoreBlue);
					add(scoreGreen);
				}
				if (p3S > p1S && p3S > p2S)
				{
					fondo = new FlxSprite(0, 0, AssetPaths.Winp3__png);
					add(fondo);
					add(scoreRed);
					add(scoreBlue);
					add(scoreGreen);
				}
			case 4:
				if (p1S > p2S && p1S > p3S && p1S > p4S)
				{
					fondo = new FlxSprite(0, 0, AssetPaths.Winp1__png);
					add(fondo);
					add(scoreRed);
					add(scoreBlue);
					add(scoreGreen);
					add(scoreYellow);
				}
				if (p2S > p1S && p2S > p3S && p2S > p4S)
				{
					fondo = new FlxSprite(0, 0, AssetPaths.Winp2__png);
					add(fondo);
					add(scoreRed);
					add(scoreBlue);
					add(scoreGreen);
					add(scoreYellow);
				}
				if (p3S > p1S && p3S > p2S && p3S > p4S)
				{
					fondo = new FlxSprite(0, 0, AssetPaths.Winp3__png);
					add(fondo);
					add(scoreRed);
					add(scoreBlue);
					add(scoreGreen);
					add(scoreYellow);
				}
				if (p4S > p1S && p4S > p2S && p4S > p3S)
				{
					fondo = new FlxSprite(0, 0, AssetPaths.Winp4__png);
					add(fondo);
					add(scoreRed);
					add(scoreBlue);
					add(scoreGreen);
					add(scoreYellow);
				}
		}
	}
	
}