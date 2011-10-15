package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	public class PluralHandlerClassDeclarationSnippet
	{
		public function PluralHandlerClassDeclarationSnippet()
		{
		}
		
		public static function generate(object:SchemaObjectVO):String{
			return "class " + object.pluralName + "Request(webapp.RequestHandler):\r"
			
		}
	}
}