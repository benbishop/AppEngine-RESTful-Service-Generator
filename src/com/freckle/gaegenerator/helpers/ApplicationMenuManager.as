package com.freckle.gaegenerator.helpers {
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.freckle.gaegenerator.events.AppDataEvent;
	import com.freckle.gaegenerator.events.AppEvent;
	import com.freckle.gaegenerator.events.FileGeneratorEvent;
	import com.freckle.gaegenerator.model.AppModelLocator;
	import com.freckle.gaegenerator.vo.FileRefVO;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.ui.Keyboard;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	
	
	
	
    public class ApplicationMenuManager{
		protected static var manager:com.freckle.gaegenerator.helpers.ApplicationMenuManager; 
		
		private var root:NativeMenu;
		private var fileMenu:NativeMenu;
		
		public function ApplicationMenuManager(){	
		
		}
		public function init(target:NativeWindow):void{
			
			
			root = new NativeMenu();
			createFileMenu(root);
			createEditMenu(root);
			//if PC
			if(NativeWindow.supportsMenu){
				target.menu = root;
			}
			//if Mac
			if(NativeApplication.supportsMenu){
				NativeApplication.nativeApplication.menu = root;
			}
			
		}
		
		public function updateRecentsMenu(files:ArrayCollection):void{
			var recentsMenu:NativeMenuItem = fileMenu.getItemAt(2);
			recentsMenu.submenu = new NativeMenu();
			for each(var fr:FileRefVO in files){
				var mi:NativeMenuItem = new NativeMenuItem(fr.fileName);
				mi.addEventListener(Event.SELECT, onRecentSelected);
				recentsMenu.submenu.addItem(mi);
			}
			
		}
		
		private function onRecentSelected(evt:Event):void{
			var target:NativeMenuItem = evt.currentTarget as NativeMenuItem;
			for each(var ref:FileRefVO in AppModelLocator.getInstance().userPrefs.recentFiles){
				if(target.label == ref.fileName){
					FileIOManager.getInstance().readSchemaFile(new File(ref.filePath));
					break;
				}
			}
		}
		
		
		private function createEditMenu(menu:NativeMenu):void{
			var editMenu:NativeMenu = new NativeMenu();
			var generateMenu:NativeMenuItem = createMenuItem("Generate Files", [Keyboard.COMMAND],"g",onGenerateFilesSelected);
			BindingUtils.bindProperty(generateMenu, "enabled", AppModelLocator.getInstance(),"isFileLoaded");
			editMenu.addItem(generateMenu);
			menu.addSubmenu(editMenu, "Edit");
		}
		private function onGenerateFilesSelected(evt:Event):void{
			CairngormEventDispatcher.getInstance().dispatchEvent(new FileGeneratorEvent(FileGeneratorEvent.START_GENERATION));
		}
		
		private function createFileMenu(menu:NativeMenu):void{
			fileMenu = new NativeMenu();
			//creating new schema item
			fileMenu.addItem(createMenuItem("New Schema", [Keyboard.COMMAND],"n",onNewSelected));
			//creating open schema item
			fileMenu.addItem(createMenuItem("Open Schema", [Keyboard.COMMAND],"o",onOpenSelected));
			var recentsMenu:NativeMenuItem = new NativeMenuItem("Open Recent...");
			//recentsMenu.name = "recentsMenu": 
			fileMenu.addItem(recentsMenu);
			//seperator
			fileMenu.addItem(createMenuSeperator());
			//creating close menu item and binding it's enabled
			fileMenu.addItem(createMenuItem("Close Schema", [Keyboard.COMMAND],"w",onCloseSelected));
			//seperator
			fileMenu.addItem(createMenuSeperator());
			//creating save menu item and binding it's enabled
			var saveMenu:NativeMenuItem = createMenuItem("Save Schema", [Keyboard.COMMAND],"s",onSaveSelected);
			BindingUtils.bindProperty(saveMenu, "enabled", AppModelLocator.getInstance(),"isUnsaved");
			fileMenu.addItem(saveMenu);
			//creating save as menu item and binding it's enabled
			var saveAsMenu:NativeMenuItem = createMenuItem("Save Schema as...", [],"",onSaveAsSelected);
			BindingUtils.bindProperty(saveAsMenu, "enabled", AppModelLocator.getInstance(),"isUnsaved"); 
			fileMenu.addItem(saveAsMenu);
			
			//creating seperator
			fileMenu.addItem(createMenuSeperator());
			//creating quit item
			fileMenu.addItem(createMenuItem("Quit", [Keyboard.COMMAND],"q",onQuitSelected));
			menu.addSubmenu(fileMenu, "File");
				
				
		}
		private function onCloseSelected(evt:Event):void{
			CairngormEventDispatcher.getInstance().dispatchEvent(new AppDataEvent(AppDataEvent.CLOSE_SCHEMA));
		}
		private function onSaveAsSelected(evt:Event):void{
			CairngormEventDispatcher.getInstance().dispatchEvent(new AppDataEvent(AppDataEvent.SAVE_SCHEMA_AS));
		}
		private function onSaveSelected(evt:Event):void{
			CairngormEventDispatcher.getInstance().dispatchEvent(new AppDataEvent(AppDataEvent.SAVE_SCHEMA));
		}
		private function onOpenSelected(evt:Event):void{
			CairngormEventDispatcher.getInstance().dispatchEvent(new AppDataEvent(AppDataEvent.IMPORT_SCHEMA));
		}
		private function onNewSelected(evt:Event):void{
			
			CairngormEventDispatcher.getInstance().dispatchEvent(new AppDataEvent(AppDataEvent.NEW_SCHEMA));
		}
		private function onQuitSelected(evt:Event):void{
			CairngormEventDispatcher.getInstance().dispatchEvent(new AppEvent(AppEvent.APP_EXIT));
		}
		private function createMenuSeperator():NativeMenuItem{
			var nm:NativeMenuItem = new NativeMenuItem("", true);
			
			return nm;
		}
		
		private function createMenuItem(label:String, keyModifiers:Array, keyEquivalent:String, eventListener:Function):NativeMenuItem{
			var newItem:NativeMenuItem = new NativeMenuItem(label);
			//newItem.keyEquivalentModifiers = keyModifiers;
			newItem.keyEquivalent = keyEquivalent;
			newItem.addEventListener(Event.SELECT, eventListener);
			return newItem;
		}
		
		
		
		public static function getInstance():com.freckle.gaegenerator.helpers.ApplicationMenuManager {
			if ( manager == null )
				manager = new com.freckle.gaegenerator.helpers.ApplicationMenuManager();
			return manager;
		}
		
		
		 
	   	
		
		
    }
}

