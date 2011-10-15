package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.controller
{
	import com.freckle.gaegenerator.vo.CustomCGIHandlerVO;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaVO;
	
	public class ControllerImportStatementsSnippet
	{
		public static function generate(schema:SchemaVO):String{
		
			var statements:String = "";
			statements += "\nimport wsgiref.handlers\n\n";
			statements += "from google.appengine.ext import webapp\n";
			for each(var o:SchemaObjectVO in schema.getAllObjects()){
				statements += "from "+o.name.toLowerCase()+"controls import "+o.name+"Request\n";
				statements += "from "+o.name.toLowerCase()+"controls import "+o.pluralName+"Request\n";
			}
			for each(var ch:CustomCGIHandlerVO in schema.customCGIHandlers){
				statements += "from " + ch.fileName + " import " + ch.handlerName + "\n";
			}
			statements += "from deletehandler import DeleteRequest\n";
			statements += "from GAEFile import FileRequest\n";
			return statements;
		}

	}
}