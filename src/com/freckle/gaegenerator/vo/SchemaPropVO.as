package com.freckle.gaegenerator.vo
{
	import mx.binding.utils.BindingUtils;
	
	[Bindable]
	public class SchemaPropVO
	{
		public var name:String;
		public var type:SchemaPropTypeVO;
		public var constructorArgs:Array = [];
		public function SchemaPropVO(name:String = "", type:SchemaPropTypeVO = null, constructorArgs:Array = null)
		{
			this.name = name;
			this.type = type;
			if(constructorArgs != null && constructorArgs[0] != ""){
				this.constructorArgs = constructorArgs;
			}
			BindingUtils.bindSetter(onNameChanged,this,"name");
		}
		
		private function onNameChanged(evt:String):void{
			this.name = this.name.split(" ").join("");
		}
		
		public static function fromXML(x:XML):SchemaPropVO{
			return new SchemaPropVO(x.name, SchemaPropTypeVO.fromXML(x.propType[0]), x.constructorArgs.toString().split(","));
		}
		
		public static function toXMLString(vo:SchemaPropVO):String{
			var xmlStr:String = "<schemaProp>";
			xmlStr += "<name>" + vo.name + "</name>";
			xmlStr += "<constructorArgs>" + vo.constructorArgs.toString() + "</constructorArgs>";
			xmlStr += SchemaPropTypeVO.toXMLString(vo.type);
			xmlStr += "</schemaProp>";
			return xmlStr;
		}

	}
}