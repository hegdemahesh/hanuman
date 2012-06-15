package
{
	import com.hegdemahesh.ui.Game;
	
	import flash.display.Sprite;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60",width="850",height="622", backgroundColor="0x333333")]
	public class TheHanumanGame extends Sprite
	{
		private var stats:Stats;
		private var myStarling:Starling;
		public function TheHanumanGame()
		{
			stats = new Stats();
			this.addChild(stats);
			
			myStarling = new Starling(Game,stage);
			//myStarling = new Starling(Demo,stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
		}
	}
}