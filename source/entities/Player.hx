package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author Aleman5
 */

 enum States
 {
	MOVE;
	SPACED;
	DEATH;
 }
 
class Player extends FlxSprite 
{
	private var whichPlayer:Int;
	private var movHor:Bool;
	private var movVer:Bool;
	private var velHor:Float;
	private var velVer:Float;
	private var timer:Int;
	private var currentState:States;
	
	public function new(?X:Float=0, ?Y:Float=0, WhichPlayer:Int) 
	{
		super(X, Y);
		whichPlayer = WhichPlayer; // Determines the Player we are talking about
		movHor = false; // Exists to ask if PlayerX change movement horizontal
		movVer = true;  // Exists to ask if PlayerX change movement vertical
		velHor = 0;		// Receives the actually velocity.x
		velVer = 0;		// Receives the actually velocity.y
		timer = 0;		// Used in States 'MOVE' and 'SPACED'
		setFacingFlip(FlxObject.RIGHT, true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.UP, true, false);
		setFacingFlip(FlxObject.DOWN, false, true);
		
		switch (whichPlayer) 
		{
			case 1:
				loadGraphic(AssetPaths.player1__png, true, 16, 8);
				scale.set(2, 2);
				updateHitbox();
				animation.play("move");
				velocity.x = Reg.speed;
				facing = FlxObject.RIGHT;
			case 2:
				loadGraphic(AssetPaths.player2__png, true, 16, 8);
				scale.set(2, 2);
				updateHitbox();
				animation.play("move");
				velocity.x = -Reg.speed;
				facing = FlxObject.LEFT;
		}
		
		currentState = States.MOVE;
		animation.add("move", [0, 1, 2], 6, true); 	// Movement
		animation.add("spaced", [3], 6, false); 	// When State.SPACED is actived
		animation.add("death", [5, 6, 7, 8, 9], 5, false);	// Death animation
	}
	
	override public function update(elapsed:Float)
	{
		stateMachine();
		super.update(elapsed);
	}
	
	function stateMachine() 
	{
		switch (currentState) 
		{
			case States.MOVE:
				animation.play("move");
				movementAndOthers();
				checkBoundaries();
			case States.SPACED:
				animation.play("spaced");
				velocity.x = velHor;
				velocity.y = velVer;
				timer++;
				if (timer >= 50)
				{
					timer = 0;
					currentState = States.MOVE;
				}
				checkBoundaries();
			case States.DEATH:
				velocity.set(0, 0);
				if (animation.name == "death" && animation.finished)
					kill();
		}
	}
	function checkBoundaries()
	{
		if (x <= 1)					 		die();
		if (x >= camera.width - width - 2)	die();
		if (y <= 3)							die();
		if (y >= camera.height - height - 2)die();
	}
	public function die()
	{
		currentState = States.DEATH;
			animation.play("death");
	}
	function movementAndOthers()
	{
		timer++;
		
		switch (whichPlayer) 
		{
			case 1:
				if(timer >= 5)
					movementPlayer1();
				if (FlxG.keys.justPressed.Q)
					ghosted();
			case 2:
				if (timer >= 5)
					movementPlayer2();
				if (FlxG.keys.justPressed.ZERO)
					ghosted();
		}
	}
	function ghosted()
	{
		timer = 0;
		velHor = velocity.x;
		velVer = velocity.y;
		currentState = States.SPACED;
	}
	function movementPlayer1()
	{
		if (FlxG.keys.justPressed.D && movHor == true){
			moveRight();
			facing = FlxObject.RIGHT;
		}
		if (FlxG.keys.justPressed.A && movHor == true){
			moveLeft();
			facing = FlxObject.LEFT;
		}
		if (FlxG.keys.justPressed.W && movVer == true){
			moveUp();
			facing = FlxObject.UP; // In process
		}
		if (FlxG.keys.justPressed.S && movVer == true){
			moveDown();
			facing = FlxObject.DOWN; // In process
		}
	}
	function movementPlayer2()
	{
		if (FlxG.keys.justPressed.RIGHT && movHor == true){
			moveRight();
			facing = FlxObject.RIGHT;
		}
		if (FlxG.keys.justPressed.LEFT && movHor == true){
			moveLeft();
			facing = FlxObject.LEFT;
		}
		if (FlxG.keys.justPressed.UP && movVer == true){
			moveUp();
			facing = FlxObject.UP;
		}
		if (FlxG.keys.justPressed.DOWN && movVer == true){
			moveDown();
			facing = FlxObject.DOWN;
		}
	}
	function moveRight()
	{
		velocity.x = Reg.speed;
		velocity.y = 0;
		movVer = true;
		movHor = false;
		timer = 0;
	}
	function moveLeft()
	{
		velocity.x = -Reg.speed;
		velocity.y = 0;
		movVer = true;
		movHor = false;
		timer = 0;
	}
	function moveUp()
	{
		velocity.x = 0;
		velocity.y = -Reg.speed;
		movVer = false;
		movHor = true;
		timer = 0;
	}
	function moveDown()
	{
		velocity.x = 0;
		velocity.y = Reg.speed;
		movVer = false;
		movHor = true;
		timer = 0;
	}
}