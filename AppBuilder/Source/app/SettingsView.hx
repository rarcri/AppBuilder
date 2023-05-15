package app;

import openfl.display.Sprite;
import feathers.controls.Label;
import app.settingsView.CodeArea;
import app.settingsView.SaveButton;
import app.settingsView.CurrentComponent;
import app.settingsView.CurrentView;

class SettingsView {
    var settingsView:Sprite; 
    // Children
    public var codeArea:CodeArea;
    public var saveButton:SaveButton;
    public var currentComponent:CurrentComponent;
    public var currentView:CurrentView;

    public var width:Float;
    public var height:Float;

    public function new(core:Core){
        settingsView = new Sprite();
        
        codeArea = new CodeArea(core);
        saveButton = new SaveButton(core);
        currentComponent = new CurrentComponent(core);
        currentView = new CurrentView(core);
        
        // Add child
        settingsView.addChild(codeArea.getCodeArea());
        settingsView.addChild(saveButton.getSaveButton());
        settingsView.addChild(currentComponent.getCurrentComponent());
        settingsView.addChild(currentView.getCurrentView());

        // Children
        refresh(core);
    }


    public function getSettingsView(){
        return settingsView;
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
        settingsView.graphics.clear();
        // Begin Fill
        settingsView.graphics.beginFill(0x3E3E3E);


        // Draw Round Rect
        settingsView.graphics.drawRoundRect(x,y,width,height,10,10);
        settingsView.graphics.endFill();

        // Position
        settingsView.y = 0.8 * core.stage.stageHeight;
    }
    
    
} 
