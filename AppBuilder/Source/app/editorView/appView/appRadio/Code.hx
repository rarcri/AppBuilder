package app.editorView.appView.appRadio;

#if sys
import sys.io.File;
#end

class Code{

    //Properties
    public var name:String;
    public var text:String;
    public var parentWidth:String;
    public var parentHeight:String;
    public var width:Float;
    public var height:Float;
    public var x:Float;
    public var y:Float;

    // Percents
    public var widthPercent:Float;
    public var heightPercent:Float;
    public var xPercent:Float;
    public var yPercent:Float;

    // Name
    public var uppercaseName:String;
    public var lowercaseName:String;

    //Screen Name
    public var uppercaseScreenName:String;
    public var lowercaseScreenName:String;
    
    public function new(){
    }

    public function saveCode(core:Core){
        uppercaseName = name.substring(0,1).toUpperCase() + name.substring(1);
        lowercaseName = name.substring(0,1).toLowerCase() + name.substring(1);

        // Create file Button for project
        File.saveContent(core.addProject.okButton.path + "/Source/app/"+lowercaseScreenName+"/"+uppercaseName+".hx", getCode(core));

        trace("Code saved and Component name is: " + uppercaseName + " and the width is " + width);
    }

    public function getCode(core:Core){

        uppercaseName = name.substring(0,1).toUpperCase() + name.substring(1);
        lowercaseName = name.substring(0,1).toLowerCase() + name.substring(1);

        core.editorView.appView.refresh(core);

        widthPercent=width/core.editorView.appView.getAppView().width;
        heightPercent=height/core.editorView.appView.getAppView().height;
        xPercent=x/core.editorView.appView.getAppView().width;
        yPercent=y/core.editorView.appView.getAppView().height;
        trace(widthPercent);

        // ScreenIndex
        var screenIndex = core.editorView.panel.toggleGroup.selectedIndex;
        var screenName = core.editorView.panel.screens[screenIndex].text.text;

        uppercaseScreenName = "";
        lowercaseScreenName = "";
        
        uppercaseScreenName = screenName.substring(0,1).toUpperCase() + screenName.substring(1);
        lowercaseScreenName = screenName.substring(0,1).toLowerCase() + screenName.substring(1);

        return "package app."+lowercaseScreenName+";

import feathers.controls.Radio;
import openfl.events.Event;

class "+ uppercaseName+" {
    var "+lowercaseName+":Radio;


    public function new(core:Core){
        // Title
        "+lowercaseName+"= new Radio('"+text+"');
        // End Title

        refresh(core);
        events(core);
    }

    public function get"+uppercaseName+"(){
        return "+lowercaseName+";
    }

    public function refresh(core:Core){
        // Refresh
        // Parent dimensions
        var parentWidth = core.stage.stageWidth;
        var parentHeight = core.stage.stageHeight;

        "+lowercaseName+".width = "+widthPercent+" * parentWidth;
        "+lowercaseName+".height = "+heightPercent+" * parentHeight; 

        "+lowercaseName+".x = "+xPercent+" * parentWidth;
        "+lowercaseName+".y = "+yPercent+" * parentHeight;
        // End Refresh
    }

    public function events(core:Core){
        "+lowercaseName+".addEventListener(Event.CHANGE,(e)->{
            // TriggerEvent

            // End TriggerEvent
        });
    }
}";
    }
}