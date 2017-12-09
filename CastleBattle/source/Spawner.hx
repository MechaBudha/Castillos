package;
import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;
import personajes.BichoBase;
import personajes.Bruto;
import personajes.Esqueleto;
import personajes.Lancero;
import personajes.Lobo;
import personajes.Pibito;
import personajes.Tauro;
import flixel.FlxG;
/**
 * ...
 * @author Tomás Mugetti
 */
class Spawner extends FlxBasic
{
	private var contadorTiempo:Float;
	private var contadorUnidades:Int;
	private var coolDown:Int;
	private var maxUnidades:Int;
	private var unidades:FlxTypedGroup<BichoBase>;
	private var estado:PlayState;
	private var tipo:String;
	private var equipo:Bool;
	private var esquina:Float;
	public function new(_tipo:String, _unidades:FlxTypedGroup<BichoBase>, _estado:PlayState, _equipo:Bool, _esquina:Float)
	{
		super();
		estado = _estado;
		esquina = _esquina;
		equipo = _equipo;
		tipo = _tipo;
		contadorTiempo = 0;
		contadorUnidades = 0;
		unidades = _unidades;
		switch (tipo)
		{
			case "Pibito":
				maxUnidades = Reg.pibitoMax;
				coolDown = Reg.pibitoCD;
			case "Tauro":
				maxUnidades = Reg.tauroMax;
				coolDown = Reg.tauroCD;
			case "Lobo":
				maxUnidades = Reg.loboMax;
				coolDown = Reg.loboCD;
			case "Lancero":
				maxUnidades = Reg.lanceroMax;
				coolDown = Reg.lanceroCD;
			case "Esqueleto":
				maxUnidades = Reg.esqueMax;
				coolDown = Reg.esqueCD;
			case "Bruto":
				maxUnidades = Reg.brutoMax;
				coolDown = Reg.brutoCD;
			default:
				maxUnidades = 0;
				coolDown = 0;
		}
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (contadorUnidades < maxUnidades)
		{
			contadorTiempo += elapsed;
			if (contadorTiempo >= coolDown)
			{
				var x:Float;
				var bicho:BichoBase;
				if (equipo)
				{
					x = 0;
				}
				else
				{
					x = 1280;
				}
				switch (tipo)
				{
					case "Pibito":
						bicho = new Pibito(x, FlxG.camera.height -60, null, estado, equipo, esquina, this);
					case "Tauro":
						bicho = new Tauro(x, FlxG.camera.height -60, null, estado, equipo, esquina, this);
					case "Esqueleto":
						bicho = new Esqueleto(x, FlxG.camera.height -60, null, estado, equipo, esquina, this);
					case "Lobo":
						bicho = new Lobo(x, FlxG.camera.height -60, null, estado, equipo, esquina, this);
					case "Bruto":
						bicho = new Bruto(x, FlxG.camera.height -60, null, estado, equipo, esquina, this);
					case "Lancero":
						bicho = new Lancero(x, FlxG.camera.height -60, null, estado, equipo, esquina, this);
					default:
						bicho = new BichoBase(x, FlxG.camera.height -60, null, estado, equipo, esquina, this);
				}
				bicho.y -= bicho.height;
				unidades.members.push(bicho);
				estado.add(bicho);
				contadorUnidades++;
				contadorTiempo = 0;
			}
		}
	}
	
	public function muereUnBicho():Void
	{
		contadorUnidades--;
	}
	public function getBichos():Int
	{
		return contadorUnidades;
	}
	public function getMaxBichos():Int
	{
		return maxUnidades;
	}
}