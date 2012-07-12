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
	//import com.hegdemahesh.ui.Game;
	
	import com.hegdemahesh.ui.components.LoadingImage;
	
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	import starling.display.Image;
	
	[SWF(frameRate="60",width="850",height="600", backgroundColor="0x000000")]
	public class TheHanumanGame extends MovieClip
	{
		private var stats:Stats;
		private var myStarling:Starling;
		private var loadingImage:LoadingImage;
		public function TheHanumanGame()
		{
			
			stop();
			loadingImage = new LoadingImage();
			this.addChild(loadingImage);
			//this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgressEvent);
			loaderInfo.addEventListener(Event.COMPLETE,onLoadComplete);
			
		}
		
		protected function onLoadComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			
			this.removeChild(loadingImage);
			this.removeEventListener(Event.COMPLETE,onLoadComplete);
			startStarling();	
			
		}		
		
		
		
		
		private function startStarling():void
		{
			// TODO Auto Generated method stub
			
			
			gotoAndStop(2);
			
			stats = new Stats();
			this.addChild(stats);
			/*uncomment below code to run in software mode*/
			
			//this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			//myStarling = new Starling(Game,stage,null,null,"software");
			var Game:Class = getDefinitionByName("com.hegdemahesh.ui.Game") as Class;
			
			myStarling = new Starling(Game,stage);
			
			
			myStarling.antiAliasing = 1;
			myStarling.start();
			
			//this.removeChild(loadingImage);
			
			
			//loaderInfo.addEventListener(Event.COMPLETE,onGameLoadComplete);
		}
		
		protected function onProgressEvent(event:ProgressEvent):void
		{
			// TODO Auto-generated method stub
			
			
			if(loaderInfo.bytesLoaded == loaderInfo.bytesTotal){
				
				//this.removeChild(loadingImage);
				this.removeEventListener(ProgressEvent.PROGRESS,onProgressEvent);
				//startStarling();
			}
			else {
				loadingImage.x = int(850 * (event.bytesLoaded / event.bytesTotal));
			}
			
		}
		
		
	}
}