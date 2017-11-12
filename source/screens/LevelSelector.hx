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
	// States changers
	private var playBtn:FlxButton;
	private var menuBtn:FlxButton;
	
	override public function create():Void
	{
		// Player things
		totalPlayers = 2;
		
		var fondo:FlxSprite = new FlxSprite(0, 0, AssetPaths.Selectmenu__png);
		playersTxt = new FlxText(camera.width / 4, camera.height / 4, 0, "How much players: " + totalPlayers, 16, true);
		
		removePBtn = new FlxButton(playersTxt.x + 220, playersTxt.y, "--", removePlayer);
		removePBtn.setGraphicSize(32, 32);
		removePBtn.updateHitbox();
		
		addPBtn = new FlxButton(removePBtn.x + removePBtn.width + 2, playersTxt.y, "++", addPlayer);
		addPBtn.setGraphicSize(32, 32);
		addPBtn.updateHitbox();
		
		// Tilemap things
		whichTilemap = 1;
		
		levelTxt = new FlxText(camera.width / 4, camera.height / 2, 0, "Level: Spacemap1", 16, true);
		
		removeLBtn = new FlxButton(levelTxt.x + 180, levelTxt.y, " ", removeTilemap);
		removeLBtn.setGraphicSize(32, 32);
		removeLBtn.updateHitbox();
		
		addLBtn = new FlxButton(removePBtn.x + removePBtn.width + 2, levelTxt.y, " ", addTilemap);
		addLBtn.setGraphicSize(32, 32);
		addLBtn.updateHitbox();
		// State changers
		playBtn = new FlxButton(camera.width * 3 / 4, camera.height * 3 / 4, "Play!", playGame);
		
		menuBtn = new FlxButton(camera.width / 4, camera.height * 3 / 4, "Go back", returnToMenu);
		
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
				levelTxt.text = "Level: Spacemap1";
			case 2:
				levelTxt.text = "Level: Spacemap2";
			case 3:
				levelTxt.text = "Level: Spacemap3";
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
	private function playGame() 
	{
		Reg.howMuch = totalPlayers;
		Reg.whichlevel = whichTilemap;
		var playState:PlayState = new PlayState();
		FlxG.switchState(playState);
	}
	private function returnToMenu() 
	{
		var menuState:MenuState = new MenuState();
		FlxG.switchState(menuState);
	}
}