package com.freckle.gaegenerator.helpers.generators {
	import com.freckle.gaegenerator.helpers.generators.codeSnippets.xsl.XSLHTMLInputSnippet;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaPropVO;
	
	
    public class XSLTemplateGenerator{
		protected static var generator:com.freckle.gaegenerator.helpers.generators.XSLTemplateGenerator; 
	
		
		public function XSLTemplateGenerator(){	
		
		}
		
		public function generateGetXSLTemplate(object:SchemaObjectVO):String{
			var methodName:String;
			if(object.methodName == null || object.methodName == ""){
				methodName = object.name.toLowerCase();
			}else{
				methodName = object.methodName;
			}
			var script:String = "";
			script += "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r"
			script += "<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">";
			script += "<xsl:template match=\"/\">";
			script += "<html>\r"
			script += "<head>\r";
			script += "<title>Create "+object.name+"</title>\r";
			script += "</head>\r";
			script += "<body>\r";
			script += "<xsl:for-each select=\"//"+object.name.toLowerCase()+"\">";
			script += "<form method=\"POST\" action=\"/"+methodName+"\" enctype=\"multipart/form-data\">\r"
			if(object.parent != null){
				script += "<input type=\"hidden\" name=\""+ object.parent.name.toLowerCase()+"key\" >\r";
				script += "<xsl:attribute name=\"value\"><xsl:value-of select=\""+ object.parent.name.toLowerCase()+"key\"/></xsl:attribute>\r";
				script += "</input>\r";
			}
			
			
			script += "<input type=\"hidden\" name=\"key\" >\r";
			script += "<xsl:attribute name=\"value\"><xsl:value-of select=\"key\"/></xsl:attribute>\r";
			script += "</input>\r";
			for each(var p:SchemaPropVO in object.properties){
				script += "<div id=\""+ p.name +"FormItem\">\r"
				script += "<label>"+p.name+":</label>\r"
				script += XSLHTMLInputSnippet.generate(p);
				script += "</div>\r"
				
			}
			script += "<input id=\""+ object.name +"CreateButton\" type=\"submit\" value=\"Save\"/>\r"
			script += "<a id=\""+ object.name +"DeleteLink\">\r";
				script += "<xsl:attribute name=\"href\">\r"
				script += "/delete?key=<xsl:value-of select=\"key\"/>\r"
				script += "</xsl:attribute>\r"
				script += "Delete\r"
				script += "</a>\r";
			script += "</form>\r";
			for each(var co:SchemaObjectVO in object.children){
				script += "<div id=\""+co.pluralName+"\">";
				script += "<label>" + co.pluralName + ":</label>\r";
				
				
				script += "<a id=\"create"+co.pluralName+"Link\">\r";
				script += "<xsl:attribute name=\"href\">\r"
				script += "/"+ co.methodName +"?"+ object.name.toLowerCase() +"key=<xsl:value-of select=\"key\"/>\r"
				script += "</xsl:attribute>\r"
				script += "Create\r"
				script += "</a>\r";
				script += "<xsl:for-each select=\"//" + co.name.toLowerCase()  + "\">\r"
				script += "<div id=\""+ co.name+"\">\r";
				script += "<a id=\"edit"+co.name+"Link\">\r";
				script += "<xsl:attribute name=\"href\">\r"
				script += "/"+ co.methodName +"?key=<xsl:value-of select=\"key\"/>&amp;"+ object.name.toLowerCase() +"key=<xsl:value-of select=\""+ object.name.toLowerCase() +"key\"/>\r"
				script += "</xsl:attribute>\r"
				script += "<xsl:value-of select=\"key\"/>\r"
				script += "</a>\r";
				script += "</div>\r";
				
				script += "</xsl:for-each>\r";
				script += "</div>\r";	
			}
			script += "</xsl:for-each>";
			script += "</body>\r";
			script += "</html>";
			script += "</xsl:template>";
			script += "</xsl:stylesheet>";
			return script;
		}
		
		
		public function init():void{
			trace("HTMLTemplateGenerator init() called...");
		}
		
		public static function getInstance():com.freckle.gaegenerator.helpers.generators.XSLTemplateGenerator {
			if ( generator == null )
				generator = new com.freckle.gaegenerator.helpers.generators.XSLTemplateGenerator();
			return generator;
		}
		 
	   	
		
		
    }
}

