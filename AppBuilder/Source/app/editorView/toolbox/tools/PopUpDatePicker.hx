package app.editorView.toolbox.tools;

import app.editorView.appView.AppPopUpDatePicker;
import openfl.geom.Point;
import openfl.events.Event;
import openfl.events.MouseEvent;
import feathers.events.TriggerEvent;
import openfl.events.KeyboardEvent;
import openfl.events.FocusEvent;
import feathers.controls.Button;
import feathers.controls.PopUpDatePicker;
import feathers.controls.Panel;
import feathers.controls.Header;
import feathers.controls.Label;
import feathers.controls.TextInput;
import feathers.core.PopUpManager;
import openfl.text.TextFormat;
#if sys
import sys.io.File;
#end

class PopUpDatePicker{

    var popUpDatePicker:feathers.controls.PopUpDatePicker;
    // Overlay
    var overlayPopUpDatePicker:feathers.controls.PopUpDatePicker;
    // Button Aux
    public var appPopUpDatePickerAux:AppPopUpDatePicker;
    //PopUp
    var panel:Panel;
    var label:Label;
    var textInput:TextInput;
    var btn:feathers.controls.Button;
    // AppButton
    public var appPopUpDatePickerArray:Array<AppPopUpDatePicker>;


    public function new(core:Core){
        popUpDatePicker = new feathers.controls.PopUpDatePicker();

        // OverlayPopUpDatePicker
        overlayPopUpDatePicker = new feathers.controls.PopUpDatePicker();

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

        // AppPopUpDatePickerArray
        appPopUpDatePickerArray = new Array();
        

        refresh(core);
        events(core);
    }


    public function getPopUpDatePicker(){
        return popUpDatePicker;
    }


    
    public function refresh(core:Core){

        

        popUpDatePicker.width = 0.1 * core.stage.stageWidth;
        popUpDatePicker.height = 0.05 * core.stage.stageHeight;

        popUpDatePicker.x = 0.2 * core.stage.stageWidth/2 - popUpDatePicker.width/2;
        popUpDatePicker.y = 0.8 * core.stage.stageHeight;

        
        // OverlaypopUpDatePicker
        overlayPopUpDatePicker.width = popUpDatePicker.width;
        overlayPopUpDatePicker.height = popUpDatePicker.height;


        // Children
        if(appPopUpDatePickerArray.length != 0){
            for(appPopUpDatePickerI in appPopUpDatePickerArray){
                appPopUpDatePickerI.refresh(core);
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


        popUpDatePicker.addEventListener(MouseEvent.MOUSE_DOWN,(e)->{


            // Set Position
            overlayPopUpDatePicker.x = 0.2*core.stage.stageWidth/2 - overlayPopUpDatePicker.width/2 + 0.8 * core.stage.stageWidth;
            overlayPopUpDatePicker.y = 0.90 * core.stage.stageHeight;

            // Add overlay 
            core.editorView.getEditorView().addChild(overlayPopUpDatePicker);
            // Start drag
            overlayPopUpDatePicker.startDrag();

        });


        // Cand dam click pe MouseEvent 
        overlayPopUpDatePicker.addEventListener(MouseEvent.MOUSE_UP,(e)->{
            trace(overlayPopUpDatePicker.x+ " "+ overlayPopUpDatePicker.y);
            if(overlayPopUpDatePicker.x>0.2 * core.stage.stageWidth &&
               overlayPopUpDatePicker.y>0.1 * core.stage.stageHeight &&
               overlayPopUpDatePicker.x<0.8 * core.stage.stageWidth){


                // new AppPopUpDatePicker
                var appPopUpDatePicker = new app.editorView.appView.AppPopUpDatePicker(core);
                appPopUpDatePickerArray.push(appPopUpDatePicker);
                appPopUpDatePickerAux = appPopUpDatePicker;

                
                appPopUpDatePicker.getAppPopUpDatePicker().width = overlayPopUpDatePicker.width;
                appPopUpDatePicker.getAppPopUpDatePicker().height = overlayPopUpDatePicker.height;

                appPopUpDatePicker.getAppPopUpDatePicker().x = overlayPopUpDatePicker.x - core.editorView.appView.getAppView().x;
                appPopUpDatePicker.getAppPopUpDatePicker().y = overlayPopUpDatePicker.y - core.editorView.appView.getAppView().y;



                appPopUpDatePicker.setPercents(core);

                core.editorView.appView.getAppView().addChild(appPopUpDatePicker.getAppPopUpDatePicker());

            

                // Stop Drag
                overlayPopUpDatePicker.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayPopUpDatePicker);


                // Here we add the PopUp
                PopUpManager.addPopUp(panel, core.stage, true, true);


            } else {

                // Stop Drag
                overlayPopUpDatePicker.stopDrag();

                // Remove Overlay
                core.editorView.getEditorView().removeChild(overlayPopUpDatePicker);

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

            appPopUpDatePickerAux.code.name = componentName;
            appPopUpDatePickerAux.code.text = "PopUpDatePicker";



            // Create file PopUpDatePicker for project
            File.saveContent(core.addProject.okButton.path + "/Source/app/"+lowercaseScreenName+"/"+uppercaseComponentName+".hx", appPopUpDatePickerAux.code.getCode(core));

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