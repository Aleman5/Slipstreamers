package screens;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;

/**
 * ...
 * @author Aleman5
 */
class LevelSelector extends FlxState 
{	// Players things
	private var totalPlayers:Int;
	private var playersTxt:FlxText;
	private var addPBtn:FlxButton;
	private var removePBtn:FlxButton;
	// Tilemap things
	private var whichTilemap:Int;
	private var levelTxt:FlxText;
	private var addLBtn:FlxButton;
	private var removeLBtn:FlxButton;
	// Time things
	private var howMuchTime:Int;
	private var timeTxt:FlxText;
	private var addTBtn:FlxButton;
	private var removeTBtn:FlxButton;
	// States changers
	private var playBtn:FlxButton;
	private var menuBtn:FlxButton;
	
	override public function create():Void
	{
		// Player things
		totalPlayers = 2;
		
		var fondo:FlxSprite = new FlxSprite(0, 0, AssetPaths.Selectmenu__png);
		playersTxt = new FlxText(170, 100, 0, "How much players: " + totalPlayers, 32, true);
		playersTxt.scale.set(2, 2);
		playersTxt.y = 100;
		
		removePBtn = new FlxButton(playersTxt.x + 350, playersTxt.y-15, " ", removePlayer);
		removePBtn.loadGraphic(AssetPaths.menos__png, true, 62, 69);
		
		addPBtn = new FlxButton(removePBtn.x + removePBtn.width + 10, playersTxt.y-15, " ", addPlayer);
		addPBtn.loadGraphic(AssetPaths.mas__png, true, 62, 69);
		
		// Tilemap things
		whichTilemap = 1;
		
		levelTxt = new FlxText(150, 300, 0, "Level: Spacemap 1", 32, true);
		levelTxt.scale.set(2, 2);
		levelTxt.y = 300;
		
		removeLBtn = new FlxButton(playersTxt.x + 350, levelTxt.y-15, " ", removeTilemap);
		removeLBtn.loadGraphic(AssetPaths.menos__png, true, 62, 69);
		
		addLBtn = new FlxButton(removeLBtn.x + removeLBtn.width+10, levelTxt.y-15, " ", addTilemap);
		addLBtn.loadGraphic(AssetPaths.mas__png, true, 62, 69);
		
		// Time things
		howMuchTime = 1;
		
		timeTxt = new FlxText(camera.width / 4, camera.height / 2 + 40, 0, "", 16, true);
		
		removeTBtn = new FlxButton(timeTxt.x + 180, timeTxt.y + 30, "", removeTime);
		removeTBtn.setGraphicSize(32, 32);
		removeTBtn.updateHitbox();
		
		addTBtn = new FlxButton(removeTBtn.x + removeTBtn.width + 2, timeTxt.y, "", addTime);
		addTBtn.setGraphicSize(32, 32);
		addTBtn.updateHitbox();
		
		// State changers
		playBtn = new FlxButton(460, 470, " ", playGame);
		playBtn.loadGraphic(AssetPaths.start__png, true, 189, 52);
		
		menuBtn = new FlxButton(70, 470, " ", returnToMenu);
		menuBtn.loadGraphic(AssetPaths.goback__png, true, 231, 52);
		
		// Setting text format
		playersTxt.setFormat(AssetPaths.ELEMENTS__TTF, 16);
		levelTxt.setFormat(AssetPaths.ELEMENTS__TTF, 16);
		// Adding
		add(fondo);
		add(playersTxt);
		add(addPBtn);
		add(removePBtn);
		add(levelTxt);
		add(addLBtn);
		add(removeLBtn);
		add(timeTxt);
		add(addTBtn);
		add(removeTBtn);
		add(playBtn);
		add(menuBtn);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		playersTxt.text =  "How much players: " + totalPlayers;
		switch (whichTilemap) 
		{
			case 1:
				levelTxt.text = "Level: Spacemap 1";
			case 2:
				levelTxt.text = "Level: Spacemap 2";
			case 3:
				levelTxt.text = "Level: Spacemap 3";
		}
		switch (howMuchTime) 
		{
			case 1:
				timeTxt.text = "Time: 59 seconds";
			case 2:
				timeTxt.text = "Time: 1 minute 30 seconds";
			case 3:
				timeTxt.text = "Time: 1 minute 59 seconds";
		}
	}
	private function removePlayer() 
	{
		if (totalPlayers > 2)
			totalPlayers--;
	}
	private function addPlayer() 
	{
		if (totalPlayers < 4)
			totalPlayers++;
	}
	private function removeTilemap() 
	{
		if (whichTilemap > 1)
			whichTilemap--;
	}
	private function addTilemap() 
	{
		if (whichTilemap < 3)
			whichTilemap++;
	}
	private function removeTime() 
	{
		if (howMuchTime > 1)
			howMuchTime--;
	}
	private function addTime() 
	{
		if (howMuchTime < 3)
			howMuchTime++;
	}
	private function playGame() 
	{
		Reg.howMuchPlayers = totalPlayers;
		Reg.whichlevel = whichTilemap;
		Reg.howMuchTime = howMuchTime;
		var playState:PlayState = new PlayState();
		FlxG.switchState(playState);
	}
	private function returnToMenu() 
	{
		var menuState:MenuState = new MenuState();
		FlxG.switchState(menuState);
	}
}