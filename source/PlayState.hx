package;

import entities.Player;
import entities.Items;
import entities.Trail;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.tile.FlxTilemapExt;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;

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
	// Tilemap
	private var whichlevel:Int;
	private var tilebase:FlxTilemap;
	private var fondo:FlxSprite;
	// Time
	private var minutes:Int;
	private var seconds:FlxTimer;
	
	override public function create():Void
	{
		super.create();
		whichlevel = Reg.whichlevel;
		
		fondo = new FlxSprite(0, 0, AssetPaths.Background__png);
		add(fondo);
		switch (whichlevel) 
		{
			case 1:
				var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.Mapa1__oel);		 //NIVEL 1
				tilebase = loader.loadTilemap(AssetPaths.tile__png, 32, 32, "TilesetBase");		
				tilebase.setTileProperties(0, FlxObject.NONE);	//FONDO
				tilebase.setTileProperties(1, FlxObject.ANY);	//PARED 1
				tilebase.setTileProperties(2, FlxObject.ANY);	//PARED 2
				tilebase.setTileProperties(3, FlxObject.ANY);	//PARED 3
				tilebase.setTileProperties(4, FlxObject.ANY);	//PARED 4
				tilebase.setTileProperties(5, FlxObject.ANY);	//PARED 5
				tilebase.setTileProperties(6, FlxObject.ANY);	//PARED 6
				add(tilebase);
			case 2:
				var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.Mapa2__oel);		 //NIVEL 2
				tilebase = loader.loadTilemap(AssetPaths.tile__png, 32, 32, "TilesetBase");		
				tilebase.setTileProperties(0, FlxObject.NONE);	//FONDO
				tilebase.setTileProperties(1, FlxObject.ANY);	//PARED 1
				tilebase.setTileProperties(2, FlxObject.ANY);	//PARED 2
				tilebase.setTileProperties(3, FlxObject.ANY);	//PARED 3
				tilebase.setTileProperties(4, FlxObject.ANY);	//PARED 4
				tilebase.setTileProperties(5, FlxObject.ANY);	//PARED 5
				tilebase.setTileProperties(6, FlxObject.ANY);	//PARED 6
				add(tilebase);
			case 3:
				var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.Mapa3__oel);		 //NIVEL 3
				tilebase = loader.loadTilemap(AssetPaths.tile__png, 32, 32, "TilesetBase");		
				tilebase.setTileProperties(0, FlxObject.NONE);	//FONDO
				tilebase.setTileProperties(1, FlxObject.ANY);	//PARED 1
				tilebase.setTileProperties(2, FlxObject.ANY);	//PARED 2
				tilebase.setTileProperties(3, FlxObject.ANY);	//PARED 3
				tilebase.setTileProperties(4, FlxObject.ANY);	//PARED 4
				tilebase.setTileProperties(5, FlxObject.ANY);	//PARED 5
				tilebase.setTileProperties(6, FlxObject.ANY);	//PARED 6
				add(tilebase);
		}
		// Variable initialization
		howMuchP = Reg.howMuch;
		timer = 200;
		timeTimed = 0;
		posX = 0;
		posY = 0;
		whichPUp = 0;
		r = new FlxRandom();
		players = new FlxTypedGroup();
		minutes = 1;
		//seconds.start(59, null, 2);
		
		// Player initialization
		player1 = new Player(camera.width / 4, camera.height / 4, 1);
		player2 = new Player(camera.width * 3 / 4, camera.height * 3 / 4, 2);
		players.add(player1);
		players.add(player2);
		if (howMuchP >= 3)
		{
			player3 = new Player(camera.width * 3 / 4, camera.height / 4, 3);
			players.add(player3);
		}
		if (howMuchP == 4)
		{
			player4 = new Player(camera.width / 4, camera.height * 3 / 4, 4);
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
			posX = r.int(38, 970);
			posY = r.int(38, 500);
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
		FlxG.collide(players, tilebase, colTilemap);
		FlxG.collide(players, players, colBtwPlayers);
	}
}