package com.freckle.gaegenerator.helpers.generators {
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.xml.XMLChildNodesSnippet;
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.xml.XMLPropNodesSnippet;
	import com.freckle.gaegenerator.model.AppModelLocator;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	import flash.filesystem.File;
	
	
    public class XMLTemplateGenerator{
		protected static var generator:com.freckle.gaegenerator.helpers.generators.XMLTemplateGenerator; 
	
		
		public function XMLTemplateGenerator(){	
		
		}
		
		public function generateGetXMLTemplate(object:SchemaObjectVO):String{
			var file:File = new File(AppModelLocator.getInstance().schema.xslDir);
			
			var script:String = "<?xml-stylesheet type=\"text/xsl\" href=\"/"+file.name+"/"+object.name.toLocaleLowerCase()+".xsl\"?>";
			script += 
			script += "<" + object.name.toLowerCase() + ">\r"
			if(object.parent != null){
				script += "{% if " + object.parent.name.toLowerCase() + "key %}\r";
				script += "<" + object.parent.name.toLowerCase() + "key>{{" + object.parent.name.toLowerCase() + "key}}</" + object.parent.name.toLowerCase() + "key>\r";
				script += "{%else%}\r";
				script += "{%endif%}\r";
			}
			
			script += "<key>{{"+object.name.toLowerCase()+".key}}</key>\r"
			script += XMLPropNodesSnippet.generate(object);
			script += XMLChildNodesSnippet.generate(object);
			
			script += "</" + object.name.toLowerCase() + ">";
			return script;
		}
		public function generatePluralGetXMLTemplate(object:SchemaObjectVO):String{
			var file:File = new File(AppModelLocator.getInstance().schema.xslDir);
			
			var script:String = "<?xml-stylesheet type=\"text/xsl\" href=\"/"+file.name+"/"+object.name.toLocaleLowerCase()+".xsl\"?>\r";
			script += "<" + object.pluralName.toLowerCase() + ">\r";
			script += "{% for "+ object.name.toLowerCase()+" in "+ object.pluralName.toLowerCase() +" %}\r"
			script += "<" + object.name.toLowerCase() + ">\r"
			script += "<key>{{"+object.name.toLowerCase()+".key}}</key>\r"
			script += XMLPropNodesSnippet.generate(object);
			script += XMLChildNodesSnippet.generate(object);
			script += "</" + object.name.toLowerCase() + ">\r";
			script += "{% endfor %}";
			script += "</" + object.pluralName.toLowerCase() + ">\r";
			return script;
		}
		public function init():void{
			trace("XMLTemplateGenerator init() called...");
		}
		
		public static function getInstance():com.freckle.gaegenerator.helpers.generators.XMLTemplateGenerator {
			if ( generator == null )
				generator = new com.freckle.gaegenerator.helpers.generators.XMLTemplateGenerator();
			return generator;
		}
		 
	   	
		
		
    }
}

