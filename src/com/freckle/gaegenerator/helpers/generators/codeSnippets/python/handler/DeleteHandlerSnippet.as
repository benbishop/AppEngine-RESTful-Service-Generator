package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler
{
	public class DeleteHandlerSnippet
	{
		public static function generate():String{
			var s:String = ""
			s += "import os\n";
			s += "import sys\n";
			s += "from google.appengine.ext import db\n";
			s += "from google.appengine.ext import webapp\n";
			s += "class DeleteRequest(webapp.RequestHandler):\n";
			s += "\tdef get(self):\n";
			s += "\t\titem = db.get(self.request.get('key'))\n";
			s += "\t\titem.delete()\n";
			return s;
		}
	}
}