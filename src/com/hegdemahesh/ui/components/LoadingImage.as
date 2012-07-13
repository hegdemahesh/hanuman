package com.hegdemahesh.ui.components
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class LoadingImage extends Sprite
	{
		[Embed(source="assets/hanumanPreloader.png")]
		public static const HanumanPreloader:Class;
		
		[Embed(source="assets/preloader.png")]
		public static const Preloader:Class;
		
		[Embed(source="assets/bar.png")]
		public static const bar:Class;
		
		private var _percentLoad:int;
		
		
		public function LoadingImage()
		{
			
			drawImages();
			
			
			super();
		}
		
		private function drawImages():void
		{
			// TODO Auto Generated method stub
			this.graphics.clear();
			var barData:BitmapData = (new bar()).bitmapData;
			var bitmapData:BitmapData = (new Preloader()).bitmapData;
			var logoBitmapData:BitmapData = (new HanumanPreloader()).bitmapData;
			//drawImage(this.graphics,barData,268,462);
			drawLoader(barData,268,462);
			drawImage(this.graphics,bitmapData,int((850 - bitmapData.width)/2),450);
			drawImage(this.graphics,logoBitmapData,int((850 - logoBitmapData.width)/2),390);
			barData = null;
			bitmapData = null;
			logoBitmapData = null;
		}
		
		public function drawLoader(image:BitmapData, x:int, y:int):void {
			var loaderWidth:int = 0;
			while (_percentLoad  > (loaderWidth * 100/290)){
				drawImage(this.graphics,image,x+loaderWidth,462);
				loaderWidth = loaderWidth + image.width;
			}
		}
		
		public function set percentLoad(percent:int):void {
			_percentLoad = percent;
			drawImages();
			
		}
		public function get percentLoad():int {
			return _percentLoad;
		}
		public static function drawImage(g:Graphics, image:BitmapData, x:int, y:int):void {
			var mtx:Matrix = new Matrix();
			mtx.translate(x, y);
			g.beginBitmapFill(image, mtx, false, false);
			g.drawRect(x, y, image.width, image.height);
			g.endFill();
		}

	}
}