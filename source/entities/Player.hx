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
	// Player things
	private var whichPlayer:Int; // Determines the Player we are talking about
	private var movHor:Bool; 	 // Exists to ask if PlayerX change movement horizontal
	private var movVer:Bool; 	 // Exists to ask if PlayerX change movement vertical
	private var velHor:Float; 	 // Receives the actually velocity.x
	private var velVer:Float; 	 // Receives the actually velocity.y
	private var timer:Int; 		 // Used in States 'MOVE' and 'SPACED'
	private var currentState:States;
	// Boost things
	private var timerBoost:Int; 	// It´s the lifetime of 'boost'
	private var timerUnBoost:Int; 	// It´s the lifetime of 'unBoost'
	private var timerShield:Int; 	// It´s the lifetime of 'shield'
	public var boost(get, null):Bool; 	// Determines if PowerUp 'boost' is actived
	public var unBoost(get, null):Bool; // Determines if PowerUp 'unBoost' is actived
	public var shield(get, null):Bool; 	// Determines if PowerUp 'shield' is actived
	
	public function new(?X:Float=0, ?Y:Float=0, WhichPlayer:Int) 
	{
		super(X, Y);
		
		// Variable inicialization
		whichPlayer = WhichPlayer;
		velHor = 0;
		velVer = 0;
		timer = 0;
		timerBoost = 0;
		timerUnBoost = 0;
		timerShield = 0;
		boost = false;
		unBoost = false;
		shield = false;
		setFacingFlip(FlxObject.RIGHT, true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.UP, true, false);
		setFacingFlip(FlxObject.DOWN, false, true);
		
		// Player creator
		switch (whichPlayer) 
		{
			case 1:
				loadGraphic(AssetPaths.player1__png, true, 16, 8);
				scale.set(2, 2);
				updateHitbox();
				movHor = false;
				movVer = true;
				animation.play("move");
				velocity.x = Reg.speed;
				facing = FlxObject.RIGHT;
			case 2:
				loadGraphic(AssetPaths.player2__png, true, 16, 8);
				scale.set(2, 2);
				updateHitbox();
				movHor = false;
				movVer = true;
				animation.play("move");
				velocity.x = -Reg.speed;
				facing = FlxObject.LEFT;
			case 3:
				loadGraphic(AssetPaths.player3__png, true, 16, 8);
				scale.set(2, 2);
				updateHitbox();
				movHor = true;
				movVer = false;
				animation.play("move");
				velocity.y = Reg.speed;
				facing = FlxObject.UP;
			case 4:
				loadGraphic(AssetPaths.player4__png, true, 16, 8);
				scale.set(2, 2);
				updateHitbox();
				movHor = true;
				movVer = false;
				animation.play("move");
				velocity.y = -Reg.speed;
				facing = FlxObject.DOWN;
		}
		currentState = States.MOVE;
		
		// Animation creator
		animation.add("move", [0, 1, 2], 6, true); 	// Movement
		animation.add("moveBoost", [3, 4, 5], 6, true);
		animation.add("moveUnBoost", [6, 7, 8], 6, true);
		animation.add("moveShield", [9, 10, 11], 6, true);
		animation.add("moveShieldBoost", [12, 13, 14], 6, true);
		animation.add("moveShieldUnBoost", [15, 16, 17], 6, true);
		animation.add("spaced", [18], 6, false); 	// When State.SPACED is actived
		animation.add("death", [19, 20, 21, 22, 23], 5, false);	// Death animation
	}
	override public function update(elapsed:Float)
	{
		boolDurationTest();
		stateMachine();
		super.update(elapsed);
	}
	function boolDurationTest() 
	{	
		// It cannot live 'boost' and 'unBoost' as true at the same time
		if (boost == true && unBoost == true)
		{
			if (timerBoost > timerUnBoost)
				boost = false;
			else
				unBoost = false;
		}
		// Boost
		if (boost)
		{
			timerBoost++;
			if (timerBoost >= 240)
			{
				timerBoost = 0;
				boost = false;
			}
		}
		// UnBoost
		if (unBoost)
		{
			timerUnBoost++;
			if (timerUnBoost >= 240)
			{
				timerUnBoost = 0;
				unBoost = false;
			}
		}
		// Shield
		if (shield)
		{
			timerShield++;
			if (timerShield >= 300)
			{
				timerShield = 0;
				shield = false;
			}
		}
	}
	function stateMachine() 
	{
		switch (currentState) 
		{
			case States.MOVE:
				movementAndOthers();
				animaSelector();
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
	function animaSelector() 
	{
		if (!boost && !unBoost && !shield)
			animation.play("move");
		else if (shield)
		{
			if (boost)
				animation.play("moveShieldBoost");
			else if (unBoost)
				animation.play("moveShieldUnBoost");
			else
				animation.play("moveShield");
		}
		else if (boost)
			animation.play("moveBoost");
		else if (unBoost)
			animation.play("moveUnBoost");
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
				if (FlxG.keys.justPressed.COMMA)
					ghosted();
			case 3:
				if(timer >= 5)
					movementPlayer3();
				if (FlxG.keys.justPressed.G)
					ghosted();
			case 4:
				if (timer >= 5)
					movementPlayer4();
				if (FlxG.keys.justPressed.NUMPADONE)
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
	function movementPlayer1() // ↑ W 	↓ S 	← A 	→ D		 # Q		// In process
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
	function movementPlayer2() // ↑ UP 	↓ DOWN 	← LEFT 	→ RIGHT  # COMMA
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
	function movementPlayer3() // ↑ U 	↓ J 	← H 	→ K		 # G
	{
		if (FlxG.keys.justPressed.K && movHor == true){
			moveRight();
			facing = FlxObject.RIGHT;
		}
		if (FlxG.keys.justPressed.H && movHor == true){
			moveLeft();
			facing = FlxObject.LEFT;
		}
		if (FlxG.keys.justPressed.U && movVer == true){
			moveUp();
			facing = FlxObject.UP;
		}
		if (FlxG.keys.justPressed.J && movVer == true){
			moveDown();
			facing = FlxObject.DOWN;
		}
	}
	function movementPlayer4() // ↑ 8 	↓ 5 	← 4 	→ 6 	 # 1		(from the 'pad')
	{
		if (FlxG.keys.justPressed.NUMPADSIX && movHor == true){
			moveRight();
			facing = FlxObject.RIGHT;
		}
		if (FlxG.keys.justPressed.NUMPADFOUR && movHor == true){
			moveLeft();
			facing = FlxObject.LEFT;
		}
		if (FlxG.keys.justPressed.NUMPADEIGHT && movVer == true){
			moveUp();
			facing = FlxObject.UP;
		}
		if (FlxG.keys.justPressed.NUMPADFIVE && movVer == true){
			moveDown();
			facing = FlxObject.DOWN;
		}
	}
	function moveRight()
	{
		if (boost)
			velocity.x = Reg.speedBoost;
		else if (unBoost)
			velocity.x = Reg.speedUnBoost;
		else 
			velocity.x = Reg.speed;
		velocity.y = 0;
		movVer = true;
		movHor = false;
		timer = 0;
	}
	function moveLeft()
	{
		if (boost)
			velocity.x = -Reg.speedBoost;
		else if (unBoost)
			velocity.x = -Reg.speedUnBoost;
		else 
			velocity.x = -Reg.speed;
		velocity.y = 0;
		movVer = true;
		movHor = false;
		timer = 0;
	}
	function moveUp()
	{
		velocity.x = 0;
		if (boost)
			velocity.y = -Reg.speedBoost;
		else if (unBoost)
			velocity.y = -Reg.speedUnBoost;
		else 
			velocity.y = -Reg.speed;
		movVer = false;
		movHor = true;
		timer = 0;
	}
	function moveDown()
	{
		velocity.x = 0;
		if (boost)
			velocity.y = Reg.speedBoost;
		else if (unBoost)
			velocity.y = Reg.speedUnBoost;
		else 
			velocity.y = Reg.speed;
		movVer = false;
		movHor = true;
		timer = 0;
	}
	function get_boost():Bool 
	{
		return boost;
	}
	function get_unBoost():Bool 
	{
		return unBoost;
	}
	function get_shield():Bool 
	{
		return shield;
	}
}