package app.initialScreen;

import lime.ui.FileDialog;
import openfl.net.FileReference;
import feathers.events.TriggerEvent;
import feathers.controls.Button;
import haxe.io.Path;

class OpenFolderButton {
	// Folderul unde avem proiectele
	public var path:String;
	public var homeDrive:String;

	var openFolderButton:Button;

	public function new(core:Core) {
	  // Aflam locatia programului
	  // var home = Sys.programPath();

	  var home = '';

	  // Windows 
	  if(Sys.systemName()=="Windows"){
	  	homeDrive = Sys.environment()["HOMEDRIVE"];
		home = Sys.environment()["HOMEPATH"];
		
		// UNix
	  } else {
	  	home = Sys.environment()["HOME"];
	  }

	  trace(home);
	
        path = Path.join([home,"AppBuilder"]).toString();
		trace(path);


		openFolderButton = new Button("Deschide folderul");
		refresh(core);
		events(core);
	}

	public function getOpenFolderButton() {
		return openFolderButton;
	}

	public function refresh(core:Core) {
		// Size
		openFolderButton.width = 0.2 * core.stage.stageWidth;
		openFolderButton.height = 0.1 * core.stage.stageHeight;

		// Position
		openFolderButton.x = core.stage.stageWidth / 2 - openFolderButton.width / 2;
		openFolderButton.y = core.stage.stageHeight / 2 - openFolderButton.height / 2;
	}

	public function events(core:Core) {
		// Click
		openFolderButton.addEventListener(TriggerEvent.TRIGGER, (event) -> {

			#if sys
			// Dacă folderul cu proiecte nu există îl creem
			if (!sys.FileSystem.exists(path)) {

				sys.FileSystem.createDirectory(path);
				//sys.FileSystem.readDirectory(path);
			} 
			#end

			core.getCore().removeChild(core.initialScreen.getInitialScreen());
			core.getCore().addChild(core.addProject.getAddProject());
		});
	}
}
