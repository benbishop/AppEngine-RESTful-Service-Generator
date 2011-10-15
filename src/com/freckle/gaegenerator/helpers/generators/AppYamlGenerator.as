package com.freckle.gaegenerator.helpers.generators {
	import com.freckle.gaegenerator.model.AppModelLocator;
	import com.freckle.gaegenerator.vo.CustomAppYAMLHandlerVO;
	
	import flash.filesystem.File;
	
	
    public class AppYamlGenerator{
		protected static var generator:com.freckle.gaegenerator.helpers.generators.AppYamlGenerator; 
	
		
		public function AppYamlGenerator(){	
		
		}
		
		public function generateAppYaml():String{
			
			var file:File = new File(AppModelLocator.getInstance().schema.xslDir);
			
			var s:String = ""
			s += "application: "+AppModelLocator.getInstance().schema.appName+"\r"
			s += "version: 1\r";
			s += "runtime: python\r";
			s+= "api_version: 1\r\r";
			s += "handlers:\r";
			s += "- url: /"+ file.name +"\r";
  			s += "  static_dir: "+ file.name+"\r";
			s += "- url: /.*\r";
  			s += "  script: main.py\r";
			for each(var h:CustomAppYAMLHandlerVO in AppModelLocator.getInstance().schema.customAppYAMLHandlers){
				s += "- url: "+ h.url +"\r";
				s += "  static_dir: "+ h.staticDir +"\r";
			}
			return s;
		}
		
		
		
		public function init():void{
			trace("AppYamlGenerator init() called...");
		}
		
		public static function getInstance():com.freckle.gaegenerator.helpers.generators.AppYamlGenerator {
			if ( generator == null )
				generator = new com.freckle.gaegenerator.helpers.generators.AppYamlGenerator();
			return generator;
		}
		 
	   	
		
		
    }
}

