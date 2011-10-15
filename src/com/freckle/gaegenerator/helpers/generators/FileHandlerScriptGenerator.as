package com.freckle.gaegenerator.helpers.generators {
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.GetHandlerSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.HandlerClassDeclarationSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.HandlerImportsSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.PluralGetHandlerSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.PluralHandlerClassDeclarationSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler.PostHandlerSnippet;
	import com.freckle.gaegenerator.model.AppModelLocator;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	
    public class FileHandlerScriptGenerator{
		protected static var generator:com.freckle.gaegenerator.helpers.generators.FileHandlerScriptGenerator; 
	
		
		public function FileHandlerScriptGenerator(){	
		
		}
		
		public function generateFileHandlerScript():String{
			var s:String = generateImportString();
			s += generateModelString();
			s += generateHandlerString();
			return s;
		}
		
		public function generateImportString():String{
			var script:String = "";
			script += "from google.appengine.ext import db\r";
			script += "from google.appengine.ext import webapp\r"
			return script;
		}
		
		public function generateHandlerString():String{
			var script:String = "";
			script += "class FileRequest(webapp.RequestHandler):\r"
			script += "\tdef get(self):\r"
			script += "\t\tif self.request.get('key'):\r"
			script += "\t\t\tfile = db.get(self.request.get('key'))\r"
			script += "\t\t\tself.response.headers.add_header(\"content-type\", \"image/jpeg\")\r"
			script += "\t\t\tself.response.headers.add_header(\"content-type\", \"image/gif\")\r"
			script += "\t\t\tself.response.headers.add_header(\"content-type\", \"image/png\")\r"
			script += "\t\t\tself.response.out.write(file.contents)\r"
			return script;
		}
		
		public function generateModelString():String{
			var script:String = "";
			script += "class File(db.Model):\r"
			script += "\tname = db.StringProperty()\r"
			script += "\tcontents = db.BlobProperty()\r"
			return script;
		}
		
		public function init():void{
			trace("ModelGenerator init() called...");
		}
		
		public static function getInstance():com.freckle.gaegenerator.helpers.generators.FileHandlerScriptGenerator {
			if ( generator == null )
				generator = new com.freckle.gaegenerator.helpers.generators.FileHandlerScriptGenerator();
			return generator;
		}
		 
	   	
		
		
    }
}

