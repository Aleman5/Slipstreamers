package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState 
{
	private var fondo:FlxSprite;
	private var splash:FlxSprite;

	override public function create():Void
	{
		super.create();
		
		var init_x:Int = Math.floor(FlxG.width / 2 - 40);
		var title = new FlxText(175, 200, 0, "SLIPSTREAMERS", 75, true); //Titulo en pantalla
		var butonNew = new FlxButton(init_x, 375, "Start!", onNew); //Boton de inicio
		title.setFormat(AssetPaths.ELEMENTS__TTF,75); //Formato de texto
		butonNew.setGraphicSize(250, 75); //Tamaño de boton
		add(butonNew);
		add(title);
	}
	
	private function onNew(): Void
	{
		var playState:PlayState = new PlayState();
		FlxG.switchState(playState);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}