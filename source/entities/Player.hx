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
		
		animation.add("move", [0, 1, 2], 6, true); 	// Movement
		animation.add("spaced", [3], 6, false); 	// When State.SPACED is actived
		animation.add("death", [5, 6, 7, 8, 9], 3, false);	// Death animation
		
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
		currentState = States.MOVE;
	}
	
	override public function update(elapsed:Float):Void
	{
		stateMachine();
		super.update(elapsed);
	}
	
	function stateMachine() 
	{
		switch (currentState) 
		{
			case States.MOVE:
				movementAndOthers();
				ghosted();
			case States.SPACED:
				animation.play("spaced");
				velocity.x = velHor;
				velocity.y = velVer;
				timer++;
				if (timer >= 60)
				{
					timer = 0;
					currentState = States.MOVE;
				}
			case States.DEATH:
				animation.play("death");
				if (animation.name == "death" && animation.finished)
					destroy();
		}
	}
	function ghosted() 
	{
		if (FlxG.keys.justPressed.Q)
		{
			timer = 0;
			velHor = velocity.x;
			velVer = velocity.y;
			currentState = States.SPACED;
		}
	}
	function movementAndOthers() 
	{
		timer++;
		
		switch (whichPlayer) 
		{
			case 1:
				if(timer >= 5)
					movementPlayer1();
				rotationPlayer();
			case 2:
				if(timer >= 5)
					movementPlayer2();
				rotationPlayer();
		}
	}
	function movementPlayer1():Void 
	{
		if (FlxG.keys.justPressed.D && movHor == true){
			moveRight();
		}
		if (FlxG.keys.justPressed.A && movHor == true){
			moveLeft();
		}
		if (FlxG.keys.justPressed.W && movVer == true){
			moveUp();
		}
		if (FlxG.keys.justPressed.S && movVer == true){
			moveDown();
		}
		
		
	}
	function movementPlayer2():Void 
	{
		if (FlxG.keys.justPressed.RIGHT && movHor == true){
			moveRight();
		}
		if (FlxG.keys.justPressed.LEFT && movHor == true){
			moveLeft();
		}
		if (FlxG.keys.justPressed.UP && movVer == true){
			moveUp();
		}
		if (FlxG.keys.justPressed.DOWN && movVer == true){
			moveDown();
		}
	}
	function moveRight():Void 
	{
		velocity.x = Reg.speed;
		velocity.y = 0;
		movVer = true;
		movHor = false;
		timer = 0;
	}
	function moveLeft():Void 
	{
		velocity.x = -Reg.speed;
		velocity.y = 0;
		movVer = true;
		movHor = false;
		timer = 0;
	}
	function moveUp():Void 
	{
		velocity.x = 0;
		velocity.y = -Reg.speed;
		movVer = false;
		movHor = true;
		timer = 0;
	}
	function moveDown():Void 
	{
		velocity.x = 0;
		velocity.y = Reg.speed;
		movVer = false;
		movHor = true;
		timer = 0;
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