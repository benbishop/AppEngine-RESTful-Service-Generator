package com.freckle.gaegenerator.vo
{
	public class CustomAppYAMLHandlerVO
	{
		public var url:String;
		public var staticDir:String;
		
		public function CustomAppYAMLHandlerVO(url:String, staticDir:String)
		{
			this.url = url;
			this.staticDir = staticDir;
		}
		
		public static function fromXML(x:XML):CustomAppYAMLHandlerVO{
			return new CustomAppYAMLHandlerVO(x.url,x.staticDir);
		}
		
		public static function toXMLString(vo:CustomAppYAMLHandlerVO):String{
			var xmlStr:String = "<customAppYAMLHandler>";
			xmlStr += "<url>" + vo.url + "</url>";
			xmlStr += "<staticDir>" + vo.staticDir + "</staticDir>";
			xmlStr += "</customAppYAMLHandler>";
			return xmlStr;
		}

	}
}