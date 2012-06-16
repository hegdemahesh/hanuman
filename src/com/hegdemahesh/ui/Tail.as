package com.hegdemahesh.ui
{
	import starling.events.Event;

	public class Tail extends Actor
	{
		public function Tail(src:String=null)
		{
			super(src);
		}
		public override function onAddedToStage(event:Event):void {
			this.addChild(image);
			pivotX = 81;
			pivotY = 120;
		}
	}
}