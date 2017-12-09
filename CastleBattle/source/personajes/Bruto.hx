package personajes;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Tomás Mugetti
 */
class Bruto extends personajes.BichoBase 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, estado:PlayState, _equipo:Bool, _esquina:Float, _creador:Spawner) 
	{
		super(X, Y, SimpleGraphic, estado, _equipo, _esquina, _creador);
		loadGraphic(AssetPaths.NPC4__png);
		vida = Reg.brutoVida;
		danio = Reg.brutoDanio;
		defensa = Reg.brutoDefensa;
		velocidad = Reg.brutoVelocidad;
		super.init(estado);
	}
	
}