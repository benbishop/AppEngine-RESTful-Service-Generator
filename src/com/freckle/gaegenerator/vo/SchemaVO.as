package com.freckle.gaegenerator.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class SchemaVO
	{
		public var name:String;
		public var appName:String;
		public var objects:ArrayCollection;
		public var filePath:String;
		//generation props
		public var createdBy:String="";
		public var copyrightText:String="";
		public var gaeAppDir:String="";
		public var templatesDir:String="";
		public var xslDir:String = "";
		
		public var customCGIHandlers:ArrayCollection = new ArrayCollection();
		public var customAppYAMLHandlers:ArrayCollection = new ArrayCollection();
		
		public function SchemaVO(name:String = "", objects:ArrayCollection= null, customHandlers:ArrayCollection = null, customAppYAMLHandlers:ArrayCollection = null)
		{
			this.name = name;
			if(objects != null){
				this.objects = objects;
			}else{
				this.objects = new ArrayCollection();
			}
			if(customCGIHandlers != null){
				this.customCGIHandlers = customCGIHandlers;
			}
			if(customAppYAMLHandlers != null){
				this.customAppYAMLHandlers = customAppYAMLHandlers;
			}
		}
		
		public function getSchemaXML():XML{
			var xmlStr:String = "<object name=\"" + this.name + "\" id=\"0\">";
			var i:int = 0;
			for each(var o:SchemaObjectVO in objects){
				xmlStr += getChildrenXMLString(o,"0", i);
				i++;
			}
			xmlStr += "</object>";
			return new XML(xmlStr);
		}
		
		public function getObjectById(id:String):SchemaObjectVO{
			var a:Array = id.split("_");
			var o:SchemaObjectVO = this.objects.getItemAt(parseInt(a[1])) as SchemaObjectVO;
			for(var i:int = 2; i<a.length; i++){
				o = o.children.getItemAt(parseInt(a[i])) as SchemaObjectVO;
			}
			return o;
		}
		
		public function getObjectParent(id:String):*{
			var a:Array = id.split("_");
			if(id == "0"){
				return null;
			}
			if(a.length == 2){
				return this;
			}
			var o:SchemaObjectVO = this.objects.getItemAt(parseInt(a[1])) as SchemaObjectVO;
			for(var i:int = 2; i<a.length-1; i++){
				o = o.children.getItemAt(parseInt(a[i])) as SchemaObjectVO;
			}
			return o;
		}
		public function getAllObjects():ArrayCollection{
			var ac:ArrayCollection = new ArrayCollection();
			for each(var o:SchemaObjectVO in this.objects){
				ac.addItem(o);
				var sac:ArrayCollection = getAllChildren(o);
				for each(var so:SchemaObjectVO in sac){
					ac.addItem(so);
				}
			}
			return ac;
		}
		private function getAllChildren(o:SchemaObjectVO):ArrayCollection{
			var ac:ArrayCollection = new ArrayCollection();
			for each(var co:SchemaObjectVO in o.children){
				ac.addItem(co);
				var sac:ArrayCollection = getAllChildren(co);
				for each(var cso:SchemaObjectVO in sac){
					ac.addItem(cso);
				}
			}
			return ac;
		}
		
		private function getChildrenXMLString(o:SchemaObjectVO, levelID:String, itemNum:int):String{
			var idStr:String = levelID + "_" + itemNum;
			var xmlStr:String = "<object name=\"" + o.name + "\" id=\"" + idStr + "\">";
			var i:int = 0; 
			for each(var co:SchemaObjectVO in o.children){
				xmlStr += getChildrenXMLString(co,idStr, i);
				i++;
			}
			xmlStr += "</object>";
			return xmlStr;
		}
		
		public static function fromXML(x:XML):SchemaVO{
			
			var ac:ArrayCollection = new ArrayCollection();
			for each(var ox:XML in x.schemaObject){
				ac.addItem(SchemaObjectVO.fromXML(ox));
			}
			var vo:SchemaVO = new SchemaVO(x.name, ac);
		
			var hc:ArrayCollection = new ArrayCollection();
			for each(var hx:XML in x.customCGIHandler){
				hc.addItem(CustomCGIHandlerVO.fromXML(hx));
			}
			vo.customCGIHandlers = hc;
			
			var ahc:ArrayCollection = new ArrayCollection();
			for each(var ahx:XML in x.customAppYAMLHandler){
				ahc.addItem(CustomAppYAMLHandlerVO.fromXML(ahx));
			}
			vo.customAppYAMLHandlers = ahc;
			vo.appName = x.appName;
			vo.createdBy = x.createdBy;
			vo.copyrightText = x.copyrightText; 
			vo.gaeAppDir = x.gaeAppDir;
			vo.templatesDir = x.templatesDir;
			vo.xslDir = x.xslDir;
			return vo;
		}
		
		public static function toXMLString(vo:SchemaVO):String{
			var xmlStr:String = "<schema>";
			xmlStr += "<name>" + vo.name + "</name>"
			xmlStr += "<appName>" + vo.appName + "</appName>";
			xmlStr += "<createdBy>" + vo.createdBy + "</createdBy>"
			xmlStr += "<copyrightText>" + vo.copyrightText + "</copyrightText>"
			xmlStr += "<gaeAppDir>" + vo.gaeAppDir + "</gaeAppDir>";
			xmlStr += "<templatesDir>" + vo.templatesDir + "</templatesDir>";
			xmlStr += "<xslDir>" + vo.xslDir + "</xslDir>";
			for each(var o:SchemaObjectVO in vo.objects){
				xmlStr += SchemaObjectVO.toXMLString(o);
			}
			for each(var ch:CustomCGIHandlerVO in vo.customCGIHandlers){
				xmlStr += CustomCGIHandlerVO.toXMLString(ch);
			}
			for each(var cah:CustomAppYAMLHandlerVO in vo.customAppYAMLHandlers){
				xmlStr += CustomAppYAMLHandlerVO.toXMLString(cah);
			}
			xmlStr += "</schema>";
			return xmlStr;
		}

	}
}