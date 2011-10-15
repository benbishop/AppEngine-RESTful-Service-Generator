package com.freckle.gaegenerator.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;

	public class FileGeneratorEvent extends CairngormEvent
	{
		
		public var object:SchemaObjectVO;
		
		public static var GENERATION_DONE:String = "generationDone";
		public static var START_GENERATION:String = "startGeneration";
		public static var GENERATE_APP_YAML:String = "generateAppYaml";
		public static var GENERATE_MODEL:String = "generateModel";
		public static var GENERATE_REST_HANDLER:String = "generateResthandler";
		public static var GENERATE_XML_RESPONSE:String = "generateXMLResponse";
		public static var GENERATE_XSL:String = "generateXSL";
		public static var GENERATE_APP_CONTROLLER:String = "generateAppController";
		public static var GENERATE_DELETE_HANDLER:String = "generateDeleteHandler";
		public static var GENERATE_FILE_HANDLER:String = "generateFileHandler";
		public function FileGeneratorEvent(s:String)
		{
			super(s, false, true);
			
			
		}
	}
}
