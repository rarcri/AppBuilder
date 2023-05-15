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

class SettingsButton {
	var settingsButton:Sprite;
	//Children
	var bitmap:Bitmap;

	public function new(core:Core){
		settingsButton = new Sprite();
		settingsButton.buttonMode = true;

		// bitmap
		bitmap = new Bitmap(Assets.getBitmapData("assets/gear-fill.png"));
		bitmap.smoothing = true;

		settingsButton.addChild(bitmap);

		refresh(core);
		events(core);
	}

	public function getSettingsButton(){
		return settingsButton;
	}

	public function refresh(core:Core){
		bitmap.width = 0.05 * core.stage.stageHeight; 
		bitmap.height = 0.05 * core.stage.stageHeight;

		bitmap.x = 0.6 * core.stage.stageWidth;
		bitmap.y = 0.025 * core.stage.stageHeight;

	}

	public function events(core:Core){
		settingsButton.addEventListener(MouseEvent.CLICK, (e)->{
			if(core.getCore().contains(core.settingsView.getSettingsView())){
				core.getCore().removeChildren();
				core.getCore().removeChild(core.settingsView.getSettingsView());
				core.getCore().addChild(core.editorView.getEditorView());

			} else {
				core.getCore().removeChildren();
				core.getCore().addChild(core.editorView.getEditorView());
				core.getCore().addChild(core.settingsView.getSettingsView());
			}
		});
	}
}
