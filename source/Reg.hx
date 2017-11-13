package;
import entities.Player;

/**
 * ...
 * @author Aleman5
 */
class Reg 
{
	static public var paused:Bool = false;
	// Naves
	static public var speed:Int = 120;
	static public var speedBoost:Int = 138; // 115% de la speed normal
	static public var speedUnBoost:Int = 102; // 85% de la speed normal
	// PlayState
	static public var howMuchPlayers:Int;
	static public var whichlevel:Int;
	static public var howMuchTime:Int;
	// EndGame
	static public var p1Score:Int;
	static public var p2Score:Int;
	static public var p3Score:Int;
	static public var p4Score:Int;
}