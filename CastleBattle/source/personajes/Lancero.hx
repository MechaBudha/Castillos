package personajes;

import flixel.system.FlxAssets.FlxGraphicAsset;
import personajes.BichoBase;

/**
 * ...
 * @author Tomás Mugetti
 */
class Lancero extends personajes.BichoBase 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, estado:PlayState, _equipo:Bool, _esquina:Float) 
	{
		super(X, Y, SimpleGraphic, estado, _equipo, _esquina);
		loadGraphic(AssetPaths.NPC2__png);
		vida = Reg.lanceroVida;
		danio = Reg.lanceroDanio;
		defensa = Reg.lanceroDefensa;
		velocidad = Reg.lanceroVelocidad;
		super.init(estado);
	}
	
}