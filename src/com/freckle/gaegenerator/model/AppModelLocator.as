package com.freckle.gaegenerator.model {
	import com.adobe.cairngorm.model.ModelLocator;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaVO;
	import com.freckle.gaegenerator.vo.UserPrefsVO;
	
	import mx.collections.ArrayCollection;
	
	
    public class AppModelLocator implements com.adobe.cairngorm.model.ModelLocator{
		protected static var modelLocator:com.freckle.gaegenerator.model.AppModelLocator; 
	
		[Bindable]
		public var propTypes:ArrayCollection;
		[Bindable]
		public var schema:SchemaVO;
		[Bindable]
		public var schemaXML:XML;
		[Bindable]
		public var selectedSchemaObj:SchemaObjectVO;
		[Bindable]
		public var isUnsaved:Boolean = false;
		[Bindable]
		public var isFileLoaded:Boolean = false;
		[Bindable]
		public var userPrefs:UserPrefsVO;
		
		public function AppModelLocator(){	
		
		}
		
		public function init():void{
			trace("ModelLocator init() called...");
		}
		
		public static function getInstance():com.freckle.gaegenerator.model.AppModelLocator {
			if ( modelLocator == null )
				modelLocator = new com.freckle.gaegenerator.model.AppModelLocator();
			return modelLocator;
		}
		 
	   	
		
		
    }
}

