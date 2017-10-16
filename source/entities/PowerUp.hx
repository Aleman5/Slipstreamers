package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Aleman5
 */
class PowerUp extends FlxSprite 
{
	public var whichPowerUp(get, null):Int;
	
	public function new(?X:Float=0, ?Y:Float=0, WhichPowerUp:Int) 
	{
		super(X, Y);
		whichPowerUp = WhichPowerUp;
		loadGraphic(AssetPaths.powerUps__png, false, 11, 9);
		animation.add("maxSpeed", [0]);
		animation.add("minSpeed", [1]);
		animation.add("shield", [2]);
		switch (whichPowerUp) 
		{
			case 0:
				animation.play("maxSpeed");
			case 1:
				animation.play("minSpeed");
			case 2:
				animation.play("shield");
		}
	}
	function get_whichPowerUp():Int 
	{
		return whichPowerUp;
	}
}