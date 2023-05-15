package app.editorView.toolbox.tools;

import app.editorView.appView.AppCheck;
import openfl.geom.Point;
import openfl.events.Event;
import openfl.events.MouseEvent;
import feathers.events.TriggerEvent;
import openfl.events.KeyboardEvent;
import openfl.events.FocusEvent;
import feathers.controls.Button;
import feathers.controls.Check;
import feathers.controls.Panel;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.TextInput;
import feathers.core.PopUpManager;
import openfl.text.TextFormat;
#if sys
import sys.io.File;
#end

class Check{

    var check:feathers.controls.Check;
    // Overlay
    var overlayCheck:feathers.controls.Check;
    // Button Aux
    public var appCheckAux:AppCheck;
    //PopUp
    var panel:Panel;
    var label:Label;
    var textInput:TextInput;
    var btn:feathers.controls.Button;
    // AppButton
    public var appCheckArray:Array<AppCheck>;


    public function new(core:Core){
        check = new feathers.controls.Check("Check");

        // OverlayCheck
        overlayCheck = new feathers.controls.Check("Check");

        // Popup
        panel = new Panel();
        panel.header = new Header("Numele Componentei");
        
        label = new Label("Introduceți numele:");
        panel.addChild(label);

        textInput = new TextInput();
        textInput.restrict = "a-zA-Z0-9_";
        panel.addChild(textInput);

        btn = new feathers.controls.Button("OK");
        panel.addChild(btn);

        // AppCheckArray
        appCheckArray = new Array();
        

        refresh(core);
        events(core);
    }


    public function getCheck(){
        return check;
    }


    
    public function refresh(core:Core){

        

        check.width = 0.1 * core.stage.stageWidth;
        check.height = 0.05 * core.stage.stageHeight;

        check.x = 0.2 * core.stage.stageWidth/2 - check.width/2;
        check.y = 0.43 * core.stage.stageHeight;

        // Set check textFormat
        if(core.stage.stageWidth < core.stage.stageHeight){
		    check.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth));
        } else {
		    check.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight));
        }
        
        // Overlaycheck
        overlayCheck.width = check.width;
        overlayCheck.height = check.height;


        // Children
        if(appCheckArray.length != 0){
            for(appCheckI in appCheckArray){
                appCheckI.refresh(core);
            }
        }


        // PopUp 
        panel.width = 0.5 * core.stage.stageWidth;
        panel.height = 0.4 * core.stage.stageHeight;

        label.width = 0.4 * panel.width;
        label.height = 0.1 * panel.height;

        label.x = panel.width / 2 - label.width/2;
        label.y = 0.1 * panel.height;

        textInput.width = 0.4 * panel.width;
        textInput.height = 0.1 * panel.height;

        textInput.x = panel.width / 2 - textInput.width/2;
        textInput.y = 0.2 * panel.height;
        
        btn.width = 0.4 * panel.width;
        btn.height = 0.1 * panel.height;

        btn.x = panel.width/2 - btn.width/2;
        btn.y = 0.4 * panel.height;

    }

    public function events(core:Core){


        check.addEventListener(MouseEvent.MOUSE_DOWN,(e)->{


            // Set Position
            overlayCheck.x = 0.2*core.stage.stageWidth/2 - overlayCheck.width/2 + 0.8 * core.stage.stageWidth;
            overlayCheck.y = 0.53 * core.stage.stageHeight;

            // Add overlay 
            core.editorView.getEditorView().addChild(overlayCheck);
            // Start drag
            overlayCheck.startDrag();

        });


        // Cand dam click pe MouseEvent 
        overlayCheck.addEventListener(MouseEvent.MOUSE_UP,(e)->{
            trace(overlayCheck.x+ " "+ overlayCheck.y);
            if(overlayCheck.x>0.2 * core.stage.stageWidth &&
               overlayCheck.y>0.1 * core.stage.stageHeight &&
               overlayCheck.x<0.8 * core.stage.stageWidth){


                // new AppCheck
                var appCheck = new app.editorView.appView.AppCheck(core);
                appCheckArray.push(appCheck);
                appCheckAux = appCheck;

                
                appCheck.getAppCheck().width = overlayCheck.width;
                appCheck.getAppCheck().height = overlayCheck.height;

                appCheck.getAppCheck().x = overlayCheck.x - core.editorView.appView.getAppView().x;
                appCheck.getAppCheck().y = overlayCheck.y - core.editorView.appView.getAppView().y;



                appCheck.setPercents(core);

                core.editorView.appView.getAppView().addChild(appCheck.getAppCheck());

            

                // Stop Drag
                overlayCheck.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayCheck);


                // Here we add the PopUp
                PopUpManager.addPopUp(panel, core.stage, true, true);


            } else {

                // Stop Drag
                overlayCheck.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayCheck);

            }
        });

        // Add Event Listener to popup
        btn.addEventListener(TriggerEvent.TRIGGER,(e)->{

            // ScreenName
            var screenIndex = core.editorView.panel.toggleGroup.selectedIndex;
            var screenName = core.editorView.panel.screens[screenIndex].text.text;

            var uppercaseScreenName = "";
            var lowercaseScreenName = "";
            
            uppercaseScreenName = screenName.substring(0,1).toUpperCase() + screenName.substring(1);
            lowercaseScreenName = screenName.substring(0,1).toLowerCase() + screenName.substring(1);


            // Name of the component
            var componentName = textInput.text;


            // upper and lowercase Name for Component
            var uppercaseComponentName = componentName.substring(0,1).toUpperCase() + componentName.substring(1);
            var lowercaseComponentName = componentName.substring(0,1).toLowerCase() + componentName.substring(1);

            appCheckAux.code.name = componentName;
            appCheckAux.code.text = "Check";



            // Create file Check for project
            File.saveContent(core.addProject.okButton.path + "/Source/app/"+lowercaseScreenName+"/"+uppercaseComponentName+".hx", appCheckAux.code.getCode(core));

            // Refresh radioButton();
            var index = core.editorView.panel.toggleGroup.selectedIndex;
            core.editorView.panel.toggleGroup.selectedIndex = 0;
            core.editorView.panel.toggleGroup.selectedIndex = index;

            // Change Core
            var screenPath = core.addProject.okButton.path+"/Source/app/"+uppercaseScreenName+".hx";

            var screenCode = File.getContent(screenPath);

            //  Imports
            var regex = ~/(?<=import openfl.display.Sprite;)\n/mg;

            screenCode = regex.replace(screenCode,"
import app."+lowercaseScreenName+"."+uppercaseComponentName+";
");

            // Define 
            regex = ~/(?<=var Children)\n/mg;

            screenCode = regex.replace(screenCode,"
        public var "+lowercaseComponentName+":"+uppercaseComponentName+";
");

            // create Children
            regex = ~/(?<=create Children)\n/mg;

            screenCode = regex.replace(screenCode,"
            "+lowercaseComponentName+" = new "+uppercaseComponentName+"(core);
");

            // add Children
            regex = ~/(?<=add Children)\n/mg;

            screenCode = regex.replace(screenCode,"
            "+lowercaseScreenName+".addChild("+lowercaseComponentName+".get"+uppercaseComponentName+"());
");

            regex = ~/(?<=refreshChildren)\n/mg;

            screenCode = regex.replace(screenCode,"
            "+lowercaseComponentName+".refresh(core);
");

            File.saveContent(screenPath,screenCode);

                // Remove popup
                PopUpManager.removePopUp(panel);

            });
    }

}