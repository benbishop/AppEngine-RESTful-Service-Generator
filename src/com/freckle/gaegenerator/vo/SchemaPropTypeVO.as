package com.freckle.gaegenerator.vo
{
	[Bindable]
	public class SchemaPropTypeVO
	{
		public var name:String;
		public var gaeDeclaration:String;	
		public var as3Declaration:String;
		public function SchemaPropTypeVO(name:String = "", gaeDeclaration:String = "", as3Declaration:String = "")
		{
			this.name = name;
			this.gaeDeclaration = gaeDeclaration;
			this.as3Declaration = as3Declaration;
		}
		
		public static function fromXML(x:XML):SchemaPropTypeVO{
			return new SchemaPropTypeVO(x.name, x.gaeDeclaration, x.as3Declaration);
		}
		
		public static function toXMLString(vo:SchemaPropTypeVO):String{
			var xmlStr:String = "<propType>";
			xmlStr += "<name>" + vo.name + "</name>";
			xmlStr += "<gaeDeclaration>" + vo.gaeDeclaration + "</gaeDeclaration>";
			xmlStr += "<as3Declaration>" + vo.as3Declaration + "</as3Declaration>";
			xmlStr += "</propType>";
			return xmlStr;
		}

	}
}