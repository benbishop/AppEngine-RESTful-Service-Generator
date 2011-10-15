package com.freckle.gaegenerator.helpers.generators.codeSnippets.xml
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaPropVO;
	
	public class XMLPropNodesSnippet
	{
		public static function generate(object:SchemaObjectVO):String{
			var nodesStr:String = "";
			for each(var p:SchemaPropVO in object.properties){
				switch(p.type.name){
					case "IMProperty":
						nodesStr += "\t<" + p.name + " type=\"" + p.type.name + "\"><protocol>{{" + object.name.toLowerCase() + "." + p.name + ".protocol}}</protocol><address>{{" + object.name.toLowerCase() + "." + p.name + ".address}}</address></" + p.name + ">\r";
						break;
					case "GeoPtProperty":
						nodesStr += "\t<" + p.name + " type=\""+ p.type.name +"\"><lat>{{" + object.name.toLowerCase() + "." + p.name + ".lat}}</lat><long>{{" + object.name.toLowerCase() + "." + p.name + ".lon}}</long></" + p.name + ">\r";
						break;
					case "BlobProperty":
						nodesStr += "\t<" + p.name + " type=\""+ p.type.name +"\"><url>/file?key={{"+object.name.toLowerCase() + "." + p.name + "Key}}</url></" + p.name + ">\r";
						break;
					default:
						nodesStr += "\t<" + p.name + " type=\""+ p.type.name +"\">{{" + object.name.toLowerCase() + "." + p.name + "}}</" + p.name + ">\r";
						break;	
				}
				  
			}
			return nodesStr;
		}

	}
}