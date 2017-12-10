package;

import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import personajes.BichoBase;

class PlayState extends FlxState
{
	private var jesus:FlxSprite;
	private var castilloAliado:Castillo;
	private var castilloEnemigo:Castillo;
	private var piso:FlxSprite;
	private static var equipoAliado:Array<String>;
	private static var equipoEnemigo:Array<String>;
	private var interfaz:Interfaz;
	private var aliados:FlxTypedGroup<BichoBase>;
	private var enemigos:FlxTypedGroup<BichoBase>;
	private var spawnersAliados:FlxTypedGroup<Spawner>;
	private var spawnersEnemigos:FlxTypedGroup<Spawner>;
	override public function create():Void
	{
		super.create();
		FlxG.worldBounds.set(0, 0, 1280, 300);
		FlxG.camera.setScrollBounds(0, 1280, 0, 300);
		
		jesus = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		jesus.makeGraphic(1, 1, 0x00000000);
		FlxG.camera.follow(jesus);
		add(jesus);
		
		add(new FlxSprite(0, 0, AssetPaths.FondoFinal__png));
		
		piso = new FlxSprite(0, FlxG.height - 60);
		piso.makeGraphic(1280, 60, 0xFF000000);
		add(piso);
		
		castilloAliado = new Castillo(0, piso.y - 187.5, null, true,this);
		add(castilloAliado);
		
		castilloEnemigo = new Castillo(1030, piso.y - 187.5, null, false,this);
		add(castilloEnemigo);
		
		for (i in 0 ... 3) 
		{
			trace(equipoAliado[i]);
		}
		
		aliados = new FlxTypedGroup<BichoBase>();
		enemigos = new FlxTypedGroup<BichoBase>();
		spawnersAliados = new FlxTypedGroup<Spawner>();
		spawnersEnemigos = new FlxTypedGroup<Spawner>();
		add(aliados);
		add(enemigos);
		for (j in 0 ... 3) 
		{
			spawnersAliados.members.push(new Spawner(equipoAliado[j], aliados, this, true, castilloAliado.getEsquina()));
			spawnersEnemigos.members.push(new Spawner(equipoEnemigo[j], enemigos, this, false, castilloEnemigo.getEsquina()));
		}
		interfaz = new Interfaz(this, piso, equipoAliado, spawnersAliados);
	}
	public static function cargarEquipos(aliados:Array<String>, enemigos:Array<String>)
	{
		equipoAliado = new Array<String>();
		equipoEnemigo = new Array<String>();
		
		for (i in 0 ... 3) 
		{
			equipoAliado.push(aliados[i]);
			equipoEnemigo.push(enemigos[i]);
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		cameraControl();
		for (i in 0 ... 3) 
		{
			spawnersAliados.members[i].update(elapsed);
			spawnersEnemigos.members[i].update(elapsed);
		}
		interfaz.update(elapsed);
		FlxG.collide(castilloAliado, enemigos, atacarCastillo);
		FlxG.collide(castilloEnemigo, aliados, atacarCastillo);
		FlxG.collide(aliados, enemigos, atacarBicho);
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
		
		if (jesus.x < FlxG.camera.width/2) 
		{
			jesus.x = FlxG.camera.width / 2;
		}
		if (jesus.x >1280 - (FlxG.camera.width/2)) 
		{
			jesus.x = 1280 - (FlxG.camera.width / 2);
		}
	}
	
	public function darOrden(o:Int):Void
	{
		for (i in 0 ... aliados.members.length) 
		{
			aliados.members[i].recibirOrden(o);
		}
	}
	private function atacarCastillo(cas:Castillo,bic:BichoBase)
	{
		cas.danio(bic.getDanio());
	}
	private function atacarBicho(bic1:BichoBase,bic2:BichoBase)
	{
		bic1.recibirDanio(bic2.getDanio());
		bic2.recibirDanio(bic1.getDanio());
	}
	
	
}