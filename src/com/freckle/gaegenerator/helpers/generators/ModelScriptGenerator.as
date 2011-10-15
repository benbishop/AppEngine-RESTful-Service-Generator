package com.freckle.gaegenerator.helpers.generators {
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.model.ModelClassDeclarationSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.model.ModelImportStatementsSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.model.ModelPropertiesDeclarations;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	
    public class ModelScriptGenerator{
		protected static var generator:com.freckle.gaegenerator.helpers.generators.ModelScriptGenerator; 
	
		
		public function ModelScriptGenerator(){	
		
		}
		
		public function generateModelString(object:SchemaObjectVO):String{
			var script:String = "";
			script += ModelImportStatementsSnippet.generate(object);
			script += ModelClassDeclarationSnippet.generate(object);
			script += ModelPropertiesDeclarations.generate(object);
			return script;
		}
		
		
		
		
		
		
		
		public function init():void{
			trace("ModelGenerator init() called...");
		}
		
		public static function getInstance():com.freckle.gaegenerator.helpers.generators.ModelScriptGenerator {
			if ( generator == null )
				generator = new com.freckle.gaegenerator.helpers.generators.ModelScriptGenerator();
			return generator;
		}
		 
	   	
		
		
    }
}

