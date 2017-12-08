package personajes;

import flixel.system.FlxAssets.FlxGraphicAsset;
import personajes.BichoBase;

/**
 * ...
 * @author Tomás Mugetti
 */
class Lobo extends personajes.BichoBase 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, estado:PlayState, _equipo:Bool, _esquina:Float) 
	{
		super(X, Y, SimpleGraphic, estado, _equipo, _esquina);
		loadGraphic(AssetPaths.NPC1__png);
		vida = Reg.loboVida;
		danio = Reg.loboDanio;
		defensa = Reg.loboDefensa;
		velocidad = Reg.loboVelocidad;
		super.init(estado);
	}
	
}