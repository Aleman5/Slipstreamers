#if !lime_hybrid


package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if neko
import neko.vm.Deque;
import neko.vm.Thread;
#elseif cpp
import cpp.vm.Deque;
import cpp.vm.Thread;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl._legacy.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	private static var loaded = 0;
	private static var loading = 0;
	private static var workerIncomingQueue = new Deque<Dynamic> ();
	private static var workerResult = new Deque<Dynamic> ();
	private static var workerThread:Thread;
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		Font.registerFont (__ASSET__assets_images_digital_ttf);
		Font.registerFont (__ASSET__assets_images_elements_ttf);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		Font.registerFont (__ASSET__flixel_fonts_nokiafc22_ttf);
		Font.registerFont (__ASSET__flixel_fonts_monsterrat_ttf);
		
		
		
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			if (type == BINARY || type == null || (assetType == BINARY && type == TEXT)) {
				
				return true;
				
			}
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		if (className.exists (id)) {
			
			return cast (Type.createInstance (className.get (id), []), BitmapData);
			
		} else {
			
			return BitmapData.load (path.get (id));
			
		}
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		if (className.exists (id)) {
			
			return cast (Type.createInstance (className.get (id), []), ByteArray);
			
		} else {
			
			return ByteArray.readFile (path.get (id));
			
		}
		
	}
	
	
	public override function getFont (id:String):Font {
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return new Font (path.get (id));
			
		}
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		if (className.exists (id)) {
			
			return cast (Type.createInstance (className.get (id), []), Sound);
			
		} else {
			
			return new Sound (new URLRequest (path.get (id)), null, true);
			
		}
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		if (className.exists (id)) {
			
			return cast (Type.createInstance (className.get (id), []), Sound);
			
		} else {
			
			return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
			
		}
		
	}
	
	
	public override function getText (id:String):String {
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		__load (getBitmapData, id, handler);
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		__load (getBytes, id, handler);
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		__load (getFont, id, handler);
		
	}
	
	
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		__load (getMusic, id, handler);
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		__load (getSound, id, handler);
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
	}
	
	
	private static function __doWork ():Void {
		
		while (true) {
			
			var message = workerIncomingQueue.pop (true);
			
			if (message == "WORK") {
				
				var getMethod = workerIncomingQueue.pop (true);
				var id = workerIncomingQueue.pop (true);
				var handler = workerIncomingQueue.pop (true);
				
				var data = getMethod (id);
				workerResult.add ("RESULT");
				workerResult.add (data);
				workerResult.add (handler);
				
			} else if (message == "EXIT") {
				
				break;
				
			}
			
		}
		
	}
	
	
	private inline function __load<T> (getMethod:String->T, id:String, handler:T->Void):Void {
		
		workerIncomingQueue.add ("WORK");
		workerIncomingQueue.add (getMethod);
		workerIncomingQueue.add (id);
		workerIncomingQueue.add (handler);
		
		loading++;
		
	}
	
	
	public static function __poll ():Void {
		
		if (loading > loaded) {
			
			if (workerThread == null) {
				
				workerThread = Thread.create (__doWork);
				
			}
			
			var message = workerResult.pop (false);
			
			while (message == "RESULT") {
				
				loaded++;
				
				var data = workerResult.pop (true);
				var handler = workerResult.pop (true);
				
				if (handler != null) {
					
					handler (data);
					
				}
				
				message = workerResult.pop (false);
				
			}
			
		} else {
			
			if (workerThread != null) {
				
				workerIncomingQueue.add ("EXIT");
				workerThread = null;
				
			}
			
		}
		
	}
	
	
}


#if (windows || mac || linux)


@:sound("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/sounds/beep.ogg") @:keep #if display private #end class __ASSET__flixel_sounds_beep_ogg extends flash.media.Sound {}
@:sound("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/sounds/flixel.ogg") @:keep #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends flash.media.Sound {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/fonts/nokiafc22.ttf") @:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends flash.text.Font {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/fonts/monsterrat.ttf") @:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends flash.text.Font {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/images/ui/button.png") @:keep #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData {}
@:bitmap("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/images/logo/default.png") @:keep #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData {}



@:keep class __ASSET__assets_images_digital_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/images/digital.ttf"; fontName = "Digital-7"; }}
@:keep class __ASSET__assets_images_elements_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/images/ELEMENTS.TTF"; fontName = "BN Elements"; }}


#else


class __ASSET__assets_images_digital_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/images/digital.ttf"; fontName = "Digital-7";  }}
class __ASSET__assets_images_elements_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/images/ELEMENTS.TTF"; fontName = "BN Elements";  }}
class __ASSET__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "flixel/fonts/nokiafc22.ttf"; fontName = "Nokia Cellphone FC Small";  }}
class __ASSET__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "flixel/fonts/monsterrat.ttf"; fontName = "Monsterrat";  }}


#end


#else


package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Future;
import lime.app.Preloader;
import lime.app.Promise;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.text.Font;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if (js && html5)
import lime.net.URLLoader;
import lime.net.URLRequest;
#elseif flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if (openfl && !flash)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_images_digital_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_images_elements_ttf);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		
		
		#end
		
		#if flash
		
		path.set ("assets/audio/Apeirogon100.wav", "assets/audio/Apeirogon100.wav");
		type.set ("assets/audio/Apeirogon100.wav", AssetType.SOUND);
		path.set ("assets/audio/badgem.wav", "assets/audio/badgem.wav");
		type.set ("assets/audio/badgem.wav", AssetType.SOUND);
		path.set ("assets/audio/boost.wav", "assets/audio/boost.wav");
		type.set ("assets/audio/boost.wav", AssetType.SOUND);
		path.set ("assets/audio/button.mp3", "assets/audio/button.mp3");
		type.set ("assets/audio/button.mp3", AssetType.MUSIC);
		path.set ("assets/audio/button.wav", "assets/audio/button.wav");
		type.set ("assets/audio/button.wav", AssetType.SOUND);
		path.set ("assets/audio/collision.wav", "assets/audio/collision.wav");
		type.set ("assets/audio/collision.wav", AssetType.SOUND);
		path.set ("assets/audio/Diamond Sound Effect.mp3", "assets/audio/Diamond Sound Effect.mp3");
		type.set ("assets/audio/Diamond Sound Effect.mp3", AssetType.MUSIC);
		path.set ("assets/audio/FlatteringShape130.wav", "assets/audio/FlatteringShape130.wav");
		type.set ("assets/audio/FlatteringShape130.wav", AssetType.SOUND);
		path.set ("assets/audio/gem1.wav", "assets/audio/gem1.wav");
		type.set ("assets/audio/gem1.wav", AssetType.SOUND);
		path.set ("assets/audio/gem2.wav", "assets/audio/gem2.wav");
		type.set ("assets/audio/gem2.wav", AssetType.SOUND);
		path.set ("assets/audio/gem3.wav", "assets/audio/gem3.wav");
		type.set ("assets/audio/gem3.wav", AssetType.SOUND);
		path.set ("assets/audio/levelSelect.wav", "assets/audio/levelSelect.wav");
		type.set ("assets/audio/levelSelect.wav", AssetType.SOUND);
		path.set ("assets/audio/menu.wav", "assets/audio/menu.wav");
		type.set ("assets/audio/menu.wav", AssetType.SOUND);
		path.set ("assets/audio/multiplier.wav", "assets/audio/multiplier.wav");
		type.set ("assets/audio/multiplier.wav", AssetType.SOUND);
		path.set ("assets/audio/oildrop.wav", "assets/audio/oildrop.wav");
		type.set ("assets/audio/oildrop.wav", AssetType.SOUND);
		path.set ("assets/audio/results.wav", "assets/audio/results.wav");
		type.set ("assets/audio/results.wav", AssetType.SOUND);
		path.set ("assets/audio/SeconDimension200.wav", "assets/audio/SeconDimension200.wav");
		type.set ("assets/audio/SeconDimension200.wav", AssetType.SOUND);
		path.set ("assets/audio/selecc.wav", "assets/audio/selecc.wav");
		type.set ("assets/audio/selecc.wav", AssetType.SOUND);
		path.set ("assets/audio/shield.wav", "assets/audio/shield.wav");
		type.set ("assets/audio/shield.wav", AssetType.SOUND);
		path.set ("assets/images/Background.png", "assets/images/Background.png");
		type.set ("assets/images/Background.png", AssetType.IMAGE);
		path.set ("assets/images/blue.png", "assets/images/blue.png");
		type.set ("assets/images/blue.png", AssetType.IMAGE);
		path.set ("assets/images/boton.png", "assets/images/boton.png");
		type.set ("assets/images/boton.png", AssetType.IMAGE);
		path.set ("assets/images/completed.png", "assets/images/completed.png");
		type.set ("assets/images/completed.png", AssetType.IMAGE);
		path.set ("assets/images/digital.ttf", "assets/images/digital.ttf");
		type.set ("assets/images/digital.ttf", AssetType.FONT);
		path.set ("assets/images/ELEMENTS.TTF", "assets/images/ELEMENTS.TTF");
		type.set ("assets/images/ELEMENTS.TTF", AssetType.FONT);
		path.set ("assets/images/gameover.png", "assets/images/gameover.png");
		type.set ("assets/images/gameover.png", AssetType.IMAGE);
		path.set ("assets/images/goback.png", "assets/images/goback.png");
		type.set ("assets/images/goback.png", AssetType.IMAGE);
		path.set ("assets/images/green.png", "assets/images/green.png");
		type.set ("assets/images/green.png", AssetType.IMAGE);
		path.set ("assets/images/Mapa1.oel", "assets/images/Mapa1.oel");
		type.set ("assets/images/Mapa1.oel", AssetType.TEXT);
		path.set ("assets/images/Mapa2.oel", "assets/images/Mapa2.oel");
		type.set ("assets/images/Mapa2.oel", AssetType.TEXT);
		path.set ("assets/images/Mapa3.oel", "assets/images/Mapa3.oel");
		type.set ("assets/images/Mapa3.oel", AssetType.TEXT);
		path.set ("assets/images/Mapas.oep", "assets/images/Mapas.oep");
		type.set ("assets/images/Mapas.oep", AssetType.TEXT);
		path.set ("assets/images/marco.png", "assets/images/marco.png");
		type.set ("assets/images/marco.png", AssetType.IMAGE);
		path.set ("assets/images/marcov2.png", "assets/images/marcov2.png");
		type.set ("assets/images/marcov2.png", AssetType.IMAGE);
		path.set ("assets/images/marcov3.png", "assets/images/marcov3.png");
		type.set ("assets/images/marcov3.png", AssetType.IMAGE);
		path.set ("assets/images/mas.png", "assets/images/mas.png");
		type.set ("assets/images/mas.png", AssetType.IMAGE);
		path.set ("assets/images/menos.png", "assets/images/menos.png");
		type.set ("assets/images/menos.png", AssetType.IMAGE);
		path.set ("assets/images/newPowerups.png", "assets/images/newPowerups.png");
		type.set ("assets/images/newPowerups.png", AssetType.IMAGE);
		path.set ("assets/images/PORTADA.png", "assets/images/PORTADA.png");
		type.set ("assets/images/PORTADA.png", AssetType.IMAGE);
		path.set ("assets/images/powerups2.png", "assets/images/powerups2.png");
		type.set ("assets/images/powerups2.png", AssetType.IMAGE);
		path.set ("assets/images/red.png", "assets/images/red.png");
		type.set ("assets/images/red.png", AssetType.IMAGE);
		path.set ("assets/images/retry.png", "assets/images/retry.png");
		type.set ("assets/images/retry.png", AssetType.IMAGE);
		path.set ("assets/images/Selectmenu.png", "assets/images/Selectmenu.png");
		type.set ("assets/images/Selectmenu.png", AssetType.IMAGE);
		path.set ("assets/images/single.png", "assets/images/single.png");
		type.set ("assets/images/single.png", AssetType.IMAGE);
		path.set ("assets/images/start.png", "assets/images/start.png");
		type.set ("assets/images/start.png", AssetType.IMAGE);
		path.set ("assets/images/tile.png", "assets/images/tile.png");
		type.set ("assets/images/tile.png", AssetType.IMAGE);
		path.set ("assets/images/timeup.png", "assets/images/timeup.png");
		type.set ("assets/images/timeup.png", AssetType.IMAGE);
		path.set ("assets/images/WinA.png", "assets/images/WinA.png");
		type.set ("assets/images/WinA.png", AssetType.IMAGE);
		path.set ("assets/images/Winp1.png", "assets/images/Winp1.png");
		type.set ("assets/images/Winp1.png", AssetType.IMAGE);
		path.set ("assets/images/Winp2.png", "assets/images/Winp2.png");
		type.set ("assets/images/Winp2.png", AssetType.IMAGE);
		path.set ("assets/images/Winp3.png", "assets/images/Winp3.png");
		type.set ("assets/images/Winp3.png", AssetType.IMAGE);
		path.set ("assets/images/Winp4.png", "assets/images/Winp4.png");
		type.set ("assets/images/Winp4.png", AssetType.IMAGE);
		path.set ("assets/images/yellow.png", "assets/images/yellow.png");
		type.set ("assets/images/yellow.png", AssetType.IMAGE);
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		
		
		#elseif html5
		
		var id;
		id = "assets/audio/Apeirogon100.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/badgem.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/boost.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/button.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		id = "assets/audio/button.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/collision.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/Diamond Sound Effect.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		id = "assets/audio/FlatteringShape130.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/gem1.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/gem2.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/gem3.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/levelSelect.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/menu.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/multiplier.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/oildrop.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/results.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/SeconDimension200.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/selecc.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/audio/shield.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "assets/images/Background.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/blue.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/boton.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/completed.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/digital.ttf";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "assets/images/ELEMENTS.TTF";
		path.set (id, id);
		type.set (id, AssetType.FONT);
		id = "assets/images/gameover.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/goback.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/green.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Mapa1.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/images/Mapa2.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/images/Mapa3.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/images/Mapas.oep";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/images/marco.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/marcov2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/marcov3.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/mas.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/menos.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/newPowerups.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/PORTADA.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/powerups2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/red.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/retry.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Selectmenu.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/single.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/start.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tile.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/timeup.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/WinA.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Winp1.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Winp2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Winp3.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Winp4.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/yellow.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/sounds/beep.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/sounds/flixel.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/fonts/nokiafc22.ttf";
		className.set (id, __ASSET__flixel_fonts_nokiafc22_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/fonts/monsterrat.ttf";
		className.set (id, __ASSET__flixel_fonts_monsterrat_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/images/ui/button.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/images/logo/default.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		
		
		var assetsPrefix = null;
		if (ApplicationMain.config != null && Reflect.hasField (ApplicationMain.config, "assetsPrefix")) {
			assetsPrefix = ApplicationMain.config.assetsPrefix;
		}
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		
		className.set ("assets/images/digital.ttf", __ASSET__assets_images_digital_ttf);
		type.set ("assets/images/digital.ttf", AssetType.FONT);
		
		className.set ("assets/images/ELEMENTS.TTF", __ASSET__assets_images_elements_ttf);
		type.set ("assets/images/ELEMENTS.TTF", AssetType.FONT);
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						onChange.dispatch ();
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), ByteArray));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return cast (Type.createInstance (className.get (id), []), ByteArray);
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return bitmapData.getPixels (bitmapData.rect);
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var data = loader.data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var data = loader.data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String):Future<AudioBuffer> {
		
		var promise = new Promise<AudioBuffer> ();
		
		#if (flash)
		
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				promise.complete (audioBuffer);
				
			});
			soundLoader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			soundLoader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getAudioBuffer (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<AudioBuffer> (function () return getAudioBuffer (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadBytes (id:String):Future<ByteArray> {
		
		var promise = new Promise<ByteArray> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				promise.complete (bytes);
				
			});
			loader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.dataFormat = BINARY;
			loader.onComplete.add (function (_):Void {
				
				promise.complete (loader.data);
				
			});
			loader.onProgress.add (function (_, loaded, total) {
				
				if (total == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (loaded / total);
					
				}
				
			});
			loader.onIOError.add (function (_, e) {
				
				promise.error (e);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<ByteArray> (function () return getBytes (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadImage (id:String):Future<Image> {
		
		var promise = new Promise<Image> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				promise.complete (Image.fromBitmapData (bitmapData));
				
			});
			loader.contentLoaderInfo.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var image = new js.html.Image ();
			image.onload = function (_):Void {
				
				promise.complete (Image.fromImageElement (image));
				
			}
			image.onerror = promise.error;
			image.src = path.get (id);
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Image> (function () return getImage (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = ByteArray.readFile ("../Resources/manifest");
			#elseif ios
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if ios
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadText (id:String):Future<String> {
		
		var promise = new Promise<String> ();
		
		#if html5
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.onComplete.add (function (_):Void {
				
				promise.complete (loader.data);
				
			});
			loader.onProgress.add (function (_, loaded, total) {
				
				if (total == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (loaded / total);
					
				}
				
			});
			loader.onIOError.add (function (_, msg) promise.error (msg));
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getText (id));
			
		}
		
		#else
		
		promise.completeWith (loadBytes (id).then (function (bytes) {
			
			return new Future<String> (function () {
				
				if (bytes == null) {
					
					return null;
					
				} else {
					
					return bytes.readUTFBytes (bytes.length);
					
				}
				
			});
			
		}));
		
		#end
		
		return promise.future;
		
	}
	
	
}


#if !display
#if flash






















































@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif html5
























@:keep #if display private #end class __ASSET__assets_images_digital_ttf extends lime.text.Font { public function new () { super (); name = "Digital-7"; } } 
@:keep #if display private #end class __ASSET__assets_images_elements_ttf extends lime.text.Font { public function new () { super (); name = "BN Elements"; } } 






























@:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { super (); name = "Monsterrat"; } } 




#else

@:keep #if display private #end class __ASSET__assets_images_digital_ttf extends lime.text.Font { public function new () { __fontPath = #if ios "assets/" + #end "assets/images/digital.ttf"; name = "Digital-7"; super (); }}
@:keep #if display private #end class __ASSET__assets_images_elements_ttf extends lime.text.Font { public function new () { __fontPath = #if ios "assets/" + #end "assets/images/ELEMENTS.TTF"; name = "BN Elements"; super (); }}


#if (windows || mac || linux || cpp)


@:file("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends lime.utils.ByteArray {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends lime.utils.ByteArray {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:image("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:image("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__assets_images_digital_ttf extends openfl.text.Font { public function new () { __fontPath = #if ios "assets/" + #end "assets/images/digital.ttf"; name = "Digital-7"; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__assets_images_elements_ttf extends openfl.text.Font { public function new () { __fontPath = #if ios "assets/" + #end "assets/images/ELEMENTS.TTF"; name = "BN Elements"; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_monsterrat_ttf (); src = font.src; name = font.name; super (); }}

#end

#end


#end