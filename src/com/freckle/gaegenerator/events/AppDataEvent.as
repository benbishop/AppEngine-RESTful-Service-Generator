package com.freckle.gaegenerator.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class AppDataEvent extends CairngormEvent
	{
		
		public static var GET_PROP_TYPES:String = "getPropTypes";
		public static var NEW_SCHEMA:String = "newSchema";
		public static var IMPORT_SCHEMA:String = "importSchema";
		public static var SAVE_SCHEMA:String = "saveSchema";
		public static var SAVE_SCHEMA_AS:String = "saveSchemaAs";
		public static var SCHEMA_CHANGED:String = "schemaChanged";
		public static var CLOSE_SCHEMA:String = "closeSchema";
		
		public function AppDataEvent(s:String)
		{
			super(s, false, true);
			
			
		}
	}
}
