package com.freckle.gaegenerator.helpers.generators.codeSnippets.python.model
{
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaPropVO;
	
	public class ModelPropertiesDeclarations
	{
		public static function generate(object:SchemaObjectVO):String{
			var props:String = "";
			if(object.parent != null){
				if(object.relationshipType == SchemaObjectVO.ONE_TO_MANY_CHILD){
					props += "\t" + object.parent.name.toLowerCase() + " = db.ReferenceProperty(" + object.parent.name + ", collection_name='"+object.parent.name.toLowerCase()+"_"+ object.pluralName +"')\r"
				}else if( object.relationshipType == SchemaObjectVO.ONE_TO_ONE_CHILD){
					props += "\t" + object.parent.name.toLowerCase() + " = db.ReferenceProperty(" + object.parent.name + ")\r"
				}
			}
			for each(var p:SchemaPropVO in object.properties){
				if(p.type.gaeDeclaration != "db.BlobProperty()"){
					props += "\t" + p.name + " = " + p.type.gaeDeclaration.split("()").join("") + "(" + p.constructorArgs.join(",") + ")\r";
				}else{
					props += "\t" + p.name + "Key = db.StringProperty()\r";
				}	
			}
			return props;
		}

	}
}