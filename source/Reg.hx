package;

/**
 * ...
 * @author Aleman5
 */
class Reg 
{
	static public var paused:Bool = false;
	// Naves
	static public var speed:Int = 150;
	static public var speedBoost:Int = 200;
	static public var speedUnBoost:Int = 100;
	// PlayState
	static public var howMuchPlayers:Int;
	static public var whichlevel:Int;
	static public var howMuchTime:Int;
	static public var lvl:Int = 1;
	static public var need:Int = 250;
	static public var stage:Int = 1;
	// EndGame
	static public var p1Score:Int;
	static public var p2Score:Int;
	static public var p3Score:Int;
	static public var p4Score:Int;
}