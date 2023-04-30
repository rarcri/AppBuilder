package app.editorView.header;

import openfl.events.MouseEvent;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import feathers.events.TriggerEvent;
import haxe.io.Path;

#if sys
import sys.io.File;
#end

class RunButton {
	var runButton:Sprite;
	//Children
	var bitmap:Bitmap;

	public function new(core:Core){
		runButton = new Sprite();
		runButton.buttonMode = true;

		// bitmap
		bitmap = new Bitmap(Assets.getBitmapData("assets/play.png"));
		bitmap.smoothing = true;

		runButton.addChild(bitmap);

		refresh(core);
		events(core);
	}

	public function getRunButton(){
		return runButton;
	}

	public function refresh(core:Core){
		bitmap.width = 0.05 * core.stage.stageHeight; 
		bitmap.height = 0.05 * core.stage.stageHeight;

		bitmap.x = 0.4 * core.stage.stageWidth;
		bitmap.y = 0.025 * core.stage.stageHeight;

	}

	public function events(core:Core){
		runButton.addEventListener(MouseEvent.CLICK, (e)->{

			
            // xml file 
            var xml= Path.join([core.addProject.okButton.path, "project.xml"]).toString();
                trace(xml);

                // Adaugam feathersui in project.xml

                var projectXml = File.getContent(xml);

                var projectXmlRegex = ~/.window width.*$/gm;

                projectXml = projectXmlRegex.replace(projectXml,
					'<window width="'+core.editorView.appView.width+'" height="'+core.editorView.appView.height+'"/>');
                File.saveContent(xml, projectXml);

			var beta=true;
			// Get the platform
			var platform = Sys.systemName();
			if(beta==true){
				platform = "hl";
			}
			else 
			if(platform == "Mac"){
				platform = Sys.systemName() + "os";
			} else {
				platform = Sys.systemName();
			}

			trace("cd " + core.addProject.okButton.path + " && openfl test " + platform);

			Sys.command("cd " + core.addProject.okButton.path + " && openfl test " + platform);
		});
	}
}
