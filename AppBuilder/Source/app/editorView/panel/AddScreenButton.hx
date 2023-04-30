package app.editorView.panel;

import openfl.events.MouseEvent;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import feathers.controls.Button;
import feathers.events.TriggerEvent;
import haxe.io.Path;

#if sys
import sys.io.File;
#end

class AddScreenButton {
	var addScreenButton:Button;

	public function new(core:Core){
		addScreenButton = new Button("+ Adauga");

		refresh(core);
		events(core);
	}

	public function getAddScreenButton(){
		return addScreenButton;
	}

	public function refresh(core:Core){
	    addScreenButton.width = 0.15 * core.stage.stageHeight; 
		addScreenButton.height = 0.05 * core.stage.stageHeight;

		addScreenButton.x = 0.1 * core.stage.stageWidth - addScreenButton.width/2;
		addScreenButton.y = 0.02 * core.stage.stageHeight;

	}

	public function events(core:Core){
		var i=2;
		addScreenButton.addEventListener(TriggerEvent.TRIGGER, (e)->{
			core.editorView.panel.addScreen("Screen"+i,core);
			i++;
        });

	}
}
