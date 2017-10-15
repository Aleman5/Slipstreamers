package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author Aleman5
 */
class Player extends FlxSprite 
{
	private var whichPlayer:Int;
	private var movHor:Bool;
	private var movVer:Bool;
	private var framesBtwMove:Int;
	
	public function new(?X:Float=0, ?Y:Float=0, WhichPlayer:Int) 
	{
		super(X, Y);
		whichPlayer = WhichPlayer;
		movHor = false;
		movVer = true;
		framesBtwMove = 0;
		setFacingFlip(FlxObject.RIGHT, true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		
		animation.add("move", [0, 1, 2], 6, true);
		animation.add("spaced", [3], 6, false); // Si apreta espacio se deja de mover por unos frames
												// pero puede atravesar las estelas
		animation.add("death", [5, 6, 7, 8, 9], 6, false);
		
		switch (whichPlayer) 
		{
			case 1:
				loadGraphic(AssetPaths.player1__png, true, 16, 8);
				scale.set(2, 2);
				updateHitbox();
				animation.play("move");
				velocity.x = Reg.speed;
			case 2:
				loadGraphic(AssetPaths.player2__png, true, 16, 8);
				scale.set(2, 2);
				updateHitbox();
				animation.play("move");
				velocity.x = -Reg.speed;
		}
		
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		framesBtwMove++;
		
		switch (whichPlayer) 
		{
			case 1:
				if(framesBtwMove >= 5)
					movementPlayer1();
				rotationPlayer();
			case 2:
				if(framesBtwMove >= 5)
					movementPlayer2();
				rotationPlayer();
		}
	}
	
	function movementPlayer1():Void 
	{
		if (FlxG.keys.justPressed.D && movHor == true){
			velocity.x = Reg.speed;
			velocity.y = 0;
			movVer = true;
			movHor = false;
			framesBtwMove = 0;
		}
		if (FlxG.keys.justPressed.A && movHor == true){
			velocity.x = -Reg.speed;
			velocity.y = 0;
			movVer = true;
			movHor = false;
			framesBtwMove = 0;
		}
		if (FlxG.keys.justPressed.W && movVer == true){
			velocity.x = 0;
			velocity.y = -Reg.speed;
			movVer = false;
			movHor = true;
			framesBtwMove = 0;
		}
		if (FlxG.keys.justPressed.S && movVer == true){
			velocity.x = 0;
			velocity.y = Reg.speed;
			movVer = false;
			movHor = true;
			framesBtwMove = 0;
		}
		
		
	}
	function movementPlayer2():Void 
	{
		if (FlxG.keys.justPressed.RIGHT && movHor == true){
			velocity.x = Reg.speed;
			velocity.y = 0;
			movVer = true;
			movHor = false;
			framesBtwMove = 0;
		}
		if (FlxG.keys.justPressed.LEFT && movHor == true){
			velocity.x = -Reg.speed;
			velocity.y = 0;
			movVer = true;
			movHor = false;
			framesBtwMove = 0;
		}
		if (FlxG.keys.justPressed.UP && movVer == true){
			velocity.x = 0;
			velocity.y = -Reg.speed;
			movVer = false;
			movHor = true;
			framesBtwMove = 0;
		}
		if (FlxG.keys.justPressed.DOWN && movVer == true){
			velocity.x = 0;
			velocity.y = Reg.speed;
			movVer = false;
			movHor = true;
			framesBtwMove = 0;
		}
	}
	
	function rotationPlayer():Void // In process
	{
		if (velocity.x > 0)
			facing = FlxObject.RIGHT;
		else if(velocity.x < 0)
			facing = FlxObject.LEFT;
		//if (velocity.y > 0)
		//else if (velocity.y < 0)
	}
}