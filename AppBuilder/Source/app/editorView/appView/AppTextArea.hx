package app.editorView.appView;

import feathers.controls.TextArea;
import app.editorView.appView.appTextArea.Code;
import feathers.text.TextFormat;
#if sys
import sys.io.File;
#end

class AppTextArea {
    var appTextArea:TextArea;
    public var code:Code;

    // percents
    public var percents:Bool=false;
    public var widthPercent:Float;
    public var heightPercent:Float;
    public var xPercent:Float;
    public var yPercent:Float;

    public function new(core:Core){
        appTextArea = new TextArea("check");
        code = new Code();

        refresh(core);
    }

    public function getAppTextArea(){
        return appTextArea;
    }

    public function setPercents(core:Core){
        percents = true;

        // Parent dimensions
        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Percent formula widthPercent = (width * 100)/screen
        widthPercent = appTextArea.width/parentWidth;
        heightPercent = appTextArea.height/parentHeight;

        xPercent = appTextArea.x/parentWidth;
        yPercent = appTextArea.y/parentHeight;

        // set Code percents
        code.parentWidth = "core.stage.stageWidth";
        code.parentHeight = "core.stage.stageHeight";

        code.width = appTextArea.width; 
        code.height = appTextArea.height; 

        code.x = appTextArea.x;
        code.y = appTextArea.y; 
    }

    public function refresh(core:Core){

        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Print percents

        if(percents == true){
            // Size
            appTextArea.width = widthPercent * parentWidth;
            appTextArea.height = heightPercent * parentHeight; 
            trace("appTextArea.width: "+appTextArea.width);

            // Position
            appTextArea.x = xPercent * parentWidth;
            appTextArea.y = yPercent * parentHeight;


            setPercents(core);
            code.saveCode(core);
            
        } 


    }

}