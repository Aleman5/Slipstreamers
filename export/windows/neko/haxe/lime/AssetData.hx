package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/audio/Apeirogon100.wav", "assets/audio/Apeirogon100.wav");
			type.set ("assets/audio/Apeirogon100.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/badgem.wav", "assets/audio/badgem.wav");
			type.set ("assets/audio/badgem.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/boost.wav", "assets/audio/boost.wav");
			type.set ("assets/audio/boost.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/button.mp3", "assets/audio/button.mp3");
			type.set ("assets/audio/button.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/audio/button.wav", "assets/audio/button.wav");
			type.set ("assets/audio/button.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/collision.wav", "assets/audio/collision.wav");
			type.set ("assets/audio/collision.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/Diamond Sound Effect.mp3", "assets/audio/Diamond Sound Effect.mp3");
			type.set ("assets/audio/Diamond Sound Effect.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/audio/FlatteringShape130.wav", "assets/audio/FlatteringShape130.wav");
			type.set ("assets/audio/FlatteringShape130.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/gem1.wav", "assets/audio/gem1.wav");
			type.set ("assets/audio/gem1.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/gem2.wav", "assets/audio/gem2.wav");
			type.set ("assets/audio/gem2.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/gem3.wav", "assets/audio/gem3.wav");
			type.set ("assets/audio/gem3.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/levelSelect.wav", "assets/audio/levelSelect.wav");
			type.set ("assets/audio/levelSelect.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/menu.wav", "assets/audio/menu.wav");
			type.set ("assets/audio/menu.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/multiplier.wav", "assets/audio/multiplier.wav");
			type.set ("assets/audio/multiplier.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/oildrop.wav", "assets/audio/oildrop.wav");
			type.set ("assets/audio/oildrop.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/results.wav", "assets/audio/results.wav");
			type.set ("assets/audio/results.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/SeconDimension200.wav", "assets/audio/SeconDimension200.wav");
			type.set ("assets/audio/SeconDimension200.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/selecc.wav", "assets/audio/selecc.wav");
			type.set ("assets/audio/selecc.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/audio/shield.wav", "assets/audio/shield.wav");
			type.set ("assets/audio/shield.wav", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/images/Background.png", "assets/images/Background.png");
			type.set ("assets/images/Background.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/blue.png", "assets/images/blue.png");
			type.set ("assets/images/blue.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/boton.png", "assets/images/boton.png");
			type.set ("assets/images/boton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/completed.png", "assets/images/completed.png");
			type.set ("assets/images/completed.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/digital.ttf", "assets/images/digital.ttf");
			type.set ("assets/images/digital.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/images/ELEMENTS.TTF", "assets/images/ELEMENTS.TTF");
			type.set ("assets/images/ELEMENTS.TTF", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/images/gameover.png", "assets/images/gameover.png");
			type.set ("assets/images/gameover.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/goback.png", "assets/images/goback.png");
			type.set ("assets/images/goback.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/green.png", "assets/images/green.png");
			type.set ("assets/images/green.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Mapa1.oel", "assets/images/Mapa1.oel");
			type.set ("assets/images/Mapa1.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/Mapa2.oel", "assets/images/Mapa2.oel");
			type.set ("assets/images/Mapa2.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/Mapa3.oel", "assets/images/Mapa3.oel");
			type.set ("assets/images/Mapa3.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/Mapas.oep", "assets/images/Mapas.oep");
			type.set ("assets/images/Mapas.oep", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/marco.png", "assets/images/marco.png");
			type.set ("assets/images/marco.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/marcov2.png", "assets/images/marcov2.png");
			type.set ("assets/images/marcov2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/marcov3.png", "assets/images/marcov3.png");
			type.set ("assets/images/marcov3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/mas.png", "assets/images/mas.png");
			type.set ("assets/images/mas.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/menos.png", "assets/images/menos.png");
			type.set ("assets/images/menos.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/newPowerups.png", "assets/images/newPowerups.png");
			type.set ("assets/images/newPowerups.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player1.png", "assets/images/player1.png");
			type.set ("assets/images/player1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player2.png", "assets/images/player2.png");
			type.set ("assets/images/player2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player3.png", "assets/images/player3.png");
			type.set ("assets/images/player3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player4.png", "assets/images/player4.png");
			type.set ("assets/images/player4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/PORTADA.png", "assets/images/PORTADA.png");
			type.set ("assets/images/PORTADA.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/powerUps.png", "assets/images/powerUps.png");
			type.set ("assets/images/powerUps.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/powerups2.png", "assets/images/powerups2.png");
			type.set ("assets/images/powerups2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/red.png", "assets/images/red.png");
			type.set ("assets/images/red.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/retry.png", "assets/images/retry.png");
			type.set ("assets/images/retry.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Selectmenu.png", "assets/images/Selectmenu.png");
			type.set ("assets/images/Selectmenu.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/single.png", "assets/images/single.png");
			type.set ("assets/images/single.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/start.png", "assets/images/start.png");
			type.set ("assets/images/start.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tile.png", "assets/images/tile.png");
			type.set ("assets/images/tile.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/timeup.png", "assets/images/timeup.png");
			type.set ("assets/images/timeup.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Win.psd", "assets/images/Win.psd");
			type.set ("assets/images/Win.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/images/WinA.png", "assets/images/WinA.png");
			type.set ("assets/images/WinA.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Winp1.png", "assets/images/Winp1.png");
			type.set ("assets/images/Winp1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Winp2.png", "assets/images/Winp2.png");
			type.set ("assets/images/Winp2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Winp3.png", "assets/images/Winp3.png");
			type.set ("assets/images/Winp3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Winp4.png", "assets/images/Winp4.png");
			type.set ("assets/images/Winp4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/yellow.png", "assets/images/yellow.png");
			type.set ("assets/images/yellow.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/sounds/beep.ogg", "flixel/sounds/beep.ogg");
			type.set ("flixel/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/flixel.ogg", "flixel/sounds/flixel.ogg");
			type.set ("flixel/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/fonts/nokiafc22.ttf", "flixel/fonts/nokiafc22.ttf");
			type.set ("flixel/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/fonts/monsterrat.ttf", "flixel/fonts/monsterrat.ttf");
			type.set ("flixel/fonts/monsterrat.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/images/ui/button.png", "flixel/images/ui/button.png");
			type.set ("flixel/images/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/images/logo/default.png", "flixel/images/logo/default.png");
			type.set ("flixel/images/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
