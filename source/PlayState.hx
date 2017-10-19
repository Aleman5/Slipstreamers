package;

import entities.Player;
import entities.PowerUp;
import flixel.FlxState;
import flixel.FlxG;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState
{
	// Players
	private var player1:Player;
	private var player2:Player;
	private var player3:Player;
	private var player4:Player;
	private var players:FlxTypedGroup<Player>;
	// PowerUps
	private var whichPUp:Int;
	private var posX:Int;
	private var posY:Int;
	private var timer:Int;
	private var timeTimed:Int;
	private var r:FlxRandom;
	private var pUp:PowerUp;
	private var pUps:FlxTypedGroup<PowerUp>;
	// Collision Getted things
	
	
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = 0xBB7744FF;
		timer = 200;
		timeTimed = 0;
		posX = 0;
		posY = 0;
		whichPUp = 0;
		r = new FlxRandom();
		
		// The creation of this 4 players will change to Array if I create the map selector
		player1 = new Player(camera.width / 4, camera.height / 4, 1);
		player2 = new Player(camera.width * 3 / 4, camera.height * 3 / 4, 2);
		player3 = new Player(camera.width * 3 / 4, camera.height / 4, 3);
		player4 = new Player(camera.width / 4, camera.height * 3 / 4, 4);
		players = new FlxTypedGroup();
		
		pUps = new FlxTypedGroup();
		
		players.add(player1);
		//players.add(player2);
		//players.add(player3);
		//players.add(player4);
		add(players);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		powerUpCreator();
		checkCollisions();
		levelReset();
	}
	function levelReset() 
	{
		if (FlxG.keys.justPressed.R)
			FlxG.resetState();
	}
	function powerUpCreator() 
	{
		timeTimed++;
		if (timeTimed >= timer)
		{
			posX = r.int(3, 1005);
			posY = r.int(3, 750);
			whichPUp = r.int(0, 2);
			pUp = new PowerUp(posX, posY, whichPUp);
			pUps.add(pUp);
			add(pUps);
			
			timeTimed = 0;
			timer = r.int(150, 210);
		}
	}
	public function checkCollisions() 
	{
		FlxG.overlap(players, pUps, powered);
	}
	public function powered(p:Player, pU:PowerUp):Void // In process
	{
		whichPUp = pU.get_whichPowerUp();
		switch (whichPUp) 
		{
			case 0:
				p.set_boost(true);
			case 1:
				p.set_unBoost(true);
			case 2:
				p.set_shield(true);
		}
		//pUps.kill();
		pU.kill();
	}
}