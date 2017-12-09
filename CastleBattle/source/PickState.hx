package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;

/**
 * ...
 * @author Tomás Mugetti
 */
class PickState extends FlxState 
{
	private var pibitoBtn:FlxButton;
	private var lanceroBtn:FlxButton;
	private var tauroBtn:FlxButton;
	private var esqueBtn:FlxButton;
	private var loboBtn:FlxButton;
	private var brutoBtn:FlxButton;
	private var contador:Int;
	private var pickTxt:FlxText;
	private var aliados:Array<String>;
	private var enemigos:Array<String>;
	public function new() 
	{
		super();
		aliados = new Array<String>();
		enemigos = new Array<String>();
		contador = 0;
		pickTxt = new FlxText(0, 0, 0, "Elige tu equipo", 16);
		pickTxt.screenCenter();
		pickTxt.y = pickTxt.height + 5;
		add(pickTxt);
		
		pibitoBtn = new FlxButton(100, 50, "", pickPibito);
		pibitoBtn.loadGraphic(Reg.pibitoIcon);
		pibitoBtn.updateHitbox();
		add(pibitoBtn);
		
		lanceroBtn = new FlxButton(175, 50, "", pickLancero);
		lanceroBtn.loadGraphic(Reg.lanceroIcon);
		lanceroBtn.updateHitbox();
		add(lanceroBtn);
		
		tauroBtn = new FlxButton(275, 50, "", pickTauro);
		tauroBtn.loadGraphic(Reg.tauroIcon);
		tauroBtn.updateHitbox();
		add(tauroBtn);
		
		loboBtn = new FlxButton(100, 100, "", pickLobo);
		loboBtn.loadGraphic(Reg.loboIcon);
		loboBtn.updateHitbox();
		add(loboBtn);
		
		esqueBtn = new FlxButton(175, 100, "", pickEsque);
		esqueBtn.loadGraphic(Reg.esqueIcon);
		esqueBtn.updateHitbox();
		add(esqueBtn);
		
		brutoBtn = new FlxButton(275, 100, "", pickBruto);
		brutoBtn.loadGraphic(Reg.brutoIcon);
		brutoBtn.updateHitbox();
		add(brutoBtn);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		cambio();
	}
	private function pickPibito():Void
	{
		aliados.push("Pibito");
		remove(pibitoBtn);
		enemigos.push("Esqueleto");
		remove(esqueBtn);
		contador++;
	}
	private function pickLancero():Void
	{
		aliados.push("Lancero");
		remove(lanceroBtn);
		enemigos.push("Lobo");
		remove(loboBtn);
		contador++;
	}
	private function pickTauro():Void
	{
		aliados.push("Tauro");
		remove(tauroBtn);
		enemigos.push("Bruto");
		remove(brutoBtn);
		contador++;
	}
	
	private function pickEsque():Void
	{
		aliados.push("Esqueleto");
		remove(esqueBtn);
		enemigos.push("Pibito");
		remove(pibitoBtn);
		contador++;
	}
	private function pickLobo():Void
	{
		aliados.push("Lobo");
		remove(loboBtn);
		enemigos.push("Lancero");
		remove(lanceroBtn);
		contador++;
	}
	private function pickBruto():Void
	{
		aliados.push("Bruto");
		remove(brutoBtn);
		enemigos.push("Tauro");
		remove(tauroBtn);
		contador++;
	}
	private function cambio():Void
	{
		if (contador>=3) 
		{
			PlayState.cargarEquipos(aliados,enemigos);
			FlxG.switchState(new PlayState());
		}
		
	}
}