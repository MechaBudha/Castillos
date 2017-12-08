package personajes;

import flixel.system.FlxAssets.FlxGraphicAsset;
import personajes.BichoBase;

/**
 * ...
 * @author Tomás Mugetti
 */
class Pibito extends personajes.BichoBase 
{
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset, estado:PlayState, _equipo:Bool, _esquina:Float) 
	{
		super(X, Y, SimpleGraphic, estado, _equipo, _esquina);
		loadGraphic(AssetPaths.Char1__png);
		vida = Reg.pibitoVida;
		danio = Reg.pibitoDanio;
		defensa = Reg.pibitoDefensa;
		velocidad = Reg.pibitoVelocidad;
		super.init(estado);
	}
}