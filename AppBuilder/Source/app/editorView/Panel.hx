package app.editorView;

import feathers.core.ToggleGroup;
import feathers.controls.ScrollContainer;
import app.editorView.panel.AddScreenButton;
import app.editorView.panel.Screen;
#if sys
import sys.io.File;
#end

class Panel{
    var panel:ScrollContainer;
    public var addScreenButton:AddScreenButton;
    public var y:Float;
    public var screens:Array<Screen>=[];
    public var toggleGroup:ToggleGroup;

    public function new(core:Core){
        y = 0.12 * core.stage.stageHeight;

        panel = new ScrollContainer();

        addScreenButton = new AddScreenButton(core);

        panel.addChild(addScreenButton.getAddScreenButton());
        
        // New Toggle group
        toggleGroup = new ToggleGroup();

        var screen = new Screen(core);

        screen.getScreen().y = y;
        screen.text.text = "Screen1";
        screen.radioButton.toggleGroup = toggleGroup;
        screens.push(screen);

        panel.addChild(screen.getScreen());
        
    }

    public function getPanel(){
        return panel;
    }

    public function addScreen(text,core){
        y = y + 0.07 * core.stage.stageHeight;

        var screen = new Screen(core);
        screen.getScreen().y = y;
        screen.text.text = text;
        screen.radioButton.toggleGroup = toggleGroup;
        screens.push(screen);


        panel.addChild(screen.getScreen());

        // COde elements
        var textAux;
        textAux = text.substring(0,1).toLowerCase() + text.substring(1);

        if(sys.FileSystem.exists(core.addProject.okButton.path+"/Source/app/"+textAux) != true){

            Sys.command("cd "+core.addProject.okButton.path+"/Source/app && mkdir "+textAux);

            // Add Screen to Core

                // Change Core for Screen1
                var corePath = core.addProject.okButton.path+"/Source/Core.hx";
                var coreCode = File.getContent(corePath);
                var screenName = text;
                var uppercaseScreenName = "";
                var lowercaseScreenName = "";
                
                uppercaseScreenName = screenName.substring(0,1).toUpperCase() + screenName.substring(1);
                lowercaseScreenName = screenName.substring(0,1).toLowerCase() + screenName.substring(1);

                //  Imports
                var regex = ~/(?<=import openfl.display.Sprite;)\n/mg;

                coreCode = regex.replace(coreCode,"
    import app."+uppercaseScreenName+";
    ");

                // Define 
                regex = ~/(?<=var Children)\n/mg;

                coreCode = regex.replace(coreCode,"
        var "+lowercaseScreenName+":"+uppercaseScreenName+";
    ");

                // create Children
                regex = ~/(?<=create Children)\n/mg;

                coreCode = regex.replace(coreCode,"
            "+lowercaseScreenName+" = new "+uppercaseScreenName+"(this);
    ");

                // add Children
                regex = ~/(?<=add Children)\n/mg;

                coreCode = regex.replace(coreCode,"
            core.addChild("+lowercaseScreenName+".get"+uppercaseScreenName+"());
    ");

                regex = ~/(?<=refreshButton)\n/mg;

                coreCode = regex.replace(coreCode,"
            "+lowercaseScreenName+".refresh(this);
    ");

                File.saveContent(corePath,coreCode);


                var screenName = text;
                var uppercaseScreenName = "";
                var lowercaseScreenName = "";
                
                uppercaseScreenName = screenName.substring(0,1).toUpperCase() + screenName.substring(1);
                lowercaseScreenName = screenName.substring(0,1).toLowerCase() + screenName.substring(1);


                // Content for screen1
                var screenContent = "package app;
    import openfl.display.Stage;
    import openfl.display.Sprite;

    class "+uppercaseScreenName+" {
        var "+lowercaseScreenName+":Sprite;
        // var Children

        public function new(core:Core){

            "+lowercaseScreenName+" = new Sprite();

            // create Children

            // add Children


            refresh(core);
        }

        public function get"+uppercaseScreenName+"(){
            return "+lowercaseScreenName+";
        }

        public function refresh(core:Core){
            // refreshButton

        }

    }";

                // Save the Screen1 content 
                File.saveContent(core.addProject.okButton.path +"/Source/app/"+uppercaseScreenName+".hx",screenContent);
        }  else {
            trace("screen Exists");
        }
    }

    public function refresh(core:Core){


        panel.width = core.stage.stageWidth * 0.2;
        panel.height = 0.9 * core.stage.stageHeight;

        panel.x = 0; 
        panel.y = 0.1 * core.stage.stageHeight;

        // Children
        addScreenButton.refresh(core);

        for(screen in screens){
            screen.refresh(core);
        }
    }
}