package com.freckle.gaegenerator.helpers.generators.codeSnippets.xsl
{
	import com.freckle.gaegenerator.vo.SchemaPropVO;
	
	public class XSLHTMLInputSnippet
	{
		public static function generate(prop:SchemaPropVO):String{
			var s:String = "";
			switch(prop.type.name){
				case "GeoPtProperty":
					s += "Latitude: <input type=\"text\" name=\"" + prop.name + "Lat\">\r";
					s += "<xsl:attribute name=\"value\"><xsl:value-of select=\""+ prop.name +"/lat\"/></xsl:attribute>";
					s += "</input>\r";
					s += " Longitude: <input type=\"text\" name=\"" + prop.name + "Long\">\r";
					s += "<xsl:attribute name=\"value\"><xsl:value-of select=\""+ prop.name +"/long\"/></xsl:attribute>";
					s += "</input>\r";
					break;
				case "IMProperty":
					s += XSLIMControl.generate(prop.name);
				
					s += "<input type=\"text\" name=\""+ prop.name +"Address\">";
					s += "<xsl:attribute name=\"value\">";
					s += "<xsl:value-of select=\""+prop.name+"/address\"/>";
					s += "</xsl:attribute>"	
					s += "</input>";
					break;
				case "BooleanProperty":
					s += "<input type=\"radio\" name=\""+prop.name+"\" value=\"true\"/>True";
					s += "<input type=\"radio\" name=\""+prop.name+"\" value=\"false\"/>False";
					break;
				case "TextProperty":
					s += "<textarea name=\""+ prop.name+"\" rows=\"6\" cols=\"40\">"
					s += "<xsl:value-of select=\""+ prop.name +"\"/>";
					s += "</textarea>"
					break;
				case "TimeProperty":
					s += XSLTimeControlSnippet.generate(prop.name);
					break;
				case "DateTimeProperty":
					s += XSLDateControlSnippet.generate(prop.name);
					s += " ";
					s += XSLTimeControlSnippet.generate(prop.name);
					break;
				case "DateProperty":
					s += XSLDateControlSnippet.generate(prop.name);
					break;
				case "BlobProperty":
					s += "<input type=\"file\" name=\""+prop.name+"\"/>";
					break;
				default:
					s += "<input type=\"text\" name=\"" + prop.name + "\" >\r";
					s += "<xsl:attribute name=\"value\"><xsl:value-of select=\""+ prop.name +"\"/></xsl:attribute>";
					s += "</input>";
					break;
			}
			return s;
		}

	}
}