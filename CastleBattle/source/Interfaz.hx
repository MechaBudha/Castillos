package;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
/**
 * ...
 * @author Tomás Mugetti
 */
class Interfaz extends FlxBasic
{
	private var estado:PlayState;
	private var equipoAliado:Array<String>;
	private var piso:FlxSprite;
	private var al1btn:FlxButton;
	private var al2btn:FlxButton;
	private var al3btn:FlxButton;
	private var contador:Int;
	private var creadores:FlxTypedGroup<Spawner>;
	private var textos:FlxTypedGroup<FlxText>;
	public function new(_estado:PlayState, _piso:FlxSprite, aliados:Array<String>, _creadores:FlxTypedGroup<Spawner>) 
	{
		super();
		estado = _estado;
		piso = _piso;
		equipoAliado = aliados;
		creadores = _creadores;
		contador = -1;
		textos = new FlxTypedGroup<FlxText>();
		estado.add(textos);
		crearBtn(al1btn, aliados[0]);
		crearBtn(al2btn, aliados[1]);
		crearBtn(al3btn, aliados[2]);
	}
	private function crearBtn(btn:FlxButton, tipo:String):Void
	{
		var lugar:Int;
		contador++;
		switch (contador) 
		{
			case 0:
				lugar = 5;
			case 1:
				lugar = 65;
			case 2:
				lugar = 125;
			default:
				lugar = 0;
		}
		btn = new FlxButton(lugar, piso.y + 5, "");
		var imagen:FlxGraphicAsset;
		var cooldown:Float = 0;
		switch (tipo) 
		{
			case "Pibito":
				imagen = Reg.pibitoIcon;
				cooldown = Reg.pibitoCD;
			case "Tauro":
				imagen = Reg.tauroIcon;
				cooldown = Reg.tauroCD;
			case "Lobo":
				imagen = Reg.loboIcon;
				cooldown = Reg.loboCD;
			case "Lancero":
				imagen = Reg.lanceroIcon;
				cooldown = Reg.lanceroCD;
			case "Esqueleto":
				imagen = Reg.esqueIcon;
				cooldown = Reg.esqueCD;
			case "Bruto":
				imagen = Reg.brutoIcon;
				cooldown = Reg.brutoCD;
			default:
				imagen = null;
		}
		btn.loadGraphic(imagen);
		btn.updateHitbox;
		btn.scrollFactor.set(0, 0);
		estado.add(btn);
		var barra:FlxBar;
		barra = new FlxBar(lugar, btn.y, FlxBarFillDirection.LEFT_TO_RIGHT, 50, 50, creadores.members[contador], "contadorTiempo", 0, cooldown, false);
		barra.createColoredEmptyBar(FlxColor.TRANSPARENT, false);
		barra.createColoredFilledBar(0x5500FF00, false);
		barra.scrollFactor.set(0,0);
		estado.add(barra);
		textos.members.push(new FlxText(btn.getMidpoint().x, btn.y + btn.height - 5, 0, ""));
		textos.members[contador].scrollFactor.set(0,0);
		estado.add(textos.members[contador]);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		for (i in 0 ... 3) 
		{
			textos.members[i].text = creadores.members[i].getBichos() + "/" + creadores.members[i].getMaxBichos();
		}
	}
}