package screens;

import entities.ColTile;
import entities.Player;
import entities.Items;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import screens.EndGame;
import screens.MenuState;

class OnePlayerGame extends FlxState
{
	// Players
	private var player1:Player;
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
	private var collisionTile:FlxTypedGroup<ColTile>;
	// Time
	private var howMuchTime:Int;
	private var timeTxt:FlxText;
	private var counter:Int;
	// Sounds
	private var playSounds:Bool;
	private var playTheme:Bool;
	private var timesup:FlxSprite;
	private var marco:FlxSprite;
	private var mission:FlxText;
	private var stage:FlxText;
	var completed:FlxSprite;
	var gameOver:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		FlxG.camera.fade(FlxColor.BLACK, 0.1, true);
		FlxG.sound.play(AssetPaths.button__wav);
		whichlevel = Reg.lvl;
		fondo = new FlxSprite(0, 0, AssetPaths.Background__png);
		add(fondo);
		collisionTile = new FlxTypedGroup<ColTile>();
		mission = new FlxText(710, 11, 0, "Mission: Reach "+ Reg.need +" Points", 16, true);
		mission.color = FlxColor.RED;
		stage = new FlxText(18, 575, 0, "Stage: "+Reg.stage, 16, true);
		stage.color = FlxColor.RED;
		
		switch (whichlevel) 
		{
			case 1:
				var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.Mapa1__oel);		 //NIVEL 1
				loader.loadEntities(entityLoader, "collisionTile");
				add(collisionTile);
				tilebase = loader.loadTilemap(AssetPaths.tile__png, 32, 32, "TilesetBase");		
				tilebase.setTileProperties(0, FlxObject.NONE);	//FONDO
				tilebase.setTileProperties(1, FlxObject.ANY);	//PARED 1
				tilebase.setTileProperties(2, FlxObject.ANY);	//PARED 2
				tilebase.setTileProperties(3, FlxObject.ANY);	//PARED 3
				tilebase.setTileProperties(4, FlxObject.ANY);	//PARED 4
				tilebase.setTileProperties(5, FlxObject.ANY);	//PARED 5
				tilebase.setTileProperties(6, FlxObject.ANY);	//PARED 6
				add(tilebase);
				FlxG.sound.play(AssetPaths.Apeirogon100__wav,0.5);
			case 2:
				var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.Mapa2__oel);		 //NIVEL 2
				loader.loadEntities(entityLoader, "collisionTile");
				add(collisionTile);
				tilebase = loader.loadTilemap(AssetPaths.tile__png, 32, 32, "TilesetBase");		
				tilebase.setTileProperties(0, FlxObject.NONE);	//FONDO
				tilebase.setTileProperties(1, FlxObject.ANY);	//PARED 1
				tilebase.setTileProperties(2, FlxObject.ANY);	//PARED 2
				tilebase.setTileProperties(3, FlxObject.ANY);	//PARED 3
				tilebase.setTileProperties(4, FlxObject.ANY);	//PARED 4
				tilebase.setTileProperties(5, FlxObject.ANY);	//PARED 5
				tilebase.setTileProperties(6, FlxObject.ANY);	//PARED 6
				add(tilebase);
				FlxG.sound.play(AssetPaths.FlatteringShape130__wav,0.5);
			case 3:
				var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.Mapa3__oel);		 //NIVEL 3
				loader.loadEntities(entityLoader, "collisionTile");
				add(collisionTile);
				tilebase = loader.loadTilemap(AssetPaths.tile__png, 32, 32, "TilesetBase");		
				tilebase.setTileProperties(0, FlxObject.NONE);	//FONDO
				tilebase.setTileProperties(1, FlxObject.ANY);	//PARED 1
				tilebase.setTileProperties(2, FlxObject.ANY);	//PARED 2
				tilebase.setTileProperties(3, FlxObject.ANY);	//PARED 3
				tilebase.setTileProperties(4, FlxObject.ANY);	//PARED 4
				tilebase.setTileProperties(5, FlxObject.ANY);	//PARED 5
				tilebase.setTileProperties(6, FlxObject.ANY);	//PARED 6
				add(tilebase);
				FlxG.sound.play(AssetPaths.SeconDimension200__wav,0.5);
		}
		marco = new FlxSprite(0, 0, AssetPaths.marcov2__png);
		add(marco);
		timesup = new FlxSprite( -1000, 232, AssetPaths.timeup__png);
		completed = new FlxSprite(327, 363, AssetPaths.completed__png);
		gameOver = new FlxSprite(327, 363, AssetPaths.gameover__png);
		
		// Variable initialization
		timer = 75;
		timeTimed = 0;
		posX = 0;
		posY = 0;
		whichPUp = 0;
		r = new FlxRandom();
		// Time
		howMuchTime = 59;
		timeTxt = new FlxText(450, 12, 0, "", 22, true);
		timeTxt.setFormat(AssetPaths.digital__ttf, 22, FlxColor.CYAN);	
		counter = 0;
		// Sounds
		playSounds = true;
		playTheme = true;
		// Player initialization
		player1 = new Player(camera.width / 4, camera.height / 4 + 16, 1);
		add(player1);
		pUps = new FlxTypedGroup();
		add(timeTxt);
		add(mission);
		add(stage);
	}
	override public function update(elapsed:Float):Void
	{
		if (!Reg.paused)
		{
			super.update(elapsed);
			powerUpCreator();
			checkTime();
		}
		checkSound();
		collisions();
		levelResetOrPause();
		if (Reg.p1Score >= Reg.need)
		{
			marco.loadGraphic(AssetPaths.marcov3__png);
			mission.color = FlxColor.LIME;
		}
		if (Reg.p1Score <= Reg.need)
		{
			marco.loadGraphic(AssetPaths.marcov2__png);
			mission.color = FlxColor.RED;
		}
	}
	private function entityLoader (entityName:String, entityData: Xml) 
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		var tile:ColTile = new ColTile();
		tile.x = x;
		tile.y = y;
		collisionTile.add(tile);
	}
	private function checkSound() 
	{
		if (FlxG.keys.justPressed.O)
			playSounds = !playSounds;
		if (FlxG.keys.justPressed.P)
			playTheme = !playTheme;
	}
	private function checkTime() 
	{
		counter++;
		if (counter > 59)
		{
			howMuchTime--;
			counter = 0;
		}
		timeTxt.text = "Time left: " + howMuchTime;
		
		if (howMuchTime <= 0)
		{
			add(timesup);
			timesup.velocity.x = 450;
			timeTxt.text = "Time's Over";
			Reg.speed = 0;
			Reg.speedBoost = 0;
			Reg.speedUnBoost = 0;
		}
		if (timesup.x == 200)
		{
			timesup.velocity.x = 0;
			timer = 99999999;
			
			if (Reg.p1Score >= Reg.need)
			{
				add(completed);
				if(timeTimed>100){
				finishGame();
				massacre();
				create();}
			}
			else 
			{
				add(gameOver);
				if(timeTimed>100){
				gOver();
				var menuState:MenuState = new MenuState();
				FlxG.switchState(menuState);}
			}
		}
	}
	private function massacre():Void
	{
		fondo.destroy();
		collisionTile.destroy();
		tilebase.destroy();
		marco.destroy();
		player1.destroy();
		timeTxt.destroy();
		timesup.destroy();
		pUps.destroy();
		mission.destroy();
		stage.destroy();
		completed.destroy();
		gameOver.destroy();
		FlxG.sound.destroy();
	}
	private function levelResetOrPause():Void
	{
		if (FlxG.keys.justPressed.ESCAPE)
		{
			Reg.speed = 150;
			Reg.speedBoost = 200;
			Reg.speedUnBoost = 100;
			var menuState:MenuState = new MenuState();
			FlxG.switchState(menuState);
		}
		if (FlxG.keys.justPressed.ENTER)
			Reg.paused = !Reg.paused;
	}
	private function finishGame():Void
	{
		Reg.speed = 150;
		Reg.speedBoost = 200;
		Reg.speedUnBoost = 100;
		Reg.lvl++;
		Reg.need += 50;
		Reg.stage ++;
		if (Reg.lvl > 3)
			Reg.lvl = 1;
	}
	private function gOver():Void
	{
		Reg.need = 250;
		Reg.stage = 1;
		Reg.speed = 150;
		Reg.speedBoost = 200;
		Reg.speedUnBoost = 100;
		Reg.lvl = 1;
	}
	private function powerUpCreator():Void
	{
		timeTimed++;
		if (timeTimed >= timer)
		{
			posX = r.int(45, 970);
			posY = r.int(45, 540);
			whichPUp = r.int(0, 7);
			pUp = new Items(posX, posY, whichPUp);
			if (FlxG.overlap(collisionTile, pUp)||FlxG.overlap(pUps, pUp))
			{
				pUp.kill;
			}
			else if (!FlxG.overlap(collisionTile, pUp)||!FlxG.overlap(pUps, pUp))
			{
				pUps.add(pUp);
			}
			add(pUps);
			timeTimed = 0;
		}
	}
	private function powered(p:Player, pU:Items):Void
	{
		p.whichPwUp(pU.get_whichPowerUp());
		pU.kill();
	}
	private function colTilemap(p:Player, dinopianito:Bool) 
	{
		whatShouldIDo(p);
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
		FlxG.overlap(player1, pUps, powered);
		FlxG.collide(player1, tilebase, colTilemap);
	}
}