// ActionScript file
package com.freckle.gaegenerator.commands
{
	//Cairngorm imports
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.freckle.gaegenerator.events.AppDataEvent;
	import com.freckle.gaegenerator.events.AppEvent;
	import com.freckle.gaegenerator.helpers.UpdateManager;
	import com.freckle.gaegenerator.helpers.UserPrefsManager;
	import com.freckle.gaegenerator.model.AppModelLocator;
	
	import flash.desktop.NativeApplication;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.rpc.IResponder;
	
	/**
	 * Command used for when the app first opens and closes 
	 * @author BenBishop
	 * 
	 */	
	public class AppCommand implements ICommand, IResponder{
		public function execute(p_event:CairngormEvent):void{
			switch(p_event.type){
				
				case AppEvent.APP_LOAD:
					appInit();
					break;
				case AppEvent.APP_EXIT:
					//checking to see if there is any unsaved data
					if(AppModelLocator.getInstance().isUnsaved == false){
						//if not go ahead and close
						appClose();
					}else{
						//if there is, confirm with user
						Alert.show("There is unsaved data. Do you wish to still exit?", "Unsaved Work",Alert.YES|Alert.NO,null,onAlertClosed);
					}
					break;
			}
		}
		/**
		 * Event listener for the confirmation prompt 
		 * @param evt
		 * 
		 */		
		private function onAlertClosed(evt:CloseEvent):void{
			switch(evt.detail){
				//if user clicked yes to continue close
				case Alert.YES:
					appClose();
					break;
			}
		}



		/**
		 * Method to initialize the app 
		 * 
		 */		
		protected function appInit():void{
			//initializing model
			AppModelLocator.getInstance().init();
			//firing off data event to get all of the property types via xml	
			CairngormEventDispatcher.getInstance().dispatchEvent(new AppDataEvent(AppDataEvent.GET_PROP_TYPES));
			//initializing the user prefs manager
			UserPrefsManager.getInstance().init();
			//initializing the update manager and checking for updates
			UpdateManager.getInstance().checkForUpdate();
			
		}
		
		
		/**
		 * Method to close the app 
		 * 
		 */		
		protected function appClose():void{
			NativeApplication.nativeApplication.exit();

		}
		
		public function result(data:Object):void
		{
			
		}
		
		public function fault(data:Object):void
		{
			
		}
	}
	
}