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
	
	import com.hegdemahesh.ui.components.LoadingImage;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	import starling.core.Starling;
	
	/**
	 * The class is the main application file.
	 * @author hegdemahesh website://www.hegdemahesh.com
	 *
	 */
	
	[SWF(frameRate="60",width="850",height="600", backgroundColor="0x000000")]
	public class TheHanumanGame extends MovieClip
	{
		/**
		 * A starling Game calss. This class initiates starling game engine.
		 */
		private var myStarling:Starling;
		/**
		 * this class is works as a progress bar
		 */
		private var loadingImage:LoadingImage;
		/**
		 * Application constructor
		 */
		public function TheHanumanGame()
		{
			
			stop();
			loadingImage = new LoadingImage();
			this.addChild(loadingImage);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgressEvent);
			loaderInfo.addEventListener(Event.COMPLETE,onLoadComplete);
			
		}
		/**
		 * this function is executed once application loading is completed
		 */
		protected function onLoadComplete(event:Event):void
		{
			this.removeChild(loadingImage);
			this.removeEventListener(Event.COMPLETE,onLoadComplete);
			startStarling();	
			
		}		
		
		
		/**
		 * this function starts the game engine
		 */
		
		private function startStarling():void
		{
			gotoAndStop(2);
			
			var Game:Class = getDefinitionByName("com.hegdemahesh.ui.Game") as Class;
			myStarling = new Starling(Game,stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
			
			
		}
		/**
		 * this function is executed while application is downloading in progress
		 */
		
		protected function onProgressEvent(event:ProgressEvent):void
		{
			if(loaderInfo.bytesLoaded == loaderInfo.bytesTotal){
				
				this.removeEventListener(ProgressEvent.PROGRESS,onProgressEvent);
			}
			else {
				loadingImage.percentLoad = int(100 * (event.bytesLoaded / event.bytesTotal));
			}
			
		}
		
		
	}
}