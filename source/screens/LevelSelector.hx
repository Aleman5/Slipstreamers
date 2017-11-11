package screens;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;

/**
 * ...
 * @author Aleman5
 */
class LevelSelector extends FlxState 
{
	private var totalPlayers:Int;
	private var playersTxt:FlxText;
	private var addPBtn:FlxButton;
	private var removePBtn:FlxButton;
	private var playBtn:FlxButton;
	private var menuBtn:FlxButton;
	
	override public function create():Void
	{
		totalPlayers = 2;
		
		playersTxt = new FlxText(camera.width / 4, camera.height / 4, 0, "How much players: " + totalPlayers, 16, true);
		
		removePBtn = new FlxButton(playersTxt.x + 220, playersTxt.y, "--", removePlayer);
		removePBtn.setGraphicSize(32, 32);
		removePBtn.updateHitbox();
		
		addPBtn = new FlxButton(removePBtn.x + removePBtn.width + 2, playersTxt.y, "++", addPlayer);
		addPBtn.setGraphicSize(32, 32);
		addPBtn.updateHitbox();
		
		playBtn = new FlxButton(camera.width * 3 / 4, camera.height * 3 / 4, "Play!", playGame);
		
		menuBtn = new FlxButton(camera.width / 4, camera.height * 3 / 4, "Go back", returnToMenu);
		// Setting text format
		playersTxt.setFormat(AssetPaths.ELEMENTS__TTF, 16);
		// Adding
		add(playersTxt);
		add(removePBtn);
		add(addPBtn);
		add(playBtn);
		add(menuBtn);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		playersTxt.text =  "How much players: " + totalPlayers;
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
	private function playGame() 
	{
		Reg.howMuch = totalPlayers;
		var playState:PlayState = new PlayState();
		FlxG.switchState(playState);
	}
	private function returnToMenu() 
	{
		var menuState:MenuState = new MenuState();
		FlxG.switchState(menuState);
	}
}