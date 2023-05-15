package app.editorView.appView;

import feathers.controls.Radio;
import app.editorView.appView.appRadio.Code;
import feathers.text.TextFormat;
#if sys
import sys.io.File;
#end

class AppRadio {
    var appRadio:Radio;
    public var code:Code;

    // percents
    public var percents:Bool=false;
    public var widthPercent:Float;
    public var heightPercent:Float;
    public var xPercent:Float;
    public var yPercent:Float;

    public function new(core:Core){
        appRadio = new Radio("radio");
        code = new Code();

        refresh(core);
    }

    public function getAppRadio(){
        return appRadio;
    }

    public function setPercents(core:Core){
        percents = true;

        // Parent dimensions
        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Percent formula widthPercent = (width * 100)/screen
        widthPercent = appRadio.width/parentWidth;
        heightPercent = appRadio.height/parentHeight;

        xPercent = appRadio.x/parentWidth;
        yPercent = appRadio.y/parentHeight;

        // set Code percents
        code.parentWidth = "core.stage.stageWidth";
        code.parentHeight = "core.stage.stageHeight";

        code.width = appRadio.width; 
        code.height = appRadio.height; 

        code.x = appRadio.x;
        code.y = appRadio.y; 
    }

    public function refresh(core:Core){

        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Print percents

        if(percents == true){
            // Size
            appRadio.width = widthPercent * parentWidth;
            appRadio.height = heightPercent * parentHeight; 
            trace("appRadio.width: "+appRadio.width);

            // Position
            appRadio.x = xPercent * parentWidth;
            appRadio.y = yPercent * parentHeight;


            setPercents(core);
            code.saveCode(core);
            
        } 


    }

}