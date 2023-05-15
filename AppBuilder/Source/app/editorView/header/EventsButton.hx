package app.editorView.header;

import feathers.controls.Label;
import feathers.events.TriggerEvent;
import app.editorView.appView.appButton.Code;
import feathers.text.TextFormat;
import openfl.events.MouseEvent;

class EventsButton{
    var eventsButton:Label;


    public function new(core:Core){
        eventsButton = new Label("Events");

        refresh(core);
        events(core);
    }

    public function getEventsButton(){
        return eventsButton;
    }

    public function refresh(core:Core){

            // Size
            eventsButton.width = 0.3 * core.stage.stageWidth;
            eventsButton.height = 0.05* core.stage.stageHeight; 
            trace("appButton.width: "+eventsButton.width);

            // Position
            eventsButton.x = 0.5 * core.stage.stageWidth;
            eventsButton.y = 0.05 * core.stage.stageHeight;



        // Set Button textFormat
        if(core.stage.stageWidth < core.stage.stageHeight){
		    eventsButton.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth),0xffffff);
        } else {
		    eventsButton.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight),0xffffff);
        }
    }

    public function events(core:Core){
        eventsButton.addEventListener(MouseEvent.CLICK,(e)->{
			if(core.getCore().contains(core.eventView.getEventView())){
				core.getCore().removeChildren();
				core.getCore().removeChild(core.eventView.getEventView());
				core.getCore().addChild(core.editorView.getEditorView());

			} else {
				core.getCore().removeChildren();
				core.getCore().addChild(core.editorView.getEditorView());
				core.getCore().addChild(core.eventView.getEventView());
			}
       });
    }
}