package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.controller
{
	import com.freckle.gaegenerator.vo.CustomCGIHandlerVO;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaVO;
	
	public class ControllerMainDefSnippet
	{
		public static function generate(schema:SchemaVO):String{
			var s:String = "";
			s += "def main():\r\n";
			s += "  application = webapp.WSGIApplication([('/', MainHandler)";
			
			for each(var o:SchemaObjectVO in schema.getAllObjects()){
				
			
				s += "," + "('/" + o.methodName + "', "+ o.name +"Request)";
				s += "," + "('/" + o.pluralName.toLowerCase() + "', "+ o.pluralName +"Request)";
			}
			for each(var ch:CustomCGIHandlerVO in schema.customCGIHandlers){
				
			
				s += "," + "('/" + ch.methodName + "', "+ ch.handlerName +")";
			}
			s += ",('/delete', DeleteRequest), ('/file', FileRequest)],";
			s += "debug=True)\n";
			s += "  wsgiref.handlers.CGIHandler().run(application)\n"
			s += "if __name__ == '__main__':\n";
			s += "  main()";
			return s;
		}

	}
}