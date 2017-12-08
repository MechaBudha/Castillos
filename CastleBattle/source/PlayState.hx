package;

import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;

class PlayState extends FlxState
{
	private var jesus:FlxSprite;
	private var castilloAliado:Castillo;
	private var castilloEnemigo:Castillo;
	private var piso:FlxSprite;
	
	private var bichoPrueda:Pibito;
	override public function create():Void
	{
		super.create();
		FlxG.worldBounds.set(0, 0, 1280, 300);
		FlxG.camera.setScrollBounds(0, 1280, 0, 300);
		
		jesus = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		jesus.makeGraphic(1, 1, 0x00000000);
		FlxG.camera.follow(jesus);
		add(jesus);
		piso = new FlxSprite(0, FlxG.height - 50);
		piso.makeGraphic(1280, 50, 0x00000000);
		add(piso);
		
		add(new FlxSprite(0, 0, AssetPaths.FondoBeta__png));
		
		castilloAliado = new Castillo(0, 0, null, true,this);
		castilloAliado.y = piso.y - castilloAliado.height;
		add(castilloAliado);
		
		castilloEnemigo = new Castillo(0, 0, null, false,this);
		castilloEnemigo.x = 1280 - castilloEnemigo.width;
		castilloEnemigo.y = piso.y - castilloEnemigo.height;
		add(castilloEnemigo);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		cameraControl();
	}
	private function cameraControl():Void
	{
		if (FlxG.mouse.screenX >= FlxG.camera.width - 20 || FlxG.keys.pressed.RIGHT) 
		{
			jesus.velocity.x = 75;
		} else if (FlxG.mouse.screenX <= 20 || FlxG.keys.pressed.LEFT) 
		{
			jesus.velocity.x = -75;
		} else 
		{
			jesus.velocity.x = 0;
		}
	}
}