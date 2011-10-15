package com.freckle.gaegenerator.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class UserPrefsVO
	{
		public var lastDirectoryOpened:String;
		public var recentFiles:ArrayCollection = new ArrayCollection();
		
		public function UserPrefsVO(lastDirectoryOpened:String, recentFiles:ArrayCollection)
		{
			this.lastDirectoryOpened = lastDirectoryOpened;
			if(recentFiles == null){
				this.recentFiles = new ArrayCollection();
			}else{
				this.recentFiles = recentFiles;
			}
		}
		
		public static function fromXML(x:XML):UserPrefsVO{
			var fac:ArrayCollection = new ArrayCollection();
			for each(var fx:XML in x..fileRef){
				fac.addItem(FileRefVO.fromXML(fx));
			}
			return new UserPrefsVO(x.lastDirectoryOpened,fac);
		}
		
		public static function toXMLString(vo:UserPrefsVO):String{
			var xmlStr:String = "<userPrefs>";
			xmlStr += "<lastDirectoryOpened>" + vo.lastDirectoryOpened + "</lastDirectoryOpened>";
			xmlStr += "<recentFiles>";
			for each(var fr:FileRefVO in vo.recentFiles){
				xmlStr += FileRefVO.toXMLString(fr);
			}
			xmlStr += "</recentFiles>";
			xmlStr += "</userPrefs>";
			
			return xmlStr;
		}

	}
}

