package com.freckle.gaegenerator.helpers {
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.freckle.gaegenerator.events.FileGeneratorEvent;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	
    public class FileGenerationCoordinator{
		protected static var coordinator:com.freckle.gaegenerator.helpers.FileGenerationCoordinator; 
	
		[Bindable]
		public var generationLog:String = "";
		private var cue:ArrayCollection = new ArrayCollection();
		private var cueIndex:int = 0;
		
		public function FileGenerationCoordinator(){	
			CairngormEventDispatcher.getInstance().addEventListener(FileGeneratorEvent.GENERATION_DONE, onGenerationDone);
		}
		
		public function onGenerationDone(evt:FileGeneratorEvent):void{
			if(cueIndex != cue.length -1){
				
				cueIndex++;
				updateStatusMessage(cue.getItemAt(cueIndex) as FileGeneratorEvent);
				CairngormEventDispatcher.getInstance().dispatchEvent(cue.getItemAt(cueIndex) as FileGeneratorEvent);
				
			}else{
				
				generationLog += "\rFILES GENERATED";
				Alert.show("Files generated.");
			}
		}
		
		private function updateStatusMessage(evt:FileGeneratorEvent):void{
			var s:String = "\rGenerating ";
			var o:SchemaObjectVO = evt.object;
			switch(evt.type){
				case FileGeneratorEvent.GENERATE_APP_CONTROLLER:
					s += "App Engine main.py";
					break;
				case FileGeneratorEvent.GENERATE_XSL:
					s += "XSL for " + o.name;
					break;
				case FileGeneratorEvent.GENERATE_MODEL:
					s += "Data Class for " + o.name;
					break;
				case FileGeneratorEvent.GENERATE_REST_HANDLER:
					s += "Method Handler for " + o.name;
					break;
				case FileGeneratorEvent.GENERATE_XML_RESPONSE:
					s += "XML Get Response for " + o.name;
					break;	
				case FileGeneratorEvent.GENERATE_FILE_HANDLER:
					s += "File Handler...";
					break;	
				case FileGeneratorEvent.GENERATE_DELETE_HANDLER:
					s += "Delete Handler...";
					break;	
			}
			generationLog += s +"...";
		}
		
		public function launchEvents():void{
			generationLog = "Starting File Generation...";
			
			cueIndex = 0;
			if(cue.length != 0){
				updateStatusMessage(cue.getItemAt(cueIndex) as FileGeneratorEvent);
				CairngormEventDispatcher.getInstance().dispatchEvent(cue.getItemAt(cueIndex) as FileGeneratorEvent);
			}
		}
		
		public function cueEvent(evt:FileGeneratorEvent):void{
			cue.addItem(evt);
		}
		
		public function clearCue():void{
			cue.removeAll();
		}
		
		public function init():void{
			trace("GenerationCoordinator init() called...");
		}
		
		public static function getInstance():com.freckle.gaegenerator.helpers.FileGenerationCoordinator {
			if ( coordinator == null )
				coordinator = new com.freckle.gaegenerator.helpers.FileGenerationCoordinator();
			return coordinator;
		}
		 
	   	
		
		
    }
}

