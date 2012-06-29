package com.hegdemahesh.events
{
	import starling.events.Event;
	
	public class ScoreEvent extends Event
	{
		public static const GET:String = "scoreEvent";
		public var score:int;
		public function ScoreEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}