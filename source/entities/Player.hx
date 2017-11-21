package entities;

import flixel.FlxSprite;
import flixel.addons.tile.FlxTilemapExt;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import flixel.tile.FlxTilemap;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author Aleman5
 */
 enum States{ MOVE; SPACED; FLICKERING; DEATH; }
 enum StatesFaces{ UP; DOWN; LEFT; RIGHT; }
 
class Player extends FlxSprite 
{
	// Player things
	private var whichPlayer:Int; // Determines the Player we are talking about
	private var velHor:Float; 	 // Appears in ghosted()
	private var velVer:Float; 	 // 
	private var timer:Int; 		 // Used in States 'MOVE' and 'SPACED'
	private var currentState:States;
	public var currentStateFace(get, null):StatesFaces;
	public var gotHitByGoingRight(default, set):Bool;
	public var gotHitByGoingLeft(default, set):Bool;
	public var gotHitByGoingUp(default, set):Bool;
	public var gotHitByGoingDown(default, set):Bool;
	public var amICollide(get, null):Bool;
	// Boost things
	private var timerBoost:Int; 	// It´s the lifetime of 'boost'
	private var timerUnBoost:Int; 	// 						'unBoost'
	private var timerShield:Int; 	// 						'shield'
	private var timerX2:Int;
	private var boost:Bool; 	// Determines if PowerUp 'boost' is actived
	private var unBoost:Bool;  	// 						 'unBoost'
	private var shield:Bool; 	// 						 'shield'
	private var x2PwUp:Bool;	//						 'x2'
	private var timerGhosted:Int;
	// Points things
	public var score(get, null):Int;
	private var scoreTxt:FlxText;
	
	public function new(?X:Float=0, ?Y:Float=0 , WhichPlayer:Int) 
	{
		super(X, Y);
		
		// Variables inicialization
		whichPlayer = WhichPlayer;
		velHor = 0;
		velVer = 0;
		timer = 0;
		gotHitByGoingRight = false;
		gotHitByGoingLeft = false;
		gotHitByGoingUp = false;
		gotHitByGoingDown = false;
		amICollide = false;
		timerBoost = 0;
		timerUnBoost = 0;
		timerShield = 0;
		timerX2 = 0;
		boost = false;
		unBoost = false;
		shield = false;
		x2PwUp = false;
		timerGhosted = 0;
		score = 0;
		setFacingFlip(FlxObject.RIGHT, true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		// Player creator
		switch (whichPlayer) 
		{
			case 1:
				loadGraphic(AssetPaths.red__png, true, 40, 32);
				velocity.x = Reg.speed;
				facing = FlxObject.RIGHT;
				currentStateFace = StatesFaces.RIGHT;
				scoreTxt = new FlxText(18, 8, 0, "", 16, true);
				scoreTxt.color = FlxColor.RED;
			case 2:
				loadGraphic(AssetPaths.blue__png, true, 40, 32);
				velocity.x = -Reg.speed;
				facing = FlxObject.LEFT;
				currentStateFace = StatesFaces.LEFT;
				scoreTxt = new FlxText(790,575, 0, "", 16, true);
				scoreTxt.color = FlxColor.BLUE;
			case 3:
				loadGraphic(AssetPaths.green__png, true, 40, 32);
				velocity.y = Reg.speed;
				facing = FlxObject.RIGHT;
				set_angle(90);
				currentStateFace = StatesFaces.DOWN;
				scoreTxt = new FlxText(790, 8, 0, "", 16, true);
				scoreTxt.color = FlxColor.GREEN;
			case 4:
				loadGraphic(AssetPaths.yellow__png, true, 40, 32);
				velocity.y = -Reg.speed;
				facing = FlxObject.LEFT;
				set_angle(90);
				currentStateFace = StatesFaces.UP;
				scoreTxt = new FlxText(18, 575, 0, "", 16, true);
				scoreTxt.color = FlxColor.YELLOW;
		}
		currentState = States.MOVE;
		FlxG.state.add(scoreTxt);
		//	Animation creator
		animation.add("move", [7, 1, 20], 8, true);
		animation.add("moveBoost", [21, 15, 9], 8, true);
		animation.add("moveUnBoost", [10, 4, 23], 8, true);
		animation.add("moveShield", [14, 8, 2], 8, true);
		animation.add("moveShieldBoost", [3, 22, 16], 8, true);
		animation.add("moveShieldUnBoost", [17, 11, 5], 8, true);
		animation.add("spaced", [18], 6, false);
		animation.add("death", [12, 6, 0, 19, 13], 8, false);
	}
	override public function update(elapsed:Float)
	{
		if (currentState != States.FLICKERING || !Reg.paused)
		{
			boolDurationTest();
			stateFacesMachine();
			scoreTxt.text = "Player " + whichPlayer + ": " + score;
		}
		setScoreReg();
		stateMachine();
		super.update(elapsed);
		
	}
	function setScoreReg()
	{
		switch (whichPlayer){
			case 1:
				Reg.p1Score = score;
			case 2:
				Reg.p2Score = score;
			case 3:
				Reg.p3Score = score;
			case 4:
				Reg.p4Score = score;
		}
	}
	function stateFacesMachine() 
	{
		switch (currentStateFace) 
		{
			case StatesFaces.RIGHT:
				if (boost)
					velocity.x = Reg.speedBoost;
				else if (unBoost)
					velocity.x = Reg.speedUnBoost;
				else 
					velocity.x = Reg.speed;
				velocity.y = 0;
			case StatesFaces.LEFT:
				if (boost)
					velocity.x = -Reg.speedBoost;
				else if (unBoost)
					velocity.x = -Reg.speedUnBoost;
				else 
					velocity.x = -Reg.speed;
				velocity.y = 0;
			case StatesFaces.DOWN:
				velocity.x = 0;
				if (boost)
					velocity.y = Reg.speedBoost;
				else if (unBoost)
					velocity.y = Reg.speedUnBoost;
				else 
					velocity.y = Reg.speed;
			case StatesFaces.UP:
				velocity.x = 0;
				if (boost)
					velocity.y = -Reg.speedBoost;
				else if (unBoost)
					velocity.y = -Reg.speedUnBoost;
				else 
					velocity.y = -Reg.speed;
		}
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
		// x2
		if (x2PwUp)
		{
			timerX2++;
			if (timerX2 >= 240)
			{
				timerX2 = 0;
				x2PwUp = false;
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
			case States.FLICKERING:
				velocity.set(0, 0);
				amICollide = true;
				if (!FlxFlicker.isFlickering(this))
				{
					amICollide = false;
					currentState = States.MOVE;
				}
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
		if (gotHitByGoingLeft)
		{
			isShielded();
			currentStateFace = StatesFaces.RIGHT;
			facing = FlxObject.RIGHT;
			set_angle(0);
			x += 10;
			gotHitByGoingLeft = false;
		}
		if (gotHitByGoingRight)
		{
			isShielded();
			currentStateFace = StatesFaces.LEFT;
			facing = FlxObject.LEFT;
			set_angle(0);
			x -= 10;
			gotHitByGoingRight = false;
		}
		if (gotHitByGoingUp)
		{
			isShielded();
			currentStateFace = StatesFaces.DOWN;
			facing = FlxObject.RIGHT;
			set_angle(90);
			y += 10;
			gotHitByGoingUp = false;
		}
		if (gotHitByGoingDown)
		{
			isShielded();
			currentStateFace = StatesFaces.UP;
			facing = FlxObject.LEFT;
			set_angle(90);
			y -= 10;
			gotHitByGoingDown = false;
		}
	}
	function movementAndOthers()
	{
		timer++;
		timerGhosted++;
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
				if (FlxG.keys.justPressed.CONTROL)
					ghosted();
			case 3:
				if(timer >= 5)
					movementPlayer3();
				if (FlxG.keys.justPressed.B)
					ghosted();
			case 4:
				if (timer >= 5)
					movementPlayer4();
				if (FlxG.keys.justPressed.NUMPADNINE)
					ghosted();
		}
	}
	function ghosted()
	{
		if (timerGhosted > 25)
		{
			timerGhosted = 0;
			timer = 0;
			velHor = velocity.x * 1.5;
			velVer = velocity.y * 1.5;
			currentState = States.SPACED;
		}
	}
	function movementPlayer1() // ↑ W 	↓ S 	← A 	→ D		 # Q
	{
		if (FlxG.keys.justPressed.D && currentStateFace != StatesFaces.LEFT)
			moveRight();
		if (FlxG.keys.justPressed.A && currentStateFace != StatesFaces.RIGHT)
			moveLeft();
		if (FlxG.keys.justPressed.W && currentStateFace != StatesFaces.DOWN)
			moveUp();
		if (FlxG.keys.justPressed.S && currentStateFace != StatesFaces.UP)
			moveDown();
	}
	function movementPlayer2() // ↑ UP 	↓ DOWN 	← LEFT 	→ RIGHT  # CONTROL
	{
		if (FlxG.keys.justPressed.RIGHT && currentStateFace != StatesFaces.LEFT)
			moveRight();
		if (FlxG.keys.justPressed.LEFT && currentStateFace != StatesFaces.RIGHT)
			moveLeft();
		if (FlxG.keys.justPressed.UP && currentStateFace != StatesFaces.DOWN)
			moveUp();
		if (FlxG.keys.justPressed.DOWN && currentStateFace != StatesFaces.UP)
			moveDown();
	}
	function movementPlayer3() // ↑ I 	↓ K 	← J 	→ L		 # B
	{
		if (FlxG.keys.justPressed.L && currentStateFace != StatesFaces.LEFT)
			moveRight();
		if (FlxG.keys.justPressed.J && currentStateFace != StatesFaces.RIGHT)
			moveLeft();
		if (FlxG.keys.justPressed.I && currentStateFace != StatesFaces.DOWN)
			moveUp();
		if (FlxG.keys.justPressed.K && currentStateFace != StatesFaces.UP)
			moveDown();
	}
	function movementPlayer4() // ↑ 8 	↓ 5 	← 4 	→ 6 	 # 9		(from the 'pad')
	{
		if (FlxG.keys.justPressed.NUMPADSIX && currentStateFace != StatesFaces.LEFT)
			moveRight();
		if (FlxG.keys.justPressed.NUMPADFOUR && currentStateFace != StatesFaces.RIGHT)
			moveLeft();
		if (FlxG.keys.justPressed.NUMPADEIGHT && currentStateFace != StatesFaces.DOWN)
			moveUp();
		if (FlxG.keys.justPressed.NUMPADFIVE && currentStateFace != StatesFaces.UP)
			moveDown();
	}
	function moveRight()
	{
		currentStateFace = StatesFaces.RIGHT;
		facing = FlxObject.RIGHT;
		set_angle(0);
		timer = 0;
	}
	function moveLeft()
	{
		currentStateFace = StatesFaces.LEFT;
		facing = FlxObject.LEFT;
		set_angle(0);
		timer = 0;
	}
	function moveUp()
	{
		currentStateFace = StatesFaces.UP;
		facing = FlxObject.LEFT;
		set_angle(90);
		timer = 0;
	}
	function moveDown()
	{
		currentStateFace = StatesFaces.DOWN;
		facing = FlxObject.RIGHT;
		set_angle(90);
		timer = 0;
	}
	function isShielded() 
	{
		if (!shield)
			changeToFlickering();
		else
		{
			timerShield = 0;
			shield = false;
		}
	}
	function changeToFlickering()
	{
		FlxG.sound.play(AssetPaths.collision__wav);
		currentState = States.FLICKERING;
		animation.play("spaced");
		boost = false;
		unBoost = false;
		shield = false;
		FlxFlicker.flicker(this, 1, 0.1, true, true);
	}
	public function set_gotHitByGoingRight(?value:Bool = true):Bool 
	{
		return gotHitByGoingRight = value;
	}
	public function set_gotHitByGoingLeft(?value:Bool = true):Bool 
	{
		return gotHitByGoingLeft = value;
	}
	public function set_gotHitByGoingUp(?value:Bool = true):Bool 
	{
		return gotHitByGoingUp = value;
	}
	public function set_gotHitByGoingDown(?value:Bool = true):Bool 
	{
		return gotHitByGoingDown = value;
	}
	public function get_currentStateFace():StatesFaces 
	{
		return currentStateFace;
	}
	public function get_amICollide():Bool
	{
		return amICollide;
	}
	public function whichPwUp(value:Int):Void
	{
		switch (value) 
		{
			case 0:
				FlxG.sound.play(AssetPaths.boost__wav);
				if (boost)
					timerBoost = 0;
				boost = true;
			case 1:
				FlxG.sound.play(AssetPaths.oildrop__wav);
				if (unBoost)
					timerUnBoost = 0;
				unBoost = true;
			case 2:
				FlxG.sound.play(AssetPaths.shield__wav);
				if (shield)
					timerShield = 0;
				shield = true;
			case 3:
				FlxG.sound.play(AssetPaths.gem1__wav);
				if (x2PwUp)
					score += 20;
				else
					score += 10;
			case 4:
				FlxG.sound.play(AssetPaths.gem2__wav);
				if (x2PwUp)
					score += 50;
				else
					score += 25;
			case 5:
				FlxG.sound.play(AssetPaths.gem3__wav);
				if (x2PwUp)
					score += 100;
				else
					score += 50;
			case 6:
				FlxG.sound.play(AssetPaths.multiplier__wav);
				if (x2PwUp)
					timerX2 = 0;
				x2PwUp = true;
			case 7:
				FlxG.sound.play(AssetPaths.badgem__wav);
				if (score > 25)
				{
					if (x2PwUp && score>50)
						score -= 50;
					else
						score -= 25;
				}
		}
	}
	public function get_score():Int 
	{
		return score;
	}
}