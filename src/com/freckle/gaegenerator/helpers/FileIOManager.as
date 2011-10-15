package com.freckle.gaegenerator.helpers {
	import com.freckle.gaegenerator.model.AppModelLocator;
	import com.freckle.gaegenerator.vo.SchemaVO;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	

	
	
	
	
	
	
    public class FileIOManager{
		protected static var manager:com.freckle.gaegenerator.helpers.FileIOManager; 
		
	
		
		public function FileIOManager(){	
		
		}
		public function init():void{
			
			
		}
		public function readSchemaFile(f:File):void{
			var stream:FileStream = new FileStream();
		    stream.open(f, FileMode.READ);
		    var xmlStr:String = stream.readUTFBytes(stream.bytesAvailable);
		    AppModelLocator.getInstance().schema = SchemaVO.fromXML(new XML(xmlStr));
		    AppModelLocator.getInstance().schemaXML = AppModelLocator.getInstance().schema.getSchemaXML();
		    AppModelLocator.getInstance().schema.filePath = f.nativePath;
		    AppModelLocator.getInstance().isFileLoaded = true;
		}
		
		public function writeSchemaFile(f:File, contents:String):void{
			var stream:FileStream = new FileStream();
	        stream.open(f, FileMode.WRITE);
	        stream.writeUTFBytes(contents);
	        stream.close();
		}
		
		public static function getInstance():com.freckle.gaegenerator.helpers.FileIOManager {
			if ( manager == null )
				manager = new com.freckle.gaegenerator.helpers.FileIOManager();
			return manager;
		}
		
		
		 
	   	
		
		
    }
}

