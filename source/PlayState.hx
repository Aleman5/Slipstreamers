package;

import entities.Player;
import entities.Items;
import entities.Trail;
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
	private var howMuchP:Int;
	// PowerUps
	private var whichPUp:Int;
	private var posX:Int;
	private var posY:Int;
	private var timer:Int;
	private var timeTimed:Int;
	private var r:FlxRandom;
	private var pUp:Items;
	private var pUps:FlxTypedGroup<Items>;
	
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = 0xBB7744FF;
		howMuchP = Reg.howMuch;
		timer = 200;
		timeTimed = 0;
		posX = 0;
		posY = 0;
		whichPUp = 0;
		r = new FlxRandom();
		players = new FlxTypedGroup();
		
		switch (howMuchP) 
		{
			case 2:
				player1 = new Player(camera.width / 4, camera.height / 4, 1);
				player2 = new Player(camera.width * 3 / 4, camera.height * 3 / 4, 2);
				players.add(player1);
				players.add(player2);
				
			case 3:
				player1 = new Player(camera.width / 4, camera.height / 4, 1);
				player2 = new Player(camera.width * 3 / 4, camera.height * 3 / 4, 2);
				player3 = new Player(camera.width * 3 / 4, camera.height / 4, 3);
				players.add(player1);
				players.add(player2);
				players.add(player3);
				
			case 4:
				player1 = new Player(camera.width / 4, camera.height / 4, 1);
				player2 = new Player(camera.width * 3 / 4, camera.height * 3 / 4, 2);
				player3 = new Player(camera.width * 3 / 4, camera.height / 4, 3);
				player4 = new Player(camera.width / 4, camera.height * 3 / 4, 4);
				players.add(player1);
				players.add(player2);
				players.add(player3);
				players.add(player4);
				
		}
		pUps = new FlxTypedGroup();
		add(players);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		powerUpCreator();
		collisions();
		levelReset();
	}
	private function levelReset():Void
	{
		if (FlxG.keys.justPressed.R)
			FlxG.resetState();
	}
	private function powerUpCreator():Void
	{
		timeTimed++;
		if (timeTimed >= timer)
		{
			posX = r.int(3, 1005);
			posY = r.int(3, 600);
			whichPUp = r.int(0, 2);
			pUp = new Items(posX, posY, whichPUp);
			pUps.add(pUp);
			add(pUps);
			
			timeTimed = 0;
			timer = r.int(150, 210);
		}
	}
	private function powered(p:Player, pU:Items):Void
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
			/*case 3:
				p.set_score(20);
			case 4:
				p.set_score(50);
			case 5:
				p.set_score(100);
			case 6:
				p.set_score(-15);*/
		}
		pU.kill();
	}
	private function colTilemap(p:Player, dinopianito:Int) 
	{
		whatShouldIDo(p);
	}
	private function colBtwPlayers(p1:Player, p2:Player):Void
	{
		if(!p1.get_amICollide())
			whatShouldIDo(p1);
		if(!p2.get_amICollide())
			whatShouldIDo(p2);
	}
	private function whatShouldIDo(p:Player):Void
	{
		switch (p.get_currentStateFace()) 
		{
			case StatesFaces.RIGHT:
				p.set_gotHitByGoingRight();
			case StatesFaces.LEFT:
				p.set_gotHitByGoingLeft();
			case StatesFaces.UP:
				p.set_gotHitByGoingUp();
			case StatesFaces.DOWN:
				p.set_gotHitByGoingDown();
		}
	}
	private function collisions():Void
	{
		FlxG.overlap(players, pUps, powered);
		//FlxG.collide(players, tilemap, colTilemap);
		FlxG.collide(players, players, colBtwPlayers);
	}
}