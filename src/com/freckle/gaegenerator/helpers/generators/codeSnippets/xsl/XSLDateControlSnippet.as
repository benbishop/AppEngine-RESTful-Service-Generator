package com.freckle.gaegenerator.helpers.generators.codeSnippets.xsl
{
	public class XSLDateControlSnippet
	{
		public static function generate(propName:String):String{
			var s:String = "";
			s += "<select name=\""+propName+"Month\">"
			s += "<option value=\"1\">January</option>";
			s += "<option value=\"2\">February</option>";
			s += "<option value=\"3\">March</option>";
			s += "<option value=\"4\">April</option>";
			s += "<option value=\"5\">May</option>";
			s += "<option value=\"6\">June</option>";
			s += "<option value=\"7\">July</option>";
			s += "<option value=\"8\">August</option>";
			s += "<option value=\"9\">September</option>";
			s += "<option value=\"10\">October</option>";
			s += "<option value=\"11\">November</option>";
			s += "<option value=\"12\">December</option>";
			s += "</select>";
			
			s += "<select name=\""+propName+"Day\">"
			for(var i:int = 1; i <= 31; i++){
				s += "<option value=\""+i+"\">"+i+"</option>";
			}
			s += "</select>";
			s += "<select name=\""+propName+"Year\">"
			for(var y:int = 1900; y <= 2050; y++){
				s += "<option value=\""+y+"\">"+y+"</option>";
			}
			s += "</select>";
			return s;
		}

	}
}