package app;

import openfl.display.Sprite;
import feathers.controls.Label;
import app.eventView.CodeArea;
import app.eventView.SaveButton;
import app.eventView.CurrentComponent;
import app.eventView.CurrentView;

class EventView {
    var eventView:Sprite; 
    // Children
    public var codeArea:CodeArea;
    public var saveButton:SaveButton;
    public var currentComponent:CurrentComponent;
    public var currentView:CurrentView;

    public var width:Float;
    public var height:Float;

    public function new(core:Core){
        eventView = new Sprite();
        
        codeArea = new CodeArea(core);
        saveButton = new SaveButton(core);
        currentComponent = new CurrentComponent(core);
        currentView = new CurrentView(core);
        
        // Add child
        eventView.addChild(codeArea.getCodeArea());
        eventView.addChild(saveButton.getSaveButton());
        eventView.addChild(currentComponent.getCurrentComponent());
        eventView.addChild(currentView.getCurrentView());

        // Children
        refresh(core);
    }


    public function getEventView(){
        return eventView;
    }

    public function refresh(core:Core){
        // Children
        codeArea.refresh(core);
        saveButton.refresh(core);
        currentComponent.refresh(core);
        currentView.refresh(core);

        // Set Dimensions
        width = core.stage.stageWidth;
        height = 0.2*core.stage.stageHeight; 
        

        var x = 0; 
        var y = 0; 

        // Clear 
        eventView.graphics.clear();
        // Begin Fill
        eventView.graphics.beginFill(0x3E3E3E);


        // Draw Round Rect
        eventView.graphics.drawRoundRect(x,y,width,height,10,10);
        eventView.graphics.endFill();

        // Position
        eventView.y = 0.8 * core.stage.stageHeight;
    }
    
    
} 
