package com.freckle.gaegenerator.controller
{
	import com.adobe.cairngorm.control.FrontController;
	import com.freckle.gaegenerator.commands.*;
	import com.freckle.gaegenerator.events.*;
	

	
	public class AppController extends FrontController{
		public function AppController(){
			trace("Controller constructor called.");
			addCommands();
		}
		
		protected function addCommands():void{
			//application events
			addCommand(AppEvent.APP_LOAD, AppCommand);
			addCommand(AppEvent.APP_EXIT, AppCommand);
			//data events
			addCommand(AppDataEvent.GET_PROP_TYPES, AppDataCommand);
			addCommand(AppDataEvent.NEW_SCHEMA, AppDataCommand);
			addCommand(AppDataEvent.IMPORT_SCHEMA, AppDataCommand);
			addCommand(AppDataEvent.SAVE_SCHEMA, AppDataCommand);
			addCommand(AppDataEvent.SAVE_SCHEMA_AS, AppDataCommand);
			addCommand(AppDataEvent.SCHEMA_CHANGED, AppDataCommand);
			addCommand(AppDataEvent.CLOSE_SCHEMA, AppDataCommand);
			//generator events
			addCommand(FileGeneratorEvent.START_GENERATION, FileGeneratorCommand);
			addCommand(FileGeneratorEvent.GENERATE_APP_YAML, FileGeneratorCommand);
			addCommand(FileGeneratorEvent.GENERATION_DONE, FileGeneratorCommand);
			addCommand(FileGeneratorEvent.GENERATE_MODEL, FileGeneratorCommand);
			addCommand(FileGeneratorEvent.GENERATE_REST_HANDLER, FileGeneratorCommand);
			addCommand(FileGeneratorEvent.GENERATE_XML_RESPONSE, FileGeneratorCommand);
			addCommand(FileGeneratorEvent.GENERATE_XSL,FileGeneratorCommand);
			addCommand(FileGeneratorEvent.GENERATE_APP_CONTROLLER,FileGeneratorCommand);
			addCommand(FileGeneratorEvent.GENERATE_DELETE_HANDLER, FileGeneratorCommand);
			addCommand(FileGeneratorEvent.GENERATE_FILE_HANDLER, FileGeneratorCommand);
			
		}
	}
}
