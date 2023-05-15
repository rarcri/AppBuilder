package app.editorView.header;

import feathers.controls.Label;
import feathers.events.TriggerEvent;
import app.editorView.appView.appButton.Code;
import feathers.text.TextFormat;
import openfl.events.MouseEvent;

class TitleButton{
    var titleButton:Label;


    public function new(core:Core){
        titleButton = new Label("Title");

        refresh(core);
        events(core);
    }

    public function getTitleButton(){
        return titleButton;
    }

    public function refresh(core:Core){

            // Size
            titleButton.width = 0.3 * core.stage.stageWidth;
            titleButton.height = 0.05* core.stage.stageHeight; 
            trace("appButton.width: "+titleButton.width);

            // Position
            titleButton.x = 0.7 * core.stage.stageWidth;
            titleButton.y = 0.05 * core.stage.stageHeight;



        // Set Button textFormat
        if(core.stage.stageWidth < core.stage.stageHeight){
		    titleButton.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth),0xffffff);
        } else {
		    titleButton.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight),0xffffff);
        }
    }

    public function events(core:Core){
        titleButton.addEventListener(MouseEvent.CLICK,(e)->{
			if(core.getCore().contains(core.titleView.getTitleView())){
				core.getCore().removeChildren();
				core.getCore().removeChild(core.titleView.getTitleView());
				core.getCore().addChild(core.editorView.getEditorView());

			} else {
				core.getCore().removeChildren();
				core.getCore().addChild(core.editorView.getEditorView());
				core.getCore().addChild(core.titleView.getTitleView());
			}
       });
    }
}