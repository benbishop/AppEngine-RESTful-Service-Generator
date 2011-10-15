package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.handler
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaPropVO;
	
	public class PostHandlerSnippet
	{
		public function PostHandlerSnippet()
		{
		}

		public static function generate(object:SchemaObjectVO):String{
			var p:SchemaPropVO;
			var handlerStr:String = "";
			
			handlerStr += "\tdef post(self):\r"
			handlerStr += "\t\tif self.request.get('key'):\r"
			handlerStr += "\t\t\t"+ object.name.toLowerCase() +" = db.get(self.request.get('key'))\r"
			
			if(object.parent != null){
				handlerStr += "\t\t\tif self.request.get('" + object.parent.name.toLowerCase() + "key'):\r"
				handlerStr += "\t\t\t\t" + object.name.toLowerCase() + "."+ object.parent.name.toLowerCase() + " = db.get(self.request.get('"+object.parent.name.toLowerCase()+"key'))\r";
			}
			
			for each(p in object.properties){
				switch(p.type.name){
					case "GeoPtProperty":
						handlerStr += "\t\t\tif self.request.get('"+p.name+"Lat') and self.request.get('"+p.name+"Long'):\r";
						handlerStr += "\t\t\t\t" + AssigmentLineSnippet.generate(p, object);
						break;
						
					case "BlobProperty":
						handlerStr += "\t\t\tif self.request.get('"+p.name+"'):\r";
						handlerStr += "\t\t\t\tf = File()\r"
						handlerStr += "\t\t\t\tf.name = self.request.POST.get('"+ p.name +"').filename\r"
						handlerStr += "\t\t\t\tf.contents = self.request.POST.get('"+ p.name +"').file.read()\r"
						handlerStr += "\t\t\t\tf.put()\r";
						handlerStr += "\t\t\t\t" + AssigmentLineSnippet.generate(p, object);
						break;
						
					case "IMProperty":
						handlerStr += "\t\t\tif self.request.get('"+p.name+"Address') and self.request.get('"+p.name+"Protocol'):\r";
						handlerStr += "\t\t\t\t" + AssigmentLineSnippet.generate(p, object);
						break;	
					
					default:
						handlerStr += "\t\t\tif self.request.get('"+p.name+"'):\r";
						handlerStr += "\t\t\t\t" + AssigmentLineSnippet.generate(p, object);
						break;
				
				}
			}
			handlerStr += "\t\t\t" + object.name.toLowerCase() + ".put()\r";
			handlerStr += RedirectSnippet.generate(object); 
			handlerStr += "\t\telse:\r";
			handlerStr += "\t\t\t" + object.name.toLowerCase() + " = " + object.name +"()\r"
			if(object.parent != null){
				handlerStr += "\t\t\tif self.request.get('" + object.parent.name.toLowerCase() + "key'):\r"
				handlerStr += "\t\t\t\t" + object.name.toLowerCase() + "."+ object.parent.name.toLowerCase() + " = db.get(self.request.get('"+object.parent.name.toLowerCase()+"key'))\r";
			}
			
			for each(p in object.properties){
				handlerStr += "\t\t\t" + AssigmentLineSnippet.generate(p, object);
			}
			handlerStr += "\t\t\t" + object.name.toLowerCase() + ".put()\r";
			//handlerStr += "\t\t\tself.response.out.write('Record created with an id of: ' + str(" + object.name.toLowerCase() + ".key()))\r";
			handlerStr += RedirectSnippet.generate(object); 
			return handlerStr;
		}
	}
}