package personajes;

import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.FlxObject;

/**
 * ...
 * @author Tomás Mugetti
 */
class BichoBase extends FlxSprite 
{
	private var vida:Int;
	private var danio:Int;
	private var defensa:Int;
	private var emisor:FlxEmitter;
	private var barra:FlxBar;
	private var equipo:Bool;
	private var esquina:Float;
	private var velocidad:Int;
	private var orden:Float;
	private var creador:Spawner;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, estado:PlayState, _equipo:Bool, _esquina:Float, _creador:Spawner) 
	{
		super(X, Y, SimpleGraphic);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		equipo = _equipo;
		esquina = _esquina;
		creador = _creador;
		orden = esquina;
		emisor = new FlxEmitter(this.x + this.width / 2,this.y + this.height/2,30);
		emisor.focusOn(this);
		estado.add(emisor);
		scale.set(0.3, 0.3);
	}
	public function recibirDanio(d:Int):Void
	{
		vida -= Std.int(d/defensa);
	}
	public function getDanio():Int
	{
		return danio;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		maquina();
		if (vida <= 0) 
		{
			emisor.makeParticles(1, 1, FlxColor.RED, 30);
			emisor.lifespan.set(0.3, 1);
			emisor.start(true);
			destroy();
		}
	}
	override public function destroy():Void
	{
		creador.muereUnBicho();
		barra.destroy();
		emisor.destroy();
		super.destroy();
	}
	private function init(estado:PlayState):Void
	{
		updateHitbox();
		if (equipo) 
		{
			barra = new FlxBar(this.x, this.y, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(this.width), 10, this, "vida", 0, vida, true);
			
		} else 
		{
			barra = new FlxBar(this.x, this.y, FlxBarFillDirection.RIGHT_TO_LEFT, Std.int(this.width), 10, this, "vida", 0, vida, true);
			
		}
		
		
		barra.createFilledBar(FlxColor.TRANSPARENT, FlxColor.RED, true, FlxColor.BLACK);
		barra.trackParent(0, -15);
		estado.add(barra);
	}
	
	private function maquina():Void
	{
		
		if (velocity.x > 0) 
		{
			facing = FlxObject.RIGHT;
		} else if (velocity.x < 0) 
		{
			facing = FlxObject.LEFT;
		}
		if (this.x > orden - 6) 
		{
			velocity.x = -velocidad;
		}
		if (this.x < orden + 6) 
		{
			velocity.x = velocidad;
		}
		if (this.x > orden - 3 && this.x < orden + 3) 
		{
			velocity.x = 0;
		}
	}
	
	public function recibirOrden(o:Int):Void
	{
		switch (o) 
		{
			case 0:
				orden = esquina;
			case 1:
				orden = this.x;
			case 2:
				if (equipo) 
				{
					orden = 1280;
				} else 
				{
					orden = 0;
				}
			default:
				
		}
	}
	public function getOrden():Float
	{
		return orden;
	}
	public function chocar():Void
	{
		velocity.x = 0;
	}
}