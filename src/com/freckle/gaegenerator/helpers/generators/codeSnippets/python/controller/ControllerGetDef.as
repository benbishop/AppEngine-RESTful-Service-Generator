package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.controller
{
	public class ControllerGetDef
	{
		public static function generate():String{
			var s:String = "";
			s += "  def get(self):\n";
			s += "    self.response.out.write('Hello world!')\n"
    
			return s;
		}

	}
}