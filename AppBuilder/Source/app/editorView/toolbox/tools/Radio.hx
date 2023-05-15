package app.editorView.toolbox.tools;

import app.editorView.appView.AppRadio;
import openfl.geom.Point;
import openfl.events.Event;
import openfl.events.MouseEvent;
import feathers.events.TriggerEvent;
import openfl.events.KeyboardEvent;
import openfl.events.FocusEvent;
import feathers.controls.Button;
import feathers.controls.Radio;
import feathers.controls.Panel;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.TextInput;
import feathers.core.PopUpManager;
import openfl.text.TextFormat;
#if sys
import sys.io.File;
#end

class Radio{

    var radio:feathers.controls.Radio;
    // Overlay
    var overlayRadio:feathers.controls.Radio;
    // Button Aux
    public var appRadioAux:AppRadio;
    //PopUp
    var panel:Panel;
    var label:Label;
    var textInput:TextInput;
    var btn:feathers.controls.Button;
    // AppButton
    public var appRadioArray:Array<AppRadio>;


    public function new(core:Core){
        radio = new feathers.controls.Radio("Radio");

        // OverlayRadio
        overlayRadio = new feathers.controls.Radio("Radio");

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

        // AppRadioArray
        appRadioArray = new Array();
        

        refresh(core);
        events(core);
    }


    public function getRadio(){
        return radio;
    }


    
    public function refresh(core:Core){

        

        radio.width = 0.1 * core.stage.stageWidth;
        radio.height = 0.05 * core.stage.stageHeight;

        radio.x = 0.2 * core.stage.stageWidth/2 - radio.width/2;
        radio.y = 0.70 * core.stage.stageHeight;

        // Set radio textFormat
        if(core.stage.stageWidth < core.stage.stageHeight){
		    radio.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageWidth));
        } else {
		    radio.textFormat = new TextFormat("Arial", Std.int(0.03 * core.stage.stageHeight));
        }
        
        // Overlayradio
        overlayRadio.width = radio.width;
        overlayRadio.height = radio.height;


        // Children
        if(appRadioArray.length != 0){
            for(appRadioI in appRadioArray){
                appRadioI.refresh(core);
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


        radio.addEventListener(MouseEvent.MOUSE_DOWN,(e)->{


            // Set Position
            overlayRadio.x = 0.2*core.stage.stageWidth/2 - overlayRadio.width/2 + 0.8 * core.stage.stageWidth;
            overlayRadio.y = 0.80 * core.stage.stageHeight;

            // Add overlay 
            core.editorView.getEditorView().addChild(overlayRadio);
            // Start drag
            overlayRadio.startDrag();

        });


        // Cand dam click pe MouseEvent 
        overlayRadio.addEventListener(MouseEvent.MOUSE_UP,(e)->{
            trace(overlayRadio.x+ " "+ overlayRadio.y);
            if(overlayRadio.x>0.2 * core.stage.stageWidth &&
               overlayRadio.y>0.1 * core.stage.stageHeight &&
               overlayRadio.x<0.8 * core.stage.stageWidth){


                // new AppRadio
                var appRadio = new app.editorView.appView.AppRadio(core);
                appRadioArray.push(appRadio);
                appRadioAux = appRadio;

                
                appRadio.getAppRadio().width = overlayRadio.width;
                appRadio.getAppRadio().height = overlayRadio.height;

                appRadio.getAppRadio().x = overlayRadio.x - core.editorView.appView.getAppView().x;
                appRadio.getAppRadio().y = overlayRadio.y - core.editorView.appView.getAppView().y;



                appRadio.setPercents(core);

                core.editorView.appView.getAppView().addChild(appRadio.getAppRadio());

            

                // Stop Drag
                overlayRadio.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayRadio);


                // Here we add the PopUp
                PopUpManager.addPopUp(panel, core.stage, true, true);


            } else {

                // Stop Drag
                overlayRadio.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayRadio);

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

            appRadioAux.code.name = componentName;
            appRadioAux.code.text = "Radio";



            // Create file Radio for project
            File.saveContent(core.addProject.okButton.path + "/Source/app/"+lowercaseScreenName+"/"+uppercaseComponentName+".hx", appRadioAux.code.getCode(core));

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