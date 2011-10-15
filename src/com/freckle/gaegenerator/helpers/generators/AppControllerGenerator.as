package com.freckle.gaegenerator.helpers.generators {
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.controller.ControllerClassDeclarationSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.controller.ControllerGetDef;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.controller.ControllerImportStatementsSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.controller.ControllerMainDefSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.DeleteHandlerSnippet;
	import com.freckle.gaegenerator.vo.SchemaVO;
	
	import mx.collections.ArrayCollection;
	
    /**
     * 
     * @author BenBishop
     * This singleton class creates the application cgi handler
     * 
     */	
    public class AppControllerGenerator{
		//singleton ref
		protected static var generator:com.freckle.gaegenerator.helpers.generators.AppControllerGenerator; 
	
		//constructor	
		public function AppControllerGenerator(){	
		
		}
			
		public function generateDeleteHanlder():String{
			return DeleteHandlerSnippet.generate();
		}
		
		/**
		 * This generates the entire code for main.py 
		 * @param schema SchemaVO
		 * @return String contents of file
		 * 
		 */		
		public function generateAppController(schema:SchemaVO):String{
			var objects:ArrayCollection = schema.getAllObjects();
			
			var script:String = "";
			script += ControllerImportStatementsSnippet.generate(schema);
			script += ControllerClassDeclarationSnippet.generate();
			script += ControllerGetDef.generate();
			script += ControllerMainDefSnippet.generate(schema);
			return script;
		}
		/**
		 * Init function 
		 * 
		 */		
		public function init():void{
			trace("XMLTemplateGenerator init() called...");
		}
		/**
		 * Singleton instance method
		 * @return Instance of the AppControllerGenerator
		 * 
		 */		
		public static function getInstance():com.freckle.gaegenerator.helpers.generators.AppControllerGenerator {
			if ( generator == null )
				generator = new com.freckle.gaegenerator.helpers.generators.AppControllerGenerator();
			return generator;
		}
		 
	   	
		
		
    }
}

