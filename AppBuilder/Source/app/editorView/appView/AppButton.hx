package app.editorView.appView;

import feathers.controls.Button;
import app.editorView.appView.appButton.Code;
import feathers.text.TextFormat;
#if sys
import sys.io.File;
#end

class AppButton {
    var appButton:Button;
    public var code:Code;

    // percents
    public var percents:Bool=false;
    public var widthPercent:Float;
    public var heightPercent:Float;
    public var xPercent:Float;
    public var yPercent:Float;

    public function new(core:Core){
        appButton = new Button("Button");
        code = new Code();

        refresh(core);
    }

    public function getAppButton(){
        return appButton;
    }

    public function setPercents(core:Core){
        percents = true;

        // Parent dimensions
        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Percent formula widthPercent = (width * 100)/screen
        widthPercent = appButton.width/parentWidth;
        heightPercent = appButton.height/parentHeight;

        xPercent = appButton.x/parentWidth;
        yPercent = appButton.y/parentHeight;

        // set Code percents
        code.parentWidth = "core.stage.stageWidth";
        code.parentHeight = "core.stage.stageHeight";

        code.width = appButton.width; 
        code.height = appButton.height; 

        code.x = appButton.x;
        code.y = appButton.y; 
    }

    public function refresh(core:Core){

        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Print percents

        if(percents == true){
            // Size
            appButton.width = widthPercent * parentWidth;
            appButton.height = heightPercent * parentHeight; 
            trace("appButton.width: "+appButton.width);

            // Position
            appButton.x = xPercent * parentWidth;
            appButton.y = yPercent * parentHeight;


            setPercents(core);
            code.saveCode(core);
            
        } 



        // Set Button textFormat
        if(core.stage.stageWidth < core.stage.stageHeight){
		    appButton.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth));
        } else {
		    appButton.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight));
        }
    }

}