package app.editorView.appView;

import feathers.controls.Check;
import app.editorView.appView.appCheck.Code;
import feathers.text.TextFormat;
#if sys
import sys.io.File;
#end

class AppCheck {
    var appCheck:Check;
    public var code:Code;

    // percents
    public var percents:Bool=false;
    public var widthPercent:Float;
    public var heightPercent:Float;
    public var xPercent:Float;
    public var yPercent:Float;

    public function new(core:Core){
        appCheck = new Check("check");
        code = new Code();

        refresh(core);
    }

    public function getAppCheck(){
        return appCheck;
    }

    public function setPercents(core:Core){
        percents = true;

        // Parent dimensions
        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Percent formula widthPercent = (width * 100)/screen
        widthPercent = appCheck.width/parentWidth;
        heightPercent = appCheck.height/parentHeight;

        xPercent = appCheck.x/parentWidth;
        yPercent = appCheck.y/parentHeight;

        // set Code percents
        code.parentWidth = "core.stage.stageWidth";
        code.parentHeight = "core.stage.stageHeight";

        code.width = appCheck.width; 
        code.height = appCheck.height; 

        code.x = appCheck.x;
        code.y = appCheck.y; 
    }

    public function refresh(core:Core){

        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Print percents

        if(percents == true){
            // Size
            appCheck.width = widthPercent * parentWidth;
            appCheck.height = heightPercent * parentHeight; 
            trace("appCheck.width: "+appCheck.width);

            // Position
            appCheck.x = xPercent * parentWidth;
            appCheck.y = yPercent * parentHeight;


            setPercents(core);
            code.saveCode(core);
            
        } 


    }

}