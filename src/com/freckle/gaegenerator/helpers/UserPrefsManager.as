package com.freckle.gaegenerator.helpers {

	
	import com.freckle.gaegenerator.model.AppModelLocator;
	import com.freckle.gaegenerator.vo.FileRefVO;
	import com.freckle.gaegenerator.vo.UserPrefsVO;
	
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.binding.utils.BindingUtils;
	
	public class UserPrefsManager{
		protected static var manager:com.freckle.gaegenerator.helpers.UserPrefsManager; 
		private var model:AppModelLocator = AppModelLocator.getInstance();
		private var conn:SQLConnection;
	
		
		public function UserPrefsManager(){	
		
		}
		public function init():void{
			conn = new SQLConnection(); 
			conn.addEventListener(SQLEvent.OPEN, sqlOpenHandler); 
			conn.addEventListener(SQLErrorEvent.ERROR, sqlErrorHandler); 
			
			
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath("gaeBuilder.db"); 
			conn.openAsync(dbFile); 
			
			
		}
		
		
		
		public function savePrefs():void{
			var clearStmt:SQLStatement = new SQLStatement();
			clearStmt.sqlConnection = conn;
			clearStmt.text = "DELETE FROM userPrefs";
			clearStmt.addEventListener(SQLEvent.RESULT, onClear);
			clearStmt.execute(); 
		
			
			
		}
		private function onClear(evt:SQLEvent):void{
			var insertStmt:SQLStatement = new SQLStatement(); 
			insertStmt.sqlConnection = conn; 
			// define the SQL text 
			var sql:String =  "INSERT INTO userPrefs (xmlString) VALUES ('"+ UserPrefsVO.toXMLString(AppModelLocator.getInstance().userPrefs)+"')"; 
			insertStmt.text = sql; 
			insertStmt.execute(); 
		
		}
		
		private function sqlOpenHandler(event:SQLEvent):void 
		{ 
		    trace("the database was created successfully"); 
		    var createStatement:SQLStatement = new SQLStatement();
		    createStatement.sqlConnection = conn;
		    var sql:String = "CREATE TABLE IF NOT EXISTS userPrefs (xmlString Text)"
		    createStatement.text = sql;
		    createStatement.addEventListener(SQLEvent.RESULT,onPrefsTableCreated);
		    createStatement.execute();
		} 
		
		private function onPrefsTableCreated(evt:SQLEvent):void{
			trace("table userPrefs created...");
			var selectStatement:SQLStatement = new SQLStatement();
			selectStatement.sqlConnection = conn;
			selectStatement.text = "SELECT xmlString FROM userPrefs";
			selectStatement.addEventListener(SQLEvent.RESULT, onSelect);
			selectStatement.execute();
		}
		
		private function onSelect(evt:SQLEvent):void{
			var result:SQLResult = (evt.currentTarget as SQLStatement).getResult();
			if(result.data == null){
				model.userPrefs = new UserPrefsVO("",null);
			}else{
				
				var row:Object = result.data[0];
				var xmlStr:String = row.xmlString;
				model.userPrefs = UserPrefsVO.fromXML(new XML(row.xmlString));
			}
			//model.userPrefs.recentFiles.removeAll();
			BindingUtils.bindSetter(onLastDirChanged,AppModelLocator.getInstance().userPrefs, "lastDirectoryOpened",true);
		}
		
		private function onLastDirChanged(newFilePath:String):void{
			
			if(newFilePath.indexOf(".gae") != -1){
				var file:File = new File(newFilePath);
				var exists:Boolean = false;
				for each(var ref:FileRefVO in model.userPrefs.recentFiles){
					if(ref.fileName == file.name){
						exists = true;
						break;
					}
				}
				if(exists == false){
					var fr:FileRefVO = new FileRefVO(file.name,file.nativePath);
					model.userPrefs.recentFiles.addItemAt(fr,0);
					
				}
				while(model.userPrefs.recentFiles.length > 4){
					model.userPrefs.recentFiles.removeItemAt(model.userPrefs.recentFiles.length -1);
				}
				ApplicationMenuManager.getInstance().updateRecentsMenu(model.userPrefs.recentFiles);
			}
			savePrefs();
		}
		
		private function sqlErrorHandler(event:SQLErrorEvent):void 
		{ 
		    trace("Error message:", event.error.message); 
		    trace("Details:", event.error.details); 
		} 
		
		public static function getInstance():com.freckle.gaegenerator.helpers.UserPrefsManager {
			if ( manager == null )
				manager = new com.freckle.gaegenerator.helpers.UserPrefsManager();
			return manager;
		}
		
		
		 
	   	
		
		
    }
}
