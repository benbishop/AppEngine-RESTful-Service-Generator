package com.freckle.gaegenerator.helpers.generators.codeSnippets.xsl
{
	public class XSLTimeControlSnippet
	{
		public static function generate(propName:String):String{
			var s:String = "";
			s += "<select name=\""+propName+"Hour\">"
			for(var h:int = 0; h <= 23; h++){
				s += "<option value=\""+h+"\">"+h+"</option>";
			}
			s += "</select>";
			
			s += ":<select name=\""+propName+"Minute\">"
			for(var m:int = 0; m <= 59; m++){
				s += "<option value=\""+m+"\">"+m+"</option>";
			}
			s += "</select>";
			
			s += ":<select name=\""+propName+"Seconds\">"
			for(var sec:int = 0; sec <= 59; sec++){
				s += "<option value=\""+sec+"\">"+sec+"</option>";
			}
			s += "</select>";
			
			s += ":<select name=\""+propName+"Microseconds\">"
			for(var ms:int = 0; ms <= 59; ms++){
				s += "<option value=\""+ms+"\">"+ms+"</option>";
			}
			s += "</select>";
			
			return s;
		}

	}
}