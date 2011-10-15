package com.freckle.gaegenerator.helpers.generators {
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.GetHandlerSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.HandlerClassDeclarationSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.HandlerImportsSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.PluralGetHandlerSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.PluralHandlerClassDeclarationSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.PostHandlerSnippet;
	import com.freckle.gaegenerator.model.AppModelLocator;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	
    public class HandlerScriptGenerator{
		protected static var generator:com.freckle.gaegenerator.helpers.generators.HandlerScriptGenerator; 
	
		
		public function HandlerScriptGenerator(){	
		
		}
		
		public function generateHandlerString(object:SchemaObjectVO):String{
			var script:String = "";
			script += HandlerImportsSnippet.generate(object);
			script += HandlerClassDeclarationSnippet.generate(object);
			script += GetHandlerSnippet.generate(object,AppModelLocator.getInstance().schema);
			script += PostHandlerSnippet.generate(object);
			script += PluralHandlerClassDeclarationSnippet.generate(object);
			script += PluralGetHandlerSnippet.generate(object,AppModelLocator.getInstance().schema);
			return script;
		}
		
		public function init():void{
			trace("ModelGenerator init() called...");
		}
		
		public static function getInstance():com.freckle.gaegenerator.helpers.generators.HandlerScriptGenerator {
			if ( generator == null )
				generator = new com.freckle.gaegenerator.helpers.generators.HandlerScriptGenerator();
			return generator;
		}
		 
	   	
		
		
    }
}

