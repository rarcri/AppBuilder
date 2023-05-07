package app.editorView.toolbox.tools;

import app.editorView.appView.AppButton;
import openfl.geom.Point;
import openfl.events.MouseEvent;
import feathers.events.TriggerEvent;
import openfl.events.KeyboardEvent;
import openfl.events.FocusEvent;
import feathers.controls.Button;
import feathers.controls.Panel;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.TextInput;
import feathers.core.PopUpManager;
import openfl.text.TextFormat;
#if sys
import sys.io.File;
#end

class Button {

    var button:feathers.controls.Button;
    // Overlay
    var overlayButton:feathers.controls.Button;
    // Button Aux
    public var appButtonAux:AppButton;
    //PopUp
    var panel:Panel;
    var label:Label;
    var textInput:TextInput;
    var btn:feathers.controls.Button;
    // AppButton
    public var appButtonArray:Array<AppButton>;


    public function new(core:Core){
        button = new feathers.controls.Button("Button");

        // OverlayButton
        overlayButton = new feathers.controls.Button("Button");

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

        // AppButtonArray
        appButtonArray = new Array();
        

        refresh(core);
        events(core);
    }


    public function getButton(){
        return button;
    }


    
    public function refresh(core:Core){

        

        button.width = 0.1 * core.stage.stageWidth;
        button.height = 0.05 * core.stage.stageHeight;

        button.x = 0.2 * core.stage.stageWidth/2 - button.width/2;
        button.y = 0.13 * core.stage.stageHeight;

        // Set Button textFormat
        if(core.stage.stageWidth < core.stage.stageHeight){
		    button.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth));
        } else {
		    button.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight));
        }
        
        // OverlayButton
        overlayButton.width = button.width;
        overlayButton.height = button.height;


        // Children
        if(appButtonArray.length != 0){
            for(appButtonI in appButtonArray){
                appButtonI.refresh(core);
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


        button.addEventListener(MouseEvent.MOUSE_DOWN,(e)->{


            // Set Position
            overlayButton.x = 0.2*core.stage.stageWidth/2 - overlayButton.width/2 + 0.8 * core.stage.stageWidth;
            overlayButton.y = 0.23 * core.stage.stageHeight;

            // Add overlay 
            core.editorView.getEditorView().addChild(overlayButton);
            // Start drag
            overlayButton.startDrag();

        });


        // Cand dam click pe MouseEvent 
        overlayButton.addEventListener(MouseEvent.MOUSE_UP,(e)->{
            trace(overlayButton.x+ " "+ overlayButton.y);
            if(overlayButton.x>0.2 * core.stage.stageWidth &&
               overlayButton.y>0.1 * core.stage.stageHeight &&
               overlayButton.x<0.8 * core.stage.stageWidth){
                // new AppButton
                var appButton = new app.editorView.appView.AppButton(core);
                appButtonArray.push(appButton);
                appButtonAux = appButton;

                
                appButton.getAppButton().width = overlayButton.width;
                appButton.getAppButton().height = overlayButton.height;

                appButton.getAppButton().x = overlayButton.x - core.editorView.appView.getAppView().x;
                appButton.getAppButton().y = overlayButton.y - core.editorView.appView.getAppView().y;



                appButton.setPercents(core);

                core.editorView.appView.getAppView().addChild(appButton.getAppButton());

            

                // Stop Drag
                overlayButton.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayButton);

                // Here we add the PopUp
                PopUpManager.addPopUp(panel, core.stage, true, true);


            } else {

                // Stop Drag
                overlayButton.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayButton);

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

            appButtonAux.code.name = componentName;
            appButtonAux.code.text = "Button";



            // Create file Button for project
            File.saveContent(core.addProject.okButton.path + "/Source/app/"+lowercaseScreenName+"/"+uppercaseComponentName+".hx", appButtonAux.code.getCode(core));

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
    var "+lowercaseComponentName+":"+uppercaseComponentName+";
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

            regex = ~/(?<=refreshButton)\n/mg;

            screenCode = regex.replace(screenCode,"
        "+lowercaseComponentName+".refresh(core);
");

            File.saveContent(screenPath,screenCode);

                // Remove popup
                PopUpManager.removePopUp(panel);

            });
    }

}