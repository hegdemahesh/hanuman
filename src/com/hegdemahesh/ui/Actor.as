package com.hegdemahesh.ui
{
	import nape.phys.Body;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Actor extends Sprite
	{
		public var image:Image ;
		public var body:Body;
		public var imgSrc:String;
		
		public var idString:String;
		public var xcord:int;
		public var ycord:int;
		public var material:String;
		public var flammable:Boolean;
		public var crushable:Boolean = false;
		public var crushed:Boolean = false;
		
		public var damage:Number = 0;
		
		public function Actor(src:String=null)
		{
			
			if (src!= null){
				imgSrc = src;
				image =  new Image(Assets.getAtlas().getTexture(src));
				this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
			}
			
			super();
			
		}
		
		public function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			this.addChild(image);
			pivotX = width >> 1;
			pivotY = height >> 1;
		}
	}
}