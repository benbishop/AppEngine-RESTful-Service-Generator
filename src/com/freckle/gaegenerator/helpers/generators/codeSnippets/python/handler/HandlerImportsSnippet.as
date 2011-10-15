package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	public class HandlerImportsSnippet
	{
		public function HandlerImportsSnippet()
		{
		}
		
		public static function generate(object:SchemaObjectVO):String{
			var statements:String = "";
			statements += "import os\r";
			statements += "import sys\r";
			statements += "import time, datetime\r";
			statements += "from google.appengine.ext import db\r";
			statements += "from google.appengine.ext.webapp import template\r";
			statements += "from google.appengine.ext import webapp\r";
			statements += "from google.appengine.api import users\r";
			statements += "from GAEFile import File\r";
			
			statements += "from "+ object.name.toLowerCase() +"data import "+ object.name +"\r";
			
			return statements;
		}
	}
}