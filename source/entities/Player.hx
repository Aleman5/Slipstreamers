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
	private var movVer:Bool; 	 // 				 PlayerY				 vertical
	private var velHor:Float; 	 // Receives the actually velocity.x
	private var velVer:Float; 	 // 					  velocity.y
	private var timer:Int; 		 // Used in States 'MOVE' and 'SPACED'
	private var currentState:States;
	// Boost things
	private var timerBoost:Int; 	// It´s the lifetime of 'boost'
	private var timerUnBoost:Int; 	// 						'unBoost'
	private var timerShield:Int; 	// 						'shield'
	public var boost(default, set):Bool; 	// Determines if PowerUp 'boost' is actived
	public var unBoost(default, set):Bool;  // 						 'unBoost'
	public var shield(default, set):Bool; 	// 						 'shield'
	
	public function new(?X:Float=0, ?Y:Float=0, WhichPlayer:Int) 
	{
		super(X, Y);
		
		// Variables inicialization
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
		// Player creator
		switch (whichPlayer) 
		{
			case 1:
				loadGraphic(AssetPaths.red__png, true, 40, 32);
				updateHitbox();
				movHor = false;
				movVer = true;
				animation.play("move");
				velocity.x = Reg.speed;
				facing = FlxObject.RIGHT;
			case 2:
				loadGraphic(AssetPaths.blue__png, true, 16, 8);
				updateHitbox();
				movHor = false;
				movVer = true;
				animation.play("move");
				velocity.x = -Reg.speed;
				facing = FlxObject.LEFT;
			case 3:
				loadGraphic(AssetPaths.green__png, true, 16, 8);
				updateHitbox();
				movHor = true;
				movVer = false;
				animation.play("move");
				velocity.y = Reg.speed;
				facing = FlxObject.LEFT;
				set_angle(90);
			case 4:
				loadGraphic(AssetPaths.yellow__png, true, 16, 8);
				updateHitbox();
				movHor = true;
				movVer = false;
				animation.play("move");
				velocity.y = -Reg.speed;
				facing = FlxObject.RIGHT;
				set_angle(90);
		}
		currentState = States.MOVE;
		// Animation creator
		animation.add("move", [7, 1, 20], 8, true); 	// Movement
		animation.add("moveBoost", [21, 15, 9], 8, true);
		animation.add("moveUnBoost", [10, 4, 23], 8, true);
		animation.add("moveShield", [14, 8, 2], 8, true);
		animation.add("moveShieldBoost", [3, 22, 16], 8, true);
		animation.add("moveShieldUnBoost", [17, 11, 5], 8, true);
		animation.add("spaced", [18], 6, false); 	// When State.SPACED is actived
		animation.add("death", [12, 6, 0, 19, 13], 8, false);	// Death animation
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
		set_angle(0);
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
	function movementPlayer1() // ↑ W 	↓ S 	← A 	→ D		 # Q
	{
		if (FlxG.keys.justPressed.D && movHor == true){
			moveRight();
			facing = FlxObject.RIGHT;
			set_angle(0);
		}
		if (FlxG.keys.justPressed.A && movHor == true){
			moveLeft();
			facing = FlxObject.LEFT;
			set_angle(0);
		}
		if (FlxG.keys.justPressed.W && movVer == true){
			moveUp();
			facing = FlxObject.LEFT;
			set_angle(90);
		}
		if (FlxG.keys.justPressed.S && movVer == true){
			moveDown();
			facing = FlxObject.RIGHT;
			set_angle(90);
		}
	}
	function movementPlayer2() // ↑ UP 	↓ DOWN 	← LEFT 	→ RIGHT  # COMMA
	{
		if (FlxG.keys.justPressed.RIGHT && movHor == true){
			moveRight();
			facing = FlxObject.RIGHT;
			set_angle(0);
		}
		if (FlxG.keys.justPressed.LEFT && movHor == true){
			moveLeft();
			facing = FlxObject.LEFT;
			set_angle(0);
		}
		if (FlxG.keys.justPressed.UP && movVer == true){
			moveUp();
			facing = FlxObject.LEFT;
			set_angle(90);
		}
		if (FlxG.keys.justPressed.DOWN && movVer == true){
			moveDown();
			facing = FlxObject.RIGHT;
			set_angle(90);
		}
	}
	function movementPlayer3() // ↑ U 	↓ J 	← H 	→ K		 # G
	{
		if (FlxG.keys.justPressed.K && movHor == true){
			moveRight();
			facing = FlxObject.RIGHT;
			set_angle(0);
		}
		if (FlxG.keys.justPressed.H && movHor == true){
			moveLeft();
			facing = FlxObject.LEFT;
			set_angle(0);
		}
		if (FlxG.keys.justPressed.U && movVer == true){
			moveUp();
			facing = FlxObject.LEFT;
			set_angle(90);
		}
		if (FlxG.keys.justPressed.J && movVer == true){
			moveDown();
			facing = FlxObject.RIGHT;
			set_angle(90);
		}
	}
	function movementPlayer4() // ↑ 8 	↓ 5 	← 4 	→ 6 	 # 1		(from the 'pad')
	{
		if (FlxG.keys.justPressed.NUMPADSIX && movHor == true){
			moveRight();
			facing = FlxObject.RIGHT;
			set_angle(0);
		}
		if (FlxG.keys.justPressed.NUMPADFOUR && movHor == true){
			moveLeft();
			facing = FlxObject.LEFT;
			set_angle(0);
		}
		if (FlxG.keys.justPressed.NUMPADEIGHT && movVer == true){
			moveUp();
			facing = FlxObject.LEFT;
			set_angle(90);
		}
		if (FlxG.keys.justPressed.NUMPADFIVE && movVer == true){
			moveDown();
			facing = FlxObject.RIGHT;
			set_angle(90);
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
	public function set_boost(value:Bool):Bool 
	{
		if (!boost)
			return boost = value;
		else
		{
			timerBoost = 0;
			return boost = value;
		}
	}
	public function set_unBoost(value:Bool):Bool 
	{
		if (!unBoost)
			return unBoost = value;
		else
		{
			timerUnBoost = 0;
			return unBoost = value;
		}
	}
	public function set_shield(value:Bool):Bool 
	{
		if(!shield)
			return shield = value;
		else 
		{
			timerShield = 0;
			return shield = value;
		}
	}
}