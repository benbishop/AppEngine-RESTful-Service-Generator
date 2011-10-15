package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaVO;
	
	public class GetHandlerSnippet
	{
		public function GetHandlerSnippet()
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
			handlerStr += "\t\tif self.request.get('key'):\r";
			if(object.parent != null){
				handlerStr += "\t\t\t" + object.parent.name.toLowerCase() + "key = self.request.get('"+object.parent.name.toLowerCase()+"key')\r";
			}
			handlerStr += "\t\t\t" + object.name.toLowerCase() + " = db.get(self.request.get('key'))\r";
			handlerStr += "\t\t\ttemplate_values = {\r";
			handlerStr += "\t\t\t\t'"+ object.name.toLowerCase() + "': " + object.name.toLowerCase() +"\r";
			if(object.parent != null){
				handlerStr += "\t\t\t\t,'"+ object.parent.name.toLowerCase() + "key': " + object.parent.name.toLowerCase() +"key\r";
			}
			handlerStr += "\t\t\t}\r"
			handlerStr += "\t\t\tpath = os.path.join(os.path.dirname(__file__), '"+templateFolderName.split("\\").join("/")+ object.name.toLowerCase() +".html')\r";
			handlerStr += "\t\t\tself.response.headers.add_header(\"content-type\", \"text/xml\")\r";
			handlerStr += "\t\t\tself.response.out.write(template.render(path, template_values))\r";
			handlerStr += "\t\telse:\r"
			if(object.parent != null){
				
				handlerStr += "\t\t\t" + object.parent.name.toLowerCase() + "key = self.request.get('"+object.parent.name.toLowerCase()+"key')\r";
				handlerStr += "\t\t\ttemplate_values = {'"+ object.parent.name.toLowerCase() + "key': " + object.parent.name.toLowerCase() +"key}\r"
			}else{
				handlerStr += "\t\t\ttemplate_values = {}\r"
			}
			handlerStr += "\t\t\tself.response.headers.add_header(\"content-type\", \"text/xml\")\r";
			handlerStr += "\t\t\tpath = os.path.join(os.path.dirname(__file__), '"+ templateFolderName.split("\\").join("/") +""+ object.name.toLowerCase() +".html')\r";
			handlerStr += "\t\t\tself.response.out.write(template.render(path, template_values))\r";
			return handlerStr;
		}
	}
}