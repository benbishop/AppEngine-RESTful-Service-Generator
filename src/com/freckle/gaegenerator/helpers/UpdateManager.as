package com.freckle.gaegenerator.helpers {
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	import mx.controls.Alert;
	
	
    public class UpdateManager{
		protected static var manager:com.freckle.gaegenerator.helpers.UpdateManager; 
		
		
		// Instantiate the updater
		private var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
		
		public function UpdateManager(){	
		
		}
		public function init():void{
			
			
		}
		
		
		public function checkForUpdate():void {
			// The code below is a hack to work around a bug in the framework so that CMD-Q still works on MacOS
			// This is a temporary fix until the framework is updated
			// See http://www.adobe.com/cfusion/webforums/forum/messageview.cfm?forumid=72&catid=670&threadid=1373568
			
			NativeApplication.nativeApplication.addEventListener( Event.EXITING, 
				function(e:Event):void {
					var opened:Array = NativeApplication.nativeApplication.openedWindows;
					for (var i:int = 0; i < opened.length; i ++) {
						opened[i].close();
					}
			});	
	
			
			
			// Configuration stuff - see update framework docs for more details
			appUpdater.updateURL = "http://freckleinteractive.com/gaebuilder/updaterManifest.xml"; // Server-side XML file describing update
			appUpdater.isCheckForUpdateVisible = false; // We won't ask permission to check for an update
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate); // Once initialized, run onUpdate
			appUpdater.addEventListener(ErrorEvent.ERROR, onError); // If something goes wrong, run onError
			appUpdater.initialize(); // Initialize the update framework
		}
	
		private function onError(event:ErrorEvent):void {
			Alert.show(event.toString());
		}
		
		private function onUpdate(event:UpdateEvent):void {
			appUpdater.checkNow(); // Go check for an update now
		}
	
		public static function getInstance():com.freckle.gaegenerator.helpers.UpdateManager {
			if ( manager == null )
				manager = new com.freckle.gaegenerator.helpers.UpdateManager();
			return manager;
		}
		
		
		 
	   	
		
		
    }
}

