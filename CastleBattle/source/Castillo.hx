package;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.FlxG;
/**
 * ...
 * @author Tomás Mugetti
 */
class Castillo extends FlxSprite 
{
	private var esquina:Float;
	private var vida:Int;
	private var barra:FlxBar;
	private var equipo:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, _equipo:Bool, estado:PlayState) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Castillo__png);
		equipo = _equipo;
		immovable = false;
		if (equipo) 
		{
			scale.set(-0.5, 0.5);
			updateHitbox();
			esquina = this.x + this.width;
			barra = new FlxBar(this.x, this.y - 25, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(this.width), 10, this, "vida", 0, 500, true);
			
			
		} else 
		{
			scale.set( 0.5, 0.5);
			updateHitbox();
			esquina = 0;
			barra = new FlxBar(this.x, this.y - 25, FlxBarFillDirection.RIGHT_TO_LEFT, Std.int(this.width), 10, this, "vida", 0, 500, true);
		}
		barra.createFilledBar(FlxColor.TRANSPARENT, FlxColor.RED, true, FlxColor.BLACK);
		estado.add(barra);
		vida = 500;
	}
	
	public function danio(d:Int):Void
	{
		vida -= d;
	}
	public function getEsquina():Float
	{
		return esquina;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		barra.x = this.x;
		//if (FlxG.keys.justPressed.X) 
		//{
			//vida -= 50;
		//}
		if (vida<=0) 
		{
			loadGraphic(AssetPaths.CastilloRoto__png);
			FlxG.camera.shake(0.05, 0.1);
			this.solid = false;
		}
	}
}