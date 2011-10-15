// ActionScript file
package com.freckle.gaegenerator.commands
{
	//Cairngorm imports
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.freckle.gaegenerator.events.FileGeneratorEvent;
	import com.freckle.gaegenerator.helpers.FileGenerationCoordinator;
	import com.freckle.gaegenerator.helpers.generators.AppControllerGenerator;
	import com.freckle.gaegenerator.helpers.generators.AppYamlGenerator;
	import com.freckle.gaegenerator.helpers.generators.FileHandlerScriptGenerator;
	import com.freckle.gaegenerator.helpers.generators.HandlerScriptGenerator;
	import com.freckle.gaegenerator.helpers.generators.ModelScriptGenerator;
	import com.freckle.gaegenerator.helpers.generators.XMLTemplateGenerator;
	import com.freckle.gaegenerator.helpers.generators.XSLTemplateGenerator;
	import com.freckle.gaegenerator.model.AppModelLocator;
	import com.freckle.gaegenerator.vo.SchemaObjectVO;
	import com.freckle.gaegenerator.vo.SchemaVO;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	

	public class FileGeneratorCommand implements ICommand, IResponder{
		
		public function execute(p_event:CairngormEvent):void{
			var s:String = "";
			var schema:SchemaVO = AppModelLocator.getInstance().schema;
			switch(p_event.type){
				case FileGeneratorEvent.START_GENERATION:
					startGenerating();
					break;
				case FileGeneratorEvent.GENERATE_APP_YAML:
					s = AppYamlGenerator.getInstance().generateAppYaml();
					writeFile(AppModelLocator.getInstance().schema.gaeAppDir + "//" +"app.yaml", s);
					CairngormEventDispatcher.getInstance().dispatchEvent(new FileGeneratorEvent(FileGeneratorEvent.GENERATION_DONE));
					break;
				case FileGeneratorEvent.GENERATE_MODEL:
					s = createPythongHeader(AppModelLocator.getInstance().schema);
					s += "#!/usr/bin/env python\r" + ModelScriptGenerator.getInstance().generateModelString((p_event as FileGeneratorEvent).object);
					writeFile(AppModelLocator.getInstance().schema.gaeAppDir + "//" + (p_event as FileGeneratorEvent).object.name.toLowerCase() +"data.py", s);
					trace("GENERATE_MODEL done");
					CairngormEventDispatcher.getInstance().dispatchEvent(new FileGeneratorEvent(FileGeneratorEvent.GENERATION_DONE));
					break;
				case FileGeneratorEvent.GENERATE_REST_HANDLER:
					s = createPythongHeader(AppModelLocator.getInstance().schema);
					s += "#!/usr/bin/env python\r" + HandlerScriptGenerator.getInstance().generateHandlerString((p_event as FileGeneratorEvent).object);
					writeFile(AppModelLocator.getInstance().schema.gaeAppDir + "//" + (p_event as FileGeneratorEvent).object.name.toLowerCase() +"controls.py", s);
					trace("GENERATE_REST_HANDLER done");
					CairngormEventDispatcher.getInstance().dispatchEvent(new FileGeneratorEvent(FileGeneratorEvent.GENERATION_DONE));
					break;
				case FileGeneratorEvent.GENERATE_XML_RESPONSE:
					s = XMLTemplateGenerator.getInstance().generateGetXMLTemplate((p_event as FileGeneratorEvent).object);
					writeFile(schema.templatesDir+"//" + (p_event as FileGeneratorEvent).object.name.toLowerCase() +".html", s);
					
					s = XMLTemplateGenerator.getInstance().generatePluralGetXMLTemplate((p_event as FileGeneratorEvent).object);
					writeFile(schema.templatesDir+"//" + (p_event as FileGeneratorEvent).object.pluralName.toLowerCase() +".html", s);
					CairngormEventDispatcher.getInstance().dispatchEvent(new FileGeneratorEvent(FileGeneratorEvent.GENERATION_DONE));
					trace("GENERATE_XML_RESPONSE done");
					break;
				case FileGeneratorEvent.GENERATE_XSL:
					s = XSLTemplateGenerator.getInstance().generateGetXSLTemplate((p_event as FileGeneratorEvent).object);
					writeFile(schema.xslDir + "//" + (p_event as FileGeneratorEvent).object.name.toLowerCase() +".xsl", s);
					CairngormEventDispatcher.getInstance().dispatchEvent(new FileGeneratorEvent(FileGeneratorEvent.GENERATION_DONE));
					trace("GENERATE_HTML_SCAFFOLD done");
					break;
				case FileGeneratorEvent.GENERATE_APP_CONTROLLER:
					s = createPythongHeader(AppModelLocator.getInstance().schema);
					s += "#!/usr/bin/env python\r" + AppControllerGenerator.getInstance().generateAppController(AppModelLocator.getInstance().schema);
					writeFile(AppModelLocator.getInstance().schema.gaeAppDir + "//main.py", s);
					CairngormEventDispatcher.getInstance().dispatchEvent(new FileGeneratorEvent(FileGeneratorEvent.GENERATION_DONE));
					trace("GENERATE_APP_CONTROLLER done");
					break;
				case FileGeneratorEvent.GENERATE_DELETE_HANDLER:
					s = createPythongHeader(AppModelLocator.getInstance().schema);
					s += "#!/usr/bin/env python\r" + AppControllerGenerator.getInstance().generateDeleteHanlder();
					writeFile(AppModelLocator.getInstance().schema.gaeAppDir + "//deletehandler.py", s);
					CairngormEventDispatcher.getInstance().dispatchEvent(new FileGeneratorEvent(FileGeneratorEvent.GENERATION_DONE));
					break;
				case FileGeneratorEvent.GENERATE_FILE_HANDLER:
					s = createPythongHeader(AppModelLocator.getInstance().schema);
					s += "#!/usr/bin/env python\r" + FileHandlerScriptGenerator.getInstance().generateFileHandlerScript();
					writeFile(AppModelLocator.getInstance().schema.gaeAppDir + "//GAEFile.py", s);
					CairngormEventDispatcher.getInstance().dispatchEvent(new FileGeneratorEvent(FileGeneratorEvent.GENERATION_DONE));
					break;
				
				
			}
		}
		
		private function createPythongHeader(s:SchemaVO):String{
			var d:Date = new Date();
			var str:String = "\"\"\"\n";
			str += "Created by " + s.createdBy + " on "+ d.fullYear+"-"+(d.month + 1)+"-"+ d.date+".\n"
			str += "" + s.copyrightText + "\n"; 
			str += "\"\"\"\n\n";
			return str;
		}
		
		private function writeFile(filePath:String, contents:String):void{
			var f:File = new File(filePath);
			
			var str:String = contents;
	        var stream:FileStream = new FileStream();
	        stream.open(f, FileMode.WRITE);
	        stream.writeUTFBytes(str);
	        stream.close();
		}
		private function startGenerating():void{
			var schema:SchemaVO = AppModelLocator.getInstance().schema;
				if(schema.gaeAppDir != "" && schema.templatesDir != ""  && schema.xslDir != "" && schema.appName != ""){
				
					var objects:ArrayCollection = schema.getAllObjects();
					FileGenerationCoordinator.getInstance().clearCue();
					for each(var o:SchemaObjectVO in objects){
						if(o.properties.length != 0){
							if(o.generateModel){
								var evt:FileGeneratorEvent = new FileGeneratorEvent(FileGeneratorEvent.GENERATE_MODEL);
								evt.object = o;
								FileGenerationCoordinator.getInstance().cueEvent(evt);
							}
							if(o.generateHandler){
								var hevt:FileGeneratorEvent = new FileGeneratorEvent(FileGeneratorEvent.GENERATE_REST_HANDLER);
								hevt.object = o;
								FileGenerationCoordinator.getInstance().cueEvent(hevt);
							}
							if(o.generateXMLResponse){
								if(schema.templatesDir != null && schema.templatesDir != ""){
									var xevt:FileGeneratorEvent = new FileGeneratorEvent(FileGeneratorEvent.GENERATE_XML_RESPONSE);
									xevt.object = o;
									FileGenerationCoordinator.getInstance().cueEvent(xevt);
								}else{
									FileGenerationCoordinator.getInstance().generationLog += "ERROR: Templates directory has not been specified. XML and HTML files will not be generated.";
								}
							}
							if(o.generateXSL){
								if(schema.templatesDir != null && schema.templatesDir != ""){
									var htmlevt:FileGeneratorEvent = new FileGeneratorEvent(FileGeneratorEvent.GENERATE_XSL);
									htmlevt.object = o;
									FileGenerationCoordinator.getInstance().cueEvent(htmlevt);
								}else{
									FileGenerationCoordinator.getInstance().generationLog += "ERROR: Templates directory has not been specified. XML and XSL files will not be generated.";
								}
							}
						}else{
							FileGenerationCoordinator.getInstance().generationLog += "ERROR: " + o.name + " does not have properties and was not generated...";
						}
					}
					var devt:FileGeneratorEvent = new FileGeneratorEvent(FileGeneratorEvent.GENERATE_DELETE_HANDLER);
					FileGenerationCoordinator.getInstance().cueEvent(devt);
					
					var fevt:FileGeneratorEvent = new FileGeneratorEvent(FileGeneratorEvent.GENERATE_FILE_HANDLER);
					FileGenerationCoordinator.getInstance().cueEvent(fevt);
					
					var cevt:FileGeneratorEvent = new FileGeneratorEvent(FileGeneratorEvent.GENERATE_APP_CONTROLLER);
					FileGenerationCoordinator.getInstance().cueEvent(cevt);
					
					var aevt:FileGeneratorEvent = new FileGeneratorEvent(FileGeneratorEvent.GENERATE_APP_YAML);
					FileGenerationCoordinator.getInstance().cueEvent(aevt);
					
					FileGenerationCoordinator.getInstance().launchEvents();
				}else{
					Alert.show("Sorry, you must specify an application, xsl, and a templates directory before generating files.");
				}
		}
		
		public function result(data:Object):void
		{
			
		}
		
		public function fault(data:Object):void
		{
			
		}
	}
	
}