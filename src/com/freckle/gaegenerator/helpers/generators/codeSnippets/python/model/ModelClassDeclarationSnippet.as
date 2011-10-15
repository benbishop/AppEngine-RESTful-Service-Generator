package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.model
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	public class ModelClassDeclarationSnippet
	{
		public static function generate(object:SchemaObjectVO):String{
			return "class "+object.name+"(db.Model):\r";
		}

	}
}