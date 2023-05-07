package app.editorView.header;

import feathers.controls.Label;
import feathers.events.TriggerEvent;
import app.editorView.appView.appButton.Code;
import feathers.text.TextFormat;
import openfl.events.MouseEvent;

class NewButton{
    var newButton:Label;


    public function new(core:Core){
        newButton = new Label("New");

        refresh(core);
        events(core);
    }

    public function getNewButton(){
        return newButton;
    }

    public function refresh(core:Core){

            // Size
            newButton.width = 0.3 * core.stage.stageWidth;
            newButton.height = 0.05* core.stage.stageHeight; 
            trace("appButton.width: "+newButton.width);

            // Position
            newButton.x = 0.2 * core.stage.stageWidth;
            newButton.y = 0.05 * core.stage.stageHeight;



        // Set Button textFormat
        if(core.stage.stageWidth < core.stage.stageHeight){
		    newButton.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth),0xffffff);
        } else {
		    newButton.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight),0xffffff);
        }
    }

    public function events(core:Core){
       newButton.addEventListener(MouseEvent.CLICK,(e)->{
        
            core.getCore().addChild(core.addProject.getAddProject());
            core.getCore().removeChild(core.editorView.getEditorView());

            // reset AppView
            core.editorView.appView.getAppView().removeChildren();
            // reset Screens
            var screens = core.editorView.panel.screens;
            for(i in 1...screens.length){
                core.editorView.panel.getPanel().removeChild(screens[i].getScreen());
                screens[i].radioButton.toggleGroup = null;
            }
            // reset Y of Screens
            core.editorView.panel.y = 0.12 * core.stage.stageHeight;
            // reset the index
            core.editorView.panel.addScreenButton.i = 2; 
            // resetam Elementele
            var screens = core.editorView.panel.screens;
            for(i in 0...screens.length){
                screens[i].elements.removeChildren();
            }
            screens = []; 

       });
    }
}