package com.freckle.gaegenerator.vo
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	[Bindable]
	public class SchemaObjectVO
	{
		public static var ONE_TO_ONE_CHILD:String = "oneToOneChild";
		public static var ONE_TO_MANY_CHILD:String = "oneToManyChild";
		
		public var name:String;
		public var properties:ArrayCollection;
		public var children:ArrayCollection;
		public var parent:SchemaObjectVO;
		public var isMany:Boolean = false;
		public var generateModel:Boolean = true;
		public var generateHandler:Boolean = true;
		public var generateXSL:Boolean = true;
		public var generateXMLResponse:Boolean = true;
		public var relationshipType:String;
		//getter/setters
		private var _methodName:String = "";
		public function get methodName():String{
			if(_methodName == null || _methodName == ""){
				return name.toLowerCase();
			}
			return _methodName;
		}
		public function set methodName(s:String):void{
			_methodName = s;
		}
		private var _pluralName:String = "";
		public function get pluralName():String{
			if(_pluralName == null || _pluralName == ""){
				return name + "s";
			}
			return _pluralName;
		}
		public function set pluralName(s:String):void{
			_pluralName = s;
		}
		//constructor
		public function SchemaObjectVO(
										name:String = "", 
										properties:ArrayCollection = null, 
										children:ArrayCollection = null, 
										pluralName:String = "", 
										methodName:String="",
										generateModel:Boolean = true,
										generateHandler:Boolean = true,
										generateXSL:Boolean = true,
										generateXMLResponse:Boolean = true,
										relationshipType:String = "")
		{
			this.name = name;
			this.pluralName = pluralName;
			this.methodName = methodName;
			this.properties = properties;
			this.generateModel = generateModel;
			this.generateHandler = generateHandler;
			this.generateXSL = generateXSL;
			this.generateXMLResponse = generateXMLResponse;
			this.relationshipType = relationshipType;
			if(children != null){
				this.children = children;
			}else{
				this.children = new ArrayCollection();
			}
			this.children.addEventListener(CollectionEvent.COLLECTION_CHANGE, onChildAddedRemoved);
			for each(var so:SchemaObjectVO in this.children){
				so.parent = this;
			}
		}
		
		private function onChildAddedRemoved(evt:CollectionEvent):void{
			if(evt.kind == "add"){
				for each(var so:SchemaObjectVO in evt.items){
					so.parent = this;
					so.relationshipType = SchemaObjectVO.ONE_TO_MANY_CHILD;
				}
			}
		}
		
		public static function fromXML(x:XML):SchemaObjectVO{
			var pac:ArrayCollection = new ArrayCollection();
			for each(var px:XML in x.schemaProp){
				pac.addItem(SchemaPropVO.fromXML(px));
			}
			var cac:ArrayCollection = new ArrayCollection();
			for each(var cx:XML in x.schemaObject){
				cac.addItem(SchemaObjectVO.fromXML(cx));
			}
			
			return new SchemaObjectVO(x.name, pac, cac, x.pluralName, x.methodName, x.generateModel=="true", x.generateHandler=="true", x.generateXSL=="true", x.generateXMLResponse=="true", x.relationshipType);
			
		}
		
		public static function toXMLString(vo:SchemaObjectVO):String{
			var xmlStr:String = "<schemaObject>";
			xmlStr += "<name>" + vo.name + "</name>";
			xmlStr += "<pluralName>" + vo.pluralName + "</pluralName>";
			xmlStr += "<methodName>" + vo.methodName + "</methodName>";
			
			xmlStr += "<generateModel>" + vo.generateModel + "</generateModel>";
			xmlStr += "<generateHandler>" + vo.generateHandler + "</generateHandler>";
			xmlStr += "<generateXSL>" + vo.generateXSL + "</generateXSL>";
			xmlStr += "<generateXMLResponse>" + vo.generateXMLResponse + "</generateXMLResponse>";
			xmlStr += "<relationshipType>" + vo.relationshipType + "</relationshipType>";
			for each(var sp:SchemaPropVO in vo.properties){
				xmlStr += SchemaPropVO.toXMLString(sp);
			}
			for each(var c:SchemaObjectVO in vo.children){
				xmlStr += SchemaObjectVO.toXMLString(c);
			}
			xmlStr += "</schemaObject>"
			return xmlStr;
		}

	}
}