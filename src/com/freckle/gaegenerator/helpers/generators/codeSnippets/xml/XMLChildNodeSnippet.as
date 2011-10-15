package com.freckle.gaegenerator.helpers.generators.codeSnippets.xml
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	public class XMLChildNodeSnippet
	{
		public static function generate(object:SchemaObjectVO, child:SchemaObjectVO):String{
			var childNodeStr:String = "";
			childNodeStr += "<"+child.pluralName.toLowerCase()+">\r"
		    childNodeStr += "{% for o in " + object.name.toLowerCase() + "." + object.name.toLowerCase()+"_"+ child.pluralName + " %}\r"
			childNodeStr += "<" + child.name.toLowerCase() + ">\r"
			childNodeStr += "<key>{{o.key}}</key>\r";
			childNodeStr += "<"+object.name.toLowerCase()+"key>{{o."+object.name.toLowerCase()+".key}}</"+object.name.toLowerCase()+"key>\r";
			childNodeStr += "</" + child.name.toLowerCase() + ">\r"
			childNodeStr += "{% endfor %}\r"
			childNodeStr += "</"+child.pluralName.toLowerCase()+">";
			return childNodeStr;
		}

	}
}