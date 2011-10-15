package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.model
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	public class ModelImportStatementsSnippet
	{
		public static function generate(object:SchemaObjectVO):String{
			var statements:String = "";
			statements += "from google.appengine.ext import db\r";
			if(object.parent != null){
				statements += "from "+object.parent.name.toLowerCase() +"data import "+ object.parent.name+" \r";
			}
			return statements;
		}
	}
}