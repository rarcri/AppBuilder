package app.editorView.appView;

import feathers.controls.TextInput;
import app.editorView.appView.appTextInput.Code;
import feathers.text.TextFormat;
#if sys
import sys.io.File;
#end

class AppTextInput {
    var appTextInput:TextInput;
    public var code:Code;

    // percents
    public var percents:Bool=false;
    public var widthPercent:Float;
    public var heightPercent:Float;
    public var xPercent:Float;
    public var yPercent:Float;

    public function new(core:Core){
        appTextInput = new TextInput();
        code = new Code();

        refresh(core);
    }

    public function getAppTextInput(){
        return appTextInput;
    }

    public function setPercents(core:Core){
        percents = true;

        // Parent dimensions
        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Percent formula widthPercent = (width * 100)/screen
        widthPercent = appTextInput.width/parentWidth;
        heightPercent = appTextInput.height/parentHeight;

        xPercent = appTextInput.x/parentWidth;
        yPercent = appTextInput.y/parentHeight;

        // set Code percents
        code.parentWidth = "core.stage.stageWidth";
        code.parentHeight = "core.stage.stageHeight";

        code.width = appTextInput.width; 
        code.height = appTextInput.height; 

        code.x = appTextInput.x;
        code.y = appTextInput.y; 
    }

    public function refresh(core:Core){

        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Print percents

        if(percents == true){
            // Size
            appTextInput.width = widthPercent * parentWidth;
            appTextInput.height = heightPercent * parentHeight; 
            trace("appTextInput.width: "+appTextInput.width);

            // Position
            appTextInput.x = xPercent * parentWidth;
            appTextInput.y = yPercent * parentHeight;


            setPercents(core);
            code.saveCode(core);
            
        } 



        // Set Label textFormat
        // if(core.stage.stageWidth < core.stage.stageHeight){
		//     appTextInput.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth));
        // } else {
		//     appTextInput.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight));
        // }
    }

}