package app.editorView.toolbox.tools;

import app.editorView.appView.AppTextInput;
import openfl.geom.Point;
import openfl.events.Event;
import openfl.events.MouseEvent;
import feathers.events.TriggerEvent;
import openfl.events.KeyboardEvent;
import openfl.events.FocusEvent;
import feathers.controls.Label;
import feathers.controls.Panel;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.TextInput;
import feathers.core.PopUpManager;
import openfl.text.TextFormat;
#if sys
import sys.io.File;
#end

class TextInput {

    var textInput:feathers.controls.TextInput;
    // Overlay
    var overlayTextInput:feathers.controls.TextInput;
    // Label Aux
    public var appTextInputAux:AppTextInput;

    //PopUp
    var panel:Panel;
    var label1:feathers.controls.Label;
    var textInput1:feathers.controls.TextInput;
    var btn:feathers.controls.Button;
    // AppLabel
    public var appTextInputArray:Array<AppTextInput>;


    public function new(core:Core){
        textInput = new feathers.controls.TextInput("Text Input");

        // OverlayLabel
        overlayTextInput = new feathers.controls.TextInput();

        // Popup
        panel = new Panel();
        panel.header = new Header("Numele Componentei");
        
        label1 = new feathers.controls.Label("Introduceți numele:");
        panel.addChild(label1);

        textInput1 = new feathers.controls.TextInput();
        textInput1.restrict = "a-zA-Z0-9_";
        panel.addChild(textInput1);

        btn = new feathers.controls.Button("OK");
        panel.addChild(btn);

        // AppTextInputArray
        appTextInputArray = new Array();
        

        refresh(core);
        events(core);
    }


    public function getTextInput(){
        return textInput;
    }


    
    public function refresh(core:Core){

        

        textInput.width = 0.1 * core.stage.stageWidth;
        textInput.height = 0.05 * core.stage.stageHeight;

        textInput.x = 0.2 * core.stage.stageWidth/2 - textInput.width/2;
        textInput.y = 0.33 * core.stage.stageHeight;

        // Set Label textFormat
        if(core.stage.stageWidth < core.stage.stageHeight){
		    textInput.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth));
        } else {
		    textInput.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight));
        }
        
        // OverlayLabel
        overlayTextInput.width = textInput.width;
        overlayTextInput.height = textInput.height;


        // Children
        if(appTextInputArray.length != 0){
            for(appTextInputI in appTextInputArray){
                appTextInputI.refresh(core);
            }
        }


        // PopUp 
        panel.width = 0.5 * core.stage.stageWidth;
        panel.height = 0.4 * core.stage.stageHeight;

        label1.width = 0.4 * panel.width;
        label1.height = 0.1 * panel.height;

        label1.x = panel.width / 2 - label1.width/2;
        label1.y = 0.1 * panel.height;

        textInput1.width = 0.4 * panel.width;
        textInput1.height = 0.1 * panel.height;

        textInput1.x = panel.width / 2 - textInput1.width/2;
        textInput1.y = 0.2 * panel.height;
        
        btn.width = 0.4 * panel.width;
        btn.height = 0.1 * panel.height;

        btn.x = panel.width/2 - btn.width/2;
        btn.y = 0.4 * panel.height;

    }

    public function events(core:Core){


        textInput.addEventListener(MouseEvent.MOUSE_DOWN,(e)->{


            // Set Position
            overlayTextInput.x = 0.2*core.stage.stageWidth/2 - overlayTextInput.width/2 + 0.8 * core.stage.stageWidth;
            overlayTextInput.y = 0.43 * core.stage.stageHeight;

            // Add overlay 
            core.editorView.getEditorView().addChild(overlayTextInput);
            // Start drag
            overlayTextInput.startDrag();

        });


        // Cand dam click pe MouseEvent 
        overlayTextInput.addEventListener(MouseEvent.MOUSE_UP,(e)->{
            trace(overlayTextInput.x+ " "+ overlayTextInput.y);
            if(overlayTextInput.x>0.2 * core.stage.stageWidth &&
               overlayTextInput.y>0.1 * core.stage.stageHeight &&
               overlayTextInput.x<0.8 * core.stage.stageWidth){
                // new AppLabel
                var appTextInput = new app.editorView.appView.AppTextInput(core);
                appTextInputArray.push(appTextInput);
                appTextInputAux= appTextInput;

                
                appTextInput.getAppTextInput().width = overlayTextInput.width;
                appTextInput.getAppTextInput().height = overlayTextInput.height;

                appTextInput.getAppTextInput().x = overlayTextInput.x - core.editorView.appView.getAppView().x;
                appTextInput.getAppTextInput().y = overlayTextInput.y - core.editorView.appView.getAppView().y;



                appTextInput.setPercents(core);

                core.editorView.appView.getAppView().addChild(appTextInput.getAppTextInput());

            

                // Stop Drag
                overlayTextInput.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayTextInput);

                // Here we add the PopUp
                PopUpManager.addPopUp(panel, core.stage, true, true);


            } else {

                // Stop Drag
                overlayTextInput.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayTextInput);

            }
        });

        // Add Event Listener to popup
        btn.addEventListener(TriggerEvent.TRIGGER,(e)->{

            // Refresh Buttons
            var index = core.editorView.panel.toggleGroup.selectedIndex;
            core.editorView.panel.screens[index].radioButton.dispatchEvent(new Event("CHANGE"));

            // ScreenName
            var screenIndex = core.editorView.panel.toggleGroup.selectedIndex;
            var screenName = core.editorView.panel.screens[screenIndex].text.text;

            var uppercaseScreenName = "";
            var lowercaseScreenName = "";
            
            uppercaseScreenName = screenName.substring(0,1).toUpperCase() + screenName.substring(1);
            lowercaseScreenName = screenName.substring(0,1).toLowerCase() + screenName.substring(1);


            // Name of the component
            var componentName = textInput1.text;


            // upper and lowercase Name for Component
            var uppercaseComponentName = componentName.substring(0,1).toUpperCase() + componentName.substring(1);
            var lowercaseComponentName = componentName.substring(0,1).toLowerCase() + componentName.substring(1);

            appTextInputAux.code.name = componentName;
            appTextInputAux.code.text = "Label";



            // Create file Label for project
            File.saveContent(core.addProject.okButton.path + "/Source/app/"+lowercaseScreenName+"/"+uppercaseComponentName+".hx", appTextInputAux.code.getCode(core));

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