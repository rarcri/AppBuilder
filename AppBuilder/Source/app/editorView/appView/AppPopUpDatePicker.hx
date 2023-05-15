package app.editorView.appView;

import feathers.controls.PopUpDatePicker;
import app.editorView.appView.appPopUpDatePicker.Code;
import feathers.text.TextFormat;
#if sys
import sys.io.File;
#end

class AppPopUpDatePicker {
    var appPopUpDatePicker:PopUpDatePicker;
    public var code:Code;

    // percents
    public var percents:Bool=false;
    public var widthPercent:Float;
    public var heightPercent:Float;
    public var xPercent:Float;
    public var yPercent:Float;

    public function new(core:Core){
        appPopUpDatePicker = new PopUpDatePicker();
        code = new Code();

        refresh(core);
    }

    public function getAppPopUpDatePicker(){
        return appPopUpDatePicker;
    }

    public function setPercents(core:Core){
        percents = true;

        // Parent dimensions
        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Percent formula widthPercent = (width * 100)/screen
        widthPercent = appPopUpDatePicker.width/parentWidth;
        heightPercent = appPopUpDatePicker.height/parentHeight;

        xPercent = appPopUpDatePicker.x/parentWidth;
        yPercent = appPopUpDatePicker.y/parentHeight;

        // set Code percents
        code.parentWidth = "core.stage.stageWidth";
        code.parentHeight = "core.stage.stageHeight";

        code.width = appPopUpDatePicker.width; 
        code.height = appPopUpDatePicker.height; 

        code.x = appPopUpDatePicker.x;
        code.y = appPopUpDatePicker.y; 
    }

    public function refresh(core:Core){

        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Print percents

        if(percents == true){
            // Size
            appPopUpDatePicker.width = widthPercent * parentWidth;
            appPopUpDatePicker.height = heightPercent * parentHeight; 
            trace("appPopUpDatePicker.width: "+appPopUpDatePicker.width);

            // Position
            appPopUpDatePicker.x = xPercent * parentWidth;
            appPopUpDatePicker.y = yPercent * parentHeight;


            setPercents(core);
            code.saveCode(core);
            
        } 


    }

}