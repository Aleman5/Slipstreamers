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
		loadGraphic(AssetPaths.powerups2__png, true, 32, 32);
		animation.add("maxSpeed", [0,1,2],6,true);
		animation.add("minSpeed", [3,4,5],6,true);
		animation.add("shield", [6,7,8],6,true);
		switch (whichPowerUp) 
		{
			case 0:
				animation.play("maxSpeed");
			case 1:
				animation.play("minSpeed");
			case 2:
				animation.play("shield");
		}
		updateHitbox();
	}
	public function get_whichPowerUp():Int 
	{
		return whichPowerUp;
	}
}