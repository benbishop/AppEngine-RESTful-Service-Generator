package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	public class HandlerClassDeclarationSnippet
	{
		public function HandlerClassDeclarationSnippet()
		{
		}
		
		public static function generate(object:SchemaObjectVO):String{
			return "class " + object.name + "Request(webapp.RequestHandler):\r"
			
		}
	}
}