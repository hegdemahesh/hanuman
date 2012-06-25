package com.hegdemahesh.events
{
	import starling.events.Event;
	
	public class SponsorScreenChanged extends Event
	{
		public static const GET:String = "sponsorScreeChanged";
		public function SponsorScreenChanged(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}