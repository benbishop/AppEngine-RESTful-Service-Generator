package com.freckle.gaegenerator.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class AppEvent extends CairngormEvent
	{
		//trace("AppEvent constructor called");
		public static var APP_LOAD:String = "appLoad";
		public static var APP_UIINIT:String = "appUiInit"
		public static var APP_EXIT:String = "appExit";
		
		public function AppEvent(s:String)
		{
			//trace("AppEvent constructor called: " + s);
			super(s, false, true);
			
			
		}
	}
}
