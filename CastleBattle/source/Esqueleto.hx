package;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Tomás Mugetti
 */
class Esqueleto extends BichoBase 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, estado:PlayState, _equipo:Bool, _esquina:Float) 
	{
		super(X, Y, SimpleGraphic, estado, _equipo, _esquina);
		loadGraphic(AssetPaths.NPC5__png);
		vida = Reg.esqueVida;
		danio = Reg.esqueDanio;
		defensa = Reg.esqueDefensa;
		velocidad = Reg.esqueVelocidad;
		super.init(estado);
	}
	
}