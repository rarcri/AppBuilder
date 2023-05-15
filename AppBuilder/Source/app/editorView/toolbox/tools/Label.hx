package app.editorView.toolbox.tools;

import app.editorView.appView.AppLabel;
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

class Label {

    var label:feathers.controls.Label;
    // Overlay
    var overlayLabel:feathers.controls.Label;
    // Label Aux
    public var appLabelAux:AppLabel;

    //PopUp
    var panel:Panel;
    var label1:feathers.controls.Label;
    var textInput:TextInput;
    var btn:feathers.controls.Button;
    // AppLabel
    public var appLabelArray:Array<AppLabel>;


    public function new(core:Core){
        label = new feathers.controls.Label("Label");

        // OverlayLabel
        overlayLabel = new feathers.controls.Label("Label");

        // Popup
        panel = new Panel();
        panel.header = new Header("Numele Componentei");
        
        label1 = new feathers.controls.Label("Introduceți numele:");
        panel.addChild(label1);

        textInput = new TextInput();
        textInput.restrict = "a-zA-Z0-9_";
        panel.addChild(textInput);

        btn = new feathers.controls.Button("OK");
        panel.addChild(btn);

        // AppLabelArray
        appLabelArray = new Array();
        

        refresh(core);
        events(core);
    }


    public function getLabel(){
        return label;
    }


    
    public function refresh(core:Core){

        

        label.width = 0.1 * core.stage.stageWidth;
        label.height = 0.05 * core.stage.stageHeight;

        label.x = 0.2 * core.stage.stageWidth/2 - label.width/2;
        label.y = 0.23 * core.stage.stageHeight;

        // Set Label textFormat
        if(core.stage.stageWidth < core.stage.stageHeight){
		    label.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth));
        } else {
		    label.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight));
        }
        
        // OverlayLabel
        overlayLabel.width = label.width;
        overlayLabel.height = label.height;


        // Children
        if(appLabelArray.length != 0){
            for(appLabelI in appLabelArray){
                appLabelI.refresh(core);
            }
        }


        // PopUp 
        panel.width = 0.5 * core.stage.stageWidth;
        panel.height = 0.4 * core.stage.stageHeight;

        label1.width = 0.4 * panel.width;
        label1.height = 0.1 * panel.height;

        label1.x = panel.width / 2 - label1.width/2;
        label1.y = 0.1 * panel.height;

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


        label.addEventListener(MouseEvent.MOUSE_DOWN,(e)->{


            // Set Position
            overlayLabel.x = 0.2*core.stage.stageWidth/2 - overlayLabel.width/2 + 0.8 * core.stage.stageWidth;
            overlayLabel.y = 0.33 * core.stage.stageHeight;

            // Add overlay 
            core.editorView.getEditorView().addChild(overlayLabel);
            // Start drag
            overlayLabel.startDrag();

        });


        // Cand dam click pe MouseEvent 
        overlayLabel.addEventListener(MouseEvent.MOUSE_UP,(e)->{
            trace(overlayLabel.x+ " "+ overlayLabel.y);
            if(overlayLabel.x>0.2 * core.stage.stageWidth &&
               overlayLabel.y>0.1 * core.stage.stageHeight &&
               overlayLabel.x<0.8 * core.stage.stageWidth){
                // new AppLabel
                var appLabel = new app.editorView.appView.AppLabel(core);
                appLabelArray.push(appLabel);
                appLabelAux = appLabel;

                
                appLabel.getAppLabel().width = overlayLabel.width;
                appLabel.getAppLabel().height = overlayLabel.height;

                appLabel.getAppLabel().x = overlayLabel.x - core.editorView.appView.getAppView().x;
                appLabel.getAppLabel().y = overlayLabel.y - core.editorView.appView.getAppView().y;



                appLabel.setPercents(core);

                core.editorView.appView.getAppView().addChild(appLabel.getAppLabel());

            

                // Stop Drag
                overlayLabel.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayLabel);

                // Here we add the PopUp
                PopUpManager.addPopUp(panel, core.stage, true, true);


            } else {

                // Stop Drag
                overlayLabel.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayLabel);

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
            var componentName = textInput.text;


            // upper and lowercase Name for Component
            var uppercaseComponentName = componentName.substring(0,1).toUpperCase() + componentName.substring(1);
            var lowercaseComponentName = componentName.substring(0,1).toLowerCase() + componentName.substring(1);

            appLabelAux.code.name = componentName;
            appLabelAux.code.text = "Label";



            // Create file Label for project
            File.saveContent(core.addProject.okButton.path + "/Source/app/"+lowercaseScreenName+"/"+uppercaseComponentName+".hx", appLabelAux.code.getCode(core));

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