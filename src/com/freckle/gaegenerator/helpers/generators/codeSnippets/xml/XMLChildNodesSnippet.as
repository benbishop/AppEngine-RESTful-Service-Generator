package com.freckle.gaegenerator.helpers.generators.codeSnippets.xml
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	public class XMLChildNodesSnippet
	{
		public static function generate(object:SchemaObjectVO):String{
			var script:String = "";
			for each(var co:SchemaObjectVO in object.children){
				script += XMLChildNodeSnippet.generate(object, co);
			}
			return script;
		}

	}
}