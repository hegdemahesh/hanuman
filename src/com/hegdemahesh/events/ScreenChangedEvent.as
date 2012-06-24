package com.hegdemahesh.events
{
	import starling.events.Event;
	
	public class ScreenChangedEvent extends Event
	{
		public static const GET:String = "screenChangedEvent";
		public var screenName:String;
		public function ScreenChangedEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
		
	}
}