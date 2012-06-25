/**
 * The Hanuman Game V1.0
 * Copyright (c) 2012 Maheshchandra hegde, http://www.hegdemahesh.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package
{
	import com.hegdemahesh.ui.Game;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60",width="850",height="600", backgroundColor="0x000000")]
	public class TheHanumanGame extends Sprite
	{
		private var stats:Stats;
		private var myStarling:Starling;
		public function TheHanumanGame()
		{
			
			this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			
		}
		
		protected function onEnterFrame(event:Event):void
		{
			// TODO Auto-generated method stub
			if(stage.loaderInfo.bytesLoaded == stage.loaderInfo.bytesTotal){
				startStarling();
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
			else {
				trace('loading..');
			}
		}
		
		private function startStarling():void
		{
			// TODO Auto Generated method stub
			stats = new Stats();
			this.addChild(stats);
			
			myStarling = new Starling(Game,stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
		}
	}
}