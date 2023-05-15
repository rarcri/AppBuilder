package app.editorView.appView;

import feathers.controls.Label;
import app.editorView.appView.appLabel.Code;
import feathers.text.TextFormat;
#if sys
import sys.io.File;
#end

class AppLabel {
    var appLabel:Label;
    public var code:Code;

    // percents
    public var percents:Bool=false;
    public var widthPercent:Float;
    public var heightPercent:Float;
    public var xPercent:Float;
    public var yPercent:Float;

    public function new(core:Core){
        appLabel = new Label("Label");
        code = new Code();

        refresh(core);
    }

    public function getAppLabel(){
        return appLabel;
    }

    public function setPercents(core:Core){
        percents = true;

        // Parent dimensions
        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Percent formula widthPercent = (width * 100)/screen
        widthPercent = appLabel.width/parentWidth;
        heightPercent = appLabel.height/parentHeight;

        xPercent = appLabel.x/parentWidth;
        yPercent = appLabel.y/parentHeight;

        // set Code percents
        code.parentWidth = "core.stage.stageWidth";
        code.parentHeight = "core.stage.stageHeight";

        code.width = appLabel.width; 
        code.height = appLabel.height; 

        code.x = appLabel.x;
        code.y = appLabel.y; 
    }

    public function refresh(core:Core){

        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        // Print percents

        if(percents == true){
            // Size
            appLabel.width = widthPercent * parentWidth;
            appLabel.height = heightPercent * parentHeight; 
            trace("appLabel.width: "+appLabel.width);

            // Position
            appLabel.x = xPercent * parentWidth;
            appLabel.y = yPercent * parentHeight;


            setPercents(core);
            code.saveCode(core);
            
        } 



        // Set Label textFormat
        // if(core.stage.stageWidth < core.stage.stageHeight){
		//     appLabel.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth));
        // } else {
		//     appLabel.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight));
        // }
    }

}