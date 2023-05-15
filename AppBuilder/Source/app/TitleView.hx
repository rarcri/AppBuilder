package app;

import openfl.display.Sprite;
import feathers.controls.Label;
import app.titleView.CodeArea;
import app.titleView.SaveButton;
import app.titleView.CurrentComponent;
import app.titleView.CurrentView;

class TitleView {
    var titleView:Sprite; 
    // Children
    public var codeArea:CodeArea;
    public var saveButton:SaveButton;
    public var currentComponent:CurrentComponent;
    public var currentView:CurrentView;

    public var width:Float;
    public var height:Float;

    public function new(core:Core){
        titleView = new Sprite();
        
        codeArea = new CodeArea(core);
        saveButton = new SaveButton(core);
        currentComponent = new CurrentComponent(core);
        currentView = new CurrentView(core);
        
        // Add child
        titleView.addChild(codeArea.getCodeArea());
        titleView.addChild(saveButton.getSaveButton());
        titleView.addChild(currentComponent.getCurrentComponent());
        titleView.addChild(currentView.getCurrentView());

        // Children
        refresh(core);
    }


    public function getTitleView(){
        return titleView;
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
        titleView.graphics.clear();
        // Begin Fill
        titleView.graphics.beginFill(0x3E3E3E);


        // Draw Round Rect
        titleView.graphics.drawRoundRect(x,y,width,height,10,10);
        titleView.graphics.endFill();

        // Position
        titleView.y = 0.8 * core.stage.stageHeight;
    }
    
    
} 
