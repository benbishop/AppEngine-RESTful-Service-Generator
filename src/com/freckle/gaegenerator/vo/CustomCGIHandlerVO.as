package com.freckle.gaegenerator.vo
{
	[Bindable]
	public class CustomCGIHandlerVO
	{
		public var methodName:String;
		public var handlerName:String;
		public var fileName:String;
		public function CustomCGIHandlerVO(methodName:String, handlerName:String, fileName:String)
		{
			this.methodName = methodName;
			this.handlerName = handlerName;
			this.fileName = fileName;	
		}
		
		public static function fromXML(x:XML):CustomCGIHandlerVO{
			return new CustomCGIHandlerVO(x.methodName, x.handlerName, x.fileName);
		}
		
		public static function toXMLString(vo:CustomCGIHandlerVO):String{
			var s:String = "<customCGIHandler>";
			s += "<methodName>" + vo.methodName + "</methodName>";
			s += "<handlerName>" + vo.handlerName + "</handlerName>";
			s += "<fileName>" + vo.fileName + "</fileName>";
			s += "</customCGIHandler>";
			return s;
		}

	}
}