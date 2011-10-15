package com.freckle.gaegenerator.vo
{
	public class FileRefVO
	{
		public var fileName:String="";
		public var filePath:String = "";
		
		public function FileRefVO(fileName:String, filePath:String)
		{
			this.fileName = fileName;
			this.filePath = filePath;
		}
		
		public static function fromXML(x:XML):FileRefVO{
			return new FileRefVO(x.fileName,x.filePath);
		}
		public static function toXMLString(vo:FileRefVO):String{
			var xmlStr:String = "<fileRef>";
			xmlStr += "<fileName>" + vo.fileName + "</fileName>";
			xmlStr += "<filePath>" + vo.filePath + "</filePath>";
			xmlStr += "</fileRef>";
			return xmlStr;
		}

	}
}