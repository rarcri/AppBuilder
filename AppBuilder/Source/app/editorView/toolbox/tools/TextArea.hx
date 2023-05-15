package app.editorView.toolbox.tools;

import app.editorView.appView.AppTextArea;
import openfl.geom.Point;
import openfl.events.Event;
import openfl.events.MouseEvent;
import feathers.events.TriggerEvent;
import openfl.events.KeyboardEvent;
import openfl.events.FocusEvent;
import feathers.controls.Button;
import feathers.controls.TextArea;
import feathers.controls.Panel;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.TextInput;
import feathers.core.PopUpManager;
import openfl.text.TextFormat;
#if sys
import sys.io.File;
#end

class TextArea{

    var textArea:feathers.controls.TextArea;
    // Overlay
    var overlayTextArea:feathers.controls.TextArea;
    // Button Aux
    public var appTextAreaAux:AppTextArea;
    //PopUp
    var panel:Panel;
    var label:Label;
    var textInput:TextInput;
    var btn:feathers.controls.Button;
    // AppButton
    public var appTextAreaArray:Array<AppTextArea>;


    public function new(core:Core){
        textArea = new feathers.controls.TextArea("TextArea");

        // OverlayTextArea
        overlayTextArea = new feathers.controls.TextArea("TextArea");

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

        // AppTextAreaArray
        appTextAreaArray = new Array();
        

        refresh(core);
        events(core);
    }


    public function getTextArea(){
        return textArea;
    }


    
    public function refresh(core:Core){

        

        textArea.width = 0.18 * core.stage.stageWidth;
        textArea.height = 0.1 * core.stage.stageHeight;

        textArea.x = 0.2 * core.stage.stageWidth/2 - textArea.width/2;
        textArea.y = 0.53 * core.stage.stageHeight;

        // Set textArea textFormat
        if(core.stage.stageWidth < core.stage.stageHeight){
		    textArea.textFormat = new TextFormat("Arial", Std.int(0.02 * core.stage.stageWidth));
        } else {
		    textArea.textFormat = new TextFormat("Arial", Std.int(0.02 * core.stage.stageHeight));
        }
        
        // OverlaytextArea
        overlayTextArea.width = textArea.width;
        overlayTextArea.height = textArea.height;


        // Children
        if(appTextAreaArray.length != 0){
            for(appTextAreaI in appTextAreaArray){
                appTextAreaI.refresh(core);
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


        textArea.addEventListener(MouseEvent.MOUSE_DOWN,(e)->{


            // Set Position
            overlayTextArea.x = 0.2*core.stage.stageWidth/2 - overlayTextArea.width/2 + 0.8 * core.stage.stageWidth;
            overlayTextArea.y = 0.63 * core.stage.stageHeight;

            // Add overlay 
            core.editorView.getEditorView().addChild(overlayTextArea);
            // Start drag
            overlayTextArea.startDrag();

        });


        // Cand dam click pe MouseEvent 
        overlayTextArea.addEventListener(MouseEvent.MOUSE_UP,(e)->{
            trace(overlayTextArea.x+ " "+ overlayTextArea.y);
            if(overlayTextArea.x>0.2 * core.stage.stageWidth &&
               overlayTextArea.y>0.1 * core.stage.stageHeight &&
               overlayTextArea.x<0.8 * core.stage.stageWidth){


                // new AppTextArea
                var appTextArea = new app.editorView.appView.AppTextArea(core);
                appTextAreaArray.push(appTextArea);
                appTextAreaAux = appTextArea;

                
                appTextArea.getAppTextArea().width = overlayTextArea.width;
                appTextArea.getAppTextArea().height = overlayTextArea.height;

                appTextArea.getAppTextArea().x = overlayTextArea.x - core.editorView.appView.getAppView().x;
                appTextArea.getAppTextArea().y = overlayTextArea.y - core.editorView.appView.getAppView().y;



                appTextArea.setPercents(core);

                core.editorView.appView.getAppView().addChild(appTextArea.getAppTextArea());

            

                // Stop Drag
                overlayTextArea.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayTextArea);


                // Here we add the PopUp
                PopUpManager.addPopUp(panel, core.stage, true, true);


            } else {

                // Stop Drag
                overlayTextArea.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayTextArea);

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

            appTextAreaAux.code.name = componentName;
            appTextAreaAux.code.text = "TextArea";



            // Create file TextArea for project
            File.saveContent(core.addProject.okButton.path + "/Source/app/"+lowercaseScreenName+"/"+uppercaseComponentName+".hx", appTextAreaAux.code.getCode(core));

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