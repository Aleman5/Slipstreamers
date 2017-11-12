package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Aleman5
 */
class Items extends FlxSprite 
{
	public var whichPowerUp(get, null):Int;
	
	public function new(?X:Float=0, ?Y:Float=0, WhichPowerUp:Int) 
	{
		super(X, Y);
		whichPowerUp = WhichPowerUp;
		loadGraphic(AssetPaths.newPowerups__png, true, 32, 32);
		animation.add("maxSpeed", [5,6,7],8,true);
		animation.add("minSpeed", [8],6,true);
		animation.add("shield", [9, 10, 11], 8, true);
		animation.add("+10", [0], 8, true);
		animation.add("+25", [1], 8, true);
		animation.add("+50", [2], 8, true);
		animation.add("x2", [3], 8, true);
		animation.add("-10", [4], 8, true);
		
		switch (whichPowerUp) 
		{
			case 0:
				animation.play("maxSpeed");
			case 1:
				animation.play("minSpeed");
			case 2:
				animation.play("shield");
			case 3:
				animation.play("+10");
			case 4:
				animation.play("+25");
			case 5:
				animation.play("+50");
			case 6:
				animation.play("x2");
			case 7:
				animation.play("-10");
		}
		updateHitbox();
	}
	public function get_whichPowerUp():Int 
	{
		return whichPowerUp;
	}
}