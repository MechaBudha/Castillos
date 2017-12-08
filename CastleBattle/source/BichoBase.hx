package;

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
	private var orden:Int; //0 rendev, 1 marchar, 2 parar, 3 retroceder
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, estado:PlayState, _equipo:Bool, _esquina:Float) 
	{
		super(X, Y, SimpleGraphic);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		equipo = _equipo;
		esquina = _esquina;
		emisor = new FlxEmitter(this.x + this.width / 2,this.y + this.height/2,30);
		emisor.focusOn(this);
		estado.add(emisor);
		orden = 0;
		scale.set(0.3,0.3);
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
		barra.destroy();
		emisor.destroy();
		super.destroy();
	}
	private function init(estado:PlayState):Void
	{
		if (equipo) 
		{
			barra = new FlxBar(this.x, this.y, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(this.width), 10, this, "vida", 0, vida, true);
			
		} else 
		{
			barra = new FlxBar(this.x, this.y, FlxBarFillDirection.RIGHT_TO_LEFT, Std.int(this.width), 10, this, "vida", 0, vida, true);
			velocidad = -velocidad;
		}
		
		
		barra.createFilledBar(FlxColor.TRANSPARENT, FlxColor.RED, true, FlxColor.BLACK);
		barra.trackParent(0, -15);
		estado.add(barra);
	}
	
	private function maquina():Void
	{
		if (velocity.x >= 0) 
		{
			facing = FlxObject.RIGHT;
		} else 
		{
			facing = FlxObject.LEFT;
		}
		switch (orden) 
		{
			case 0:
				if (this.x < esquina ) 
				{
					velocity.x = Math.abs(velocidad);
				} else if (this.x > esquina) 
				{
					velocity.x = -(Math.abs(velocidad))
				} else
				{
					velocity.x = 0;
				}
			case 1:
				velocity.x = velocidad;
			case 2:
				velocity.x = 0;
			case 3:
				velocity.x = -velocidad;
			default:
				velocity.x = 0;
		}
	}
	
	public function recibirOrden(o:Int):Void
	{
		orden = o;
	}
	public function getOrden():Int
	{
		return orden;
	}
}