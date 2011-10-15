package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaVO;
	
	public class PluralGetHandlerSnippet
	{
		public function PluralGetHandlerSnippet()
		{
		}
		
		public static function generate(object:SchemaObjectVO, schema:SchemaVO):String{
			
			var templateFolderName:String
			if(schema.templatesDir.indexOf("/") != -1){
				templateFolderName = schema.templatesDir.split("/").pop() + "/";
			}else{
				templateFolderName = schema.templatesDir.split("\\").pop() + "\\";
			}
			var handlerStr:String = "";
			handlerStr += "\tdef get(self):\r";
			
			handlerStr += "\t\t\t" + object.pluralName.toLowerCase() + " = " + object.name + ".all()\r";
			handlerStr += "\t\t\ttemplate_values = {'"+object.pluralName.toLowerCase() + "':" + object.pluralName.toLowerCase() + "}\r"
			handlerStr += "\t\t\tself.response.headers.add_header(\"content-type\", \"text/xml\")\r";
			handlerStr += "\t\t\tpath = os.path.join(os.path.dirname(__file__), '"+ templateFolderName +""+ object.pluralName.toLowerCase() +".html')\r";
			handlerStr += "\t\t\tself.response.out.write(template.render(path, template_values))\r";
			return handlerStr;
		}
	}
}