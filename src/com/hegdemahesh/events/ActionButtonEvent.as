package com.hegdemahesh.events
{
	import starling.events.Event;
	
	public class ActionButtonEvent extends Event
	{
		public static const GET:String = "actionButtonClickedEvent";
		public var actionString:String;
		public function ActionButtonEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}