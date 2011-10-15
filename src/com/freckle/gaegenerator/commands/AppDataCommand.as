// ActionScript file
package com.freckle.gaegenerator.commands
{
	//Cairngorm imports
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.freckle.gaegenerator.events.AppDataEvent;
	import com.freckle.gaegenerator.helpers.FileIOManager;
	import com.freckle.gaegenerator.model.AppModelLocator;
	import com.freckle.gaegenerator.vo.SchemaPropTypeVO;
	import com.freckle.gaegenerator.vo.SchemaVO;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	

	
	/**
	 * Command used to load XML and write data to HD 
	 * @author BenBishop
	 * 
	 */	
	public class AppDataCommand implements ICommand, IResponder{
		//creating a local reference to the model
		private var model:AppModelLocator = AppModelLocator.getInstance();
		//generic httpservice object to get the xml
		private var service:HTTPService = new HTTPService();
		/**
		 * Method invoked to execute command 
		 * @param p_event The event broadcasted
		 * 
		 */		
		public function execute(p_event:CairngormEvent):void{
			//file reference used for save as and open commands
			var docsDir:File
			//if user hasn't opened anything befoe
			if(model.userPrefs == null || model.userPrefs.lastDirectoryOpened == ""){
				//using default documents directory
				docsDir = File.documentsDirectory;
			}else{
				//using the last directory opened
				docsDir = new File(model.userPrefs.lastDirectoryOpened);
			}
			switch(p_event.type){
				//create new schema
				case AppDataEvent.NEW_SCHEMA:
					//checking to see if there is unsaved data
					if(model.isUnsaved == false){
						createNewSchema();
					}else{
						Alert.show("There is unsaved data. Do you wish to still continue?", "Unsaved Work",Alert.YES|Alert.NO,null,onNewAlertClosed);
					}
					break;
				//this event is broadcasted anytime the schema changed.
				case AppDataEvent.SCHEMA_CHANGED:
					//since schema changed update saved status
					model.isUnsaved = true;
					break;
				//event that gets a manifest of all the GAE property types
				case AppDataEvent.GET_PROP_TYPES:
					//setting up the httpservice object
					service.resultFormat = "e4x";
					service.url = "assets/data/propTypes.xml";
					//setting result handler
					service.addEventListener(ResultEvent.RESULT, parsePropTypes);	
					service.send();	
					break;
				//event to save schema
				case AppDataEvent.SAVE_SCHEMA:
					//checking if the user has specified where to save the current schema
					if(model.schema.filePath == null){
						//invoking a save as..
						startSaveAs(docsDir);
					}else{
						//if specified, we create a file reference and write the contents to it
						var f:File = new File(AppModelLocator.getInstance().schema.filePath);
						saveData(f);
					}
					//updating save status
					model.isUnsaved = false;
					break;
				//open schema event
				case AppDataEvent.IMPORT_SCHEMA:
					//setting doc filter
					var docFilter:FileFilter = new FileFilter("Schema", "*.gae");
					//setting title of window
					docsDir.browseForOpen("Import Schema...", [docFilter]);
					//setting event listener for when the user selects a file
					docsDir.addEventListener(Event.SELECT, fileSelected);
					break;
				//save as event
				case AppDataEvent.SAVE_SCHEMA_AS:
					startSaveAs(docsDir);
					break;
				//close event
				case AppDataEvent.CLOSE_SCHEMA:
					//checking if we need to confirm with user;
					if(model.isUnsaved == false){
						//clearing props
						clearSchema();
					}else{
						//confirming
						Alert.show("There is unsaved data. Do you wish to still continue?", "Unsaved Work",Alert.YES|Alert.NO,null,onCloseAlertClosed);
					}
					break;
				
			}
		}
		/**
		 * Method used to create a save ass window 
		 * @param docsDir
		 * 
		 */		
		private function startSaveAs(docsDir:File):void{
			docsDir.browseForSave("Save As");
			docsDir.addEventListener(Event.SELECT, onSaveAsDone);
		}
		/**
		 * Method for when the user confirms that they want to continue with a close regardless of unsaved data 
		 * @param evt
		 * 
		 */		
		private function onCloseAlertClosed(evt:CloseEvent):void{
			switch(evt.detail){
				case Alert.YES:
					clearSchema();
					break;
			}
		}
		/**
		 * Method used to clear out the schema in the model and some other props 
		 * 
		 */		
		private function clearSchema():void{
			model.schema = null;
			model.schemaXML = null;
			model.isUnsaved = false;
			model.isFileLoaded = false;
		}
		/**
		 * Method that creates new schema 
		 * 
		 */		
		private function createNewSchema():void{
			//setting schema vo
			model.schema = new SchemaVO();
			//setting saved and load status
			model.isUnsaved = true;
			model.isFileLoaded = true;
		}
		/**
		 * If user wants to continue with a new schema 
		 * @param evt
		 * 
		 */		
		private function onNewAlertClosed(evt:CloseEvent):void{
			switch(evt.detail){
				case Alert.YES:
					createNewSchema();
					break;
			}
		}
		/**
		 * Method used to parse and sort all of the GAE prop types found in the xml manifest 
		 * @param evt
		 * 
		 */		
		private function parsePropTypes(evt:ResultEvent):void{
			var x:XML = evt.result as XML;
			var ac:ArrayCollection = new ArrayCollection();
			for each(var px:XML in x.propType){
				ac.addItem(SchemaPropTypeVO.fromXML(px));
			}
			var sort:Sort = new Sort();
			sort.fields = [new SortField("name")]
			ac.sort = sort;
			ac.refresh();
			model.propTypes = ac;
		}
		/**
		 * Method invoked when a user selects a file to open 
		 * @param event
		 * 
		 */		
		private function fileSelected(event:Event):void 
		{
			var file:File = event.target as File
			//updating the last file opened prop for prefs
			model.userPrefs.lastDirectoryOpened = file.nativePath;
			//reading contents of file
			FileIOManager.getInstance().readSchemaFile(file);
		   
		}
		/**
		 * Method invoked when user has selected a location to save 
		 * @param event
		 * 
		 */		
		private function onSaveAsDone(event:Event):void{
			var newFile:File = event.target as File;
			if(newFile.nativePath.indexOf(".gae") == -1){
				newFile = new File(newFile.nativePath + ".gae");
			}
			saveData(newFile);
		}
		
		/**
		 * Method that writes the schema to a file 
		 * @param f File to write to
		 * 
		 */		
		private function saveData(f:File):void 
		{
		    
			AppModelLocator.getInstance().schema.filePath = f.nativePath;
		    var str:String = SchemaVO.toXMLString(AppModelLocator.getInstance().schema );
	        FileIOManager.getInstance().writeSchemaFile(f,str);
		    Alert.show("Schema Saved.");
		}

		
		public function result(data:Object):void
		{
			
		}
		
		public function fault(data:Object):void
		{
			
		}
	}
	
}