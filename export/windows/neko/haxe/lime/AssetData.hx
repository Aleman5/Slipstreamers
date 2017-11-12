package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/images/Background.png", "assets/images/Background.png");
			type.set ("assets/images/Background.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/blue.png", "assets/images/blue.png");
			type.set ("assets/images/blue.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ELEMENTS.TTF", "assets/images/ELEMENTS.TTF");
			type.set ("assets/images/ELEMENTS.TTF", Reflect.field (AssetType, "font".toUpperCase ()));
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
			path.set ("assets/images/Selectmenu.png", "assets/images/Selectmenu.png");
			type.set ("assets/images/Selectmenu.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tile.png", "assets/images/tile.png");
			type.set ("assets/images/tile.png", Reflect.field (AssetType, "image".toUpperCase ()));
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
