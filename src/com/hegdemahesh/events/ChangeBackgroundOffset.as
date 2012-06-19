package com.hegdemahesh.events
{
	import starling.events.Event;
	
	public class ChangeBackgroundOffset extends Event
	{
		public static const GET:String = "changeBackgroundOffset";
		public var globalXOffset:int;
		
		public function ChangeBackgroundOffset(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}