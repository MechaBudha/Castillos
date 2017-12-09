package personajes;

import flixel.system.FlxAssets.FlxGraphicAsset;
import personajes.BichoBase;

/**
 * ...
 * @author Tomás Mugetti
 */
class Esqueleto extends personajes.BichoBase 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, estado:PlayState, _equipo:Bool, _esquina:Float, _creador:Spawner) 
	{
		super(X, Y, SimpleGraphic, estado, _equipo, _esquina,_creador);
		loadGraphic(AssetPaths.NPC5__png);
		vida = Reg.esqueVida;
		danio = Reg.esqueDanio;
		defensa = Reg.esqueDefensa;
		velocidad = Reg.esqueVelocidad;
		super.init(estado);
	}
	
}