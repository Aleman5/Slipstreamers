package;

import entities.Player;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState
{
	private var player1:Player;
	private var player2:Player;
	private var player3:Player;
	private var player4:Player;
	private var players:FlxTypedGroup<Player>;
	
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = 0xBB7744FF;
		
		player1 = new Player(camera.width / 4, camera.height / 4, 1);
		player2 = new Player(camera.width * 3 / 4, camera.height * 3 / 4, 2);
		player3 = new Player(camera.width * 3 / 4, camera.height / 4, 3);
		player4 = new Player(camera.width / 4, camera.height * 3 / 4, 4);
		players = new FlxTypedGroup();
		
		players.add(player1);
		//players.add(player2);
		//players.add(player3);
		//players.add(player4);
		add(players);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		checkCollisions();
	}
	
	public function checkCollisions() 
	{
		
	}
}