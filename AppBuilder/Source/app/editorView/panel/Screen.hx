package app.editorView.panel;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import feathers.controls.Label;
import feathers.controls.TextInput;
import feathers.controls.Radio;
import feathers.controls.Button;
import feathers.controls.Check;
import feathers.controls.TextArea;
import feathers.controls.PopUpDatePicker;
import feathers.events.TriggerEvent;
import openfl.events.Event;
import openfl.events.MouseEvent;
import app.editorView.appView.AppButton;


#if sys
import sys.io.File;
#end

class Screen{
    var screen:Sprite;
    public var deleteIcon:Bitmap;
    public var text:Label;
    public var radioButton:Radio;
    public var y:Float;
    public var elements:Sprite;

    public function new(core:Core){
        screen = new Sprite();
        elements = new Sprite();

		// deleteIcon
		deleteIcon = new Bitmap(Assets.getBitmapData("assets/delete-bin-fill.png"));
		screen.addChild(deleteIcon);

        // Text
        text = new Label();
        screen.addChild(text);

        // Checkbox
        radioButton = new Radio();
        screen.addChild(radioButton);

        refresh(core);
        events(core);
    }

    public function getScreen(){
        return screen;
    }

    public function refresh(core:Core){

        screen.x = 0.1 * core.stage.stageWidth - 0.15*core.stage.stageWidth/2;


        text.x = 0.03 * core.stage.stageWidth;

        deleteIcon.width = 0.03*core.stage.stageHeight;
        deleteIcon.height = 0.03*core.stage.stageHeight;
        deleteIcon.x = 0.12 * core.stage.stageWidth;
        

        trace(screen.width);
    }

    public function events(core:Core){
        radioButton.addEventListener(Event.CHANGE,(e:Event)->{
            
            if(core.editorView != null){

                var path = core.addProject.okButton.path;

                // resetam Elementele
                var screens = core.editorView.panel.screens;
                for(i in 0...screens.length){
                    screens[i].elements.removeChildren();
                }



                function searchFor(a:String,b:String){

                    var regex = new EReg("^.*\\."+a+".*","gm");
                    regex.match(b);
                    var matched = regex.matched(0);

                    var regex1 = ~/0\.\d{1,20}/gm;
                    regex1.match(matched);
                    trace(a+" "+regex1.matched(0));
                    
                    return regex1.matched(0);
                }

                var folder = "screen" + (core.editorView.panel.toggleGroup.selectedIndex+1);
                // We search in current Folder for elements
                var components = sys.FileSystem.readDirectory(path+"/Source/app/"+folder); 
                for(component in components){
                    var componentContent = File.getContent(path+"/Source/app/"+folder+"/"+component);

                    // Screen Index
                    var reg = ~/\d/mg;
                    reg.match(folder);
                    var screenIndex = Std.parseInt(reg.matched(0));

                    // ComponentType
                    var reg1 = ~/(?<=controls.)[A-z]*/mg;
                    reg1.match(componentContent);
                    var componentType = reg1.matched(0);
                    
                    var componentWidth = Std.parseFloat(searchFor("width",componentContent));
                    var componentHeight = Std.parseFloat(searchFor("height",componentContent));
                    var componentX = Std.parseFloat(searchFor("x",componentContent));
                    var componentY = Std.parseFloat(searchFor("y",componentContent));

                    if(componentType == "Button"){

                        reg = ~/(?<=new Button\(['"])[^'"]{0,50}/gm;
                        reg.match(componentContent);
                        var buttonText = reg.matched(0);

                        // New Button
                        var button = new Button(buttonText);

                        // Size
                        button.width = componentWidth * core.editorView.appView.width ;
                        button.height = componentHeight* core.editorView.appView.height ;

                        // Position
                        button.x = componentX * core.editorView.appView.width;
                        button.y = componentY * core.editorView.appView.height;

                        button.addEventListener(TriggerEvent.TRIGGER,(e)->{
                            var regEvent = ~/(?<=\/\/ TriggerEvent\s)[\w\W]*(?=\/\/ End TriggerEvent)/gm;
                            regEvent.match(componentContent);
                            trace("Trigger Event: "+regEvent.matched(0));
                            trace(component);
                            core.eventView.codeArea.getCodeArea().text = regEvent.matched(0);
                            core.eventView.saveButton.currentComponent = component;
                            core.eventView.currentComponent.getCurrentComponent().text = component;

                            var regEvent1 = ~/(?<=\/\/ Refresh\s)[\w\W]*(?=\/\/ End Refresh)/gm;
                            regEvent1.match(componentContent);
                            trace("Refresh : "+regEvent1.matched(0));
                            trace(component);
                            core.settingsView.codeArea.getCodeArea().text = regEvent1.matched(0);
                            core.settingsView.saveButton.currentComponent = component;
                            core.settingsView.currentComponent.getCurrentComponent().text = component;

                            var regEvent2 = ~/(?<=\/\/ Title\s)[\w\W]*(?=\/\/ End Title)/gm;
                            regEvent2.match(componentContent);
                            trace("Title : "+regEvent2.matched(0));
                            trace(component);
                            core.titleView.codeArea.getCodeArea().text = regEvent2.matched(0);
                            core.titleView.saveButton.currentComponent = component;
                            core.titleView.currentComponent.getCurrentComponent().text = component;

                        });
                        


                        core.editorView.panel.screens[screenIndex-1].elements.addChild(button);
                        
                    } else if(componentType == "Label") {

                        reg = ~/(?<=new Label\(['"])[^'"]{0,50}/gm;
                        reg.match(componentContent);
                        var labelText = reg.matched(0);

                        // New Button
                        var label = new Label(labelText);
                        // Size
                        label.width = componentWidth * core.editorView.appView.width ;
                        label.height = componentHeight* core.editorView.appView.height ;

                        // Position
                        label.x = componentX * core.editorView.appView.width;
                        label.y = componentY * core.editorView.appView.height;

                        label.addEventListener(MouseEvent.CLICK,(e)->{

                            var regEvent = ~/(?<=\/\/ TriggerEvent\s)[\w\W]*(?=\/\/ End TriggerEvent)/gm;
                            regEvent.match(componentContent);
                            trace("Trigger Event: "+regEvent.matched(0));
                            trace(component);
                            core.eventView.codeArea.getCodeArea().text = regEvent.matched(0);
                            core.eventView.saveButton.currentComponent = component;
                            core.eventView.currentComponent.getCurrentComponent().text = component;

                            var regEvent1 = ~/(?<=\/\/ Refresh\s)[\w\W]*(?=\/\/ End Refresh)/gm;
                            regEvent1.match(componentContent);
                            trace("Refresh : "+regEvent1.matched(0));
                            trace(component);
                            core.settingsView.codeArea.getCodeArea().text = regEvent1.matched(0);
                            core.settingsView.saveButton.currentComponent = component;
                            core.settingsView.currentComponent.getCurrentComponent().text = component;

                            var regEvent2 = ~/(?<=\/\/ Title\s)[\w\W]*(?=\/\/ End Title)/gm;
                            regEvent2.match(componentContent);
                            trace("Title : "+regEvent2.matched(0));
                            trace(component);
                            core.titleView.codeArea.getCodeArea().text = regEvent2.matched(0);
                            core.titleView.saveButton.currentComponent = component;
                            core.titleView.currentComponent.getCurrentComponent().text = component;


                        });
                        


                        core.editorView.panel.screens[screenIndex-1].elements.addChild(label);

                    } else if(componentType == "TextInput") {

                        reg = ~/(?<=new TextInput\(['"])[^'"]{0,50}/gm;
                        reg.match(componentContent);
                        var textInputText = "";
                        if(reg.matched(0) != ""){
                            textInputText = reg.matched(0);
                        }

                        // New Button
                        var textInput = new TextInput(textInputText);
                        // Size
                        textInput.width = componentWidth * core.editorView.appView.width ;
                        textInput.height = componentHeight* core.editorView.appView.height ;

                        // Position
                        textInput.x = componentX * core.editorView.appView.width;
                        textInput.y = componentY * core.editorView.appView.height;

                        textInput.addEventListener(MouseEvent.CLICK,(e)->{

                            var regEvent = ~/(?<=\/\/ TriggerEvent\s)[\w\W]*(?=\/\/ End TriggerEvent)/gm;
                            regEvent.match(componentContent);
                            trace("Trigger Event: "+regEvent.matched(0));
                            trace(component);
                            core.eventView.codeArea.getCodeArea().text = regEvent.matched(0);
                            core.eventView.saveButton.currentComponent = component;
                            core.eventView.currentComponent.getCurrentComponent().text = component;

                            var regEvent1 = ~/(?<=\/\/ Refresh\s)[\w\W]*(?=\/\/ End Refresh)/gm;
                            regEvent1.match(componentContent);
                            trace("Refresh : "+regEvent1.matched(0));
                            trace(component);
                            core.settingsView.codeArea.getCodeArea().text = regEvent1.matched(0);
                            core.settingsView.saveButton.currentComponent = component;
                            core.settingsView.currentComponent.getCurrentComponent().text = component;

                            var regEvent2 = ~/(?<=\/\/ Title\s)[\w\W]*(?=\/\/ End Title)/gm;
                            regEvent2.match(componentContent);
                            trace("Title : "+regEvent2.matched(0));
                            trace(component);
                            core.titleView.codeArea.getCodeArea().text = regEvent2.matched(0);
                            core.titleView.saveButton.currentComponent = component;
                            core.titleView.currentComponent.getCurrentComponent().text = component;

                        });
                        


                        core.editorView.panel.screens[screenIndex-1].elements.addChild(textInput);

                    } else if(componentType == "Check"){

                            reg = ~/(?<=new Check\(['"])[^'"]{0,50}/gm;
                            reg.match(componentContent);
                            var checkText = "";
                            if(reg.matched(0) != ""){
                                checkText = reg.matched(0);
                            }

                            // New Button
                            var check = new Check(checkText);
                            // Size
                            check.width = componentWidth * core.editorView.appView.width ;
                            check.height = componentHeight* core.editorView.appView.height ;

                            // Position
                            check.x = componentX * core.editorView.appView.width;
                            check.y = componentY * core.editorView.appView.height;

                            check.addEventListener(MouseEvent.CLICK,(e)->{
                                var regEvent = ~/(?<=\/\/ TriggerEvent\s)[\w\W]*(?=\/\/ End TriggerEvent)/gm;
                                regEvent.match(componentContent);
                                trace("Trigger Event: "+regEvent.matched(0));
                                trace(component);
                                core.eventView.codeArea.getCodeArea().text = regEvent.matched(0);
                                core.eventView.saveButton.currentComponent = component;
                                core.eventView.currentComponent.getCurrentComponent().text = component;

                                var regEvent1 = ~/(?<=\/\/ Refresh\s)[\w\W]*(?=\/\/ End Refresh)/gm;
                                regEvent1.match(componentContent);
                                trace("Refresh : "+regEvent1.matched(0));
                                trace(component);
                                core.settingsView.codeArea.getCodeArea().text = regEvent1.matched(0);
                                core.settingsView.saveButton.currentComponent = component;
                                core.settingsView.currentComponent.getCurrentComponent().text = component;

                                var regEvent2 = ~/(?<=\/\/ Title\s)[\w\W]*(?=\/\/ End Title)/gm;
                                regEvent2.match(componentContent);
                                trace("Title : "+regEvent2.matched(0));
                                trace(component);
                                core.titleView.codeArea.getCodeArea().text = regEvent2.matched(0);
                                core.titleView.saveButton.currentComponent = component;
                                core.titleView.currentComponent.getCurrentComponent().text = component;
                            });
                            


                            core.editorView.panel.screens[screenIndex-1].elements.addChild(check);
                    } else if(componentType == "TextArea"){

                            reg = ~/(?<=new TextArea\(['"])[^'"]{0,50}/gm;
                            reg.match(componentContent);
                            var textAreaText = "";
                            if(reg.matched(0) != ""){
                                textAreaText = reg.matched(0);
                            }

                            // New Button
                            var textArea = new TextArea(textAreaText);
                            // Size
                            textArea.width = componentWidth * core.editorView.appView.width ;
                            textArea.height = componentHeight* core.editorView.appView.height ;

                            // Position
                            textArea.x = componentX * core.editorView.appView.width;
                            textArea.y = componentY * core.editorView.appView.height;

                            textArea.addEventListener(MouseEvent.CLICK,(e)->{
                                var regEvent = ~/(?<=\/\/ TriggerEvent\s)[\w\W]*(?=\/\/ End TriggerEvent)/gm;
                                regEvent.match(componentContent);
                                trace("Trigger Event: "+regEvent.matched(0));
                                trace(component);
                                core.eventView.codeArea.getCodeArea().text = regEvent.matched(0);
                                core.eventView.saveButton.currentComponent = component;
                                core.eventView.currentComponent.getCurrentComponent().text = component;

                                var regEvent1 = ~/(?<=\/\/ Refresh\s)[\w\W]*(?=\/\/ End Refresh)/gm;
                                regEvent1.match(componentContent);
                                trace("Refresh : "+regEvent1.matched(0));
                                trace(component);
                                core.settingsView.codeArea.getCodeArea().text = regEvent1.matched(0);
                                core.settingsView.saveButton.currentComponent = component;
                                core.settingsView.currentComponent.getCurrentComponent().text = component;

                                var regEvent2 = ~/(?<=\/\/ Title\s)[\w\W]*(?=\/\/ End Title)/gm;
                                regEvent2.match(componentContent);
                                trace("Title : "+regEvent2.matched(0));
                                trace(component);
                                core.titleView.codeArea.getCodeArea().text = regEvent2.matched(0);
                                core.titleView.saveButton.currentComponent = component;
                                core.titleView.currentComponent.getCurrentComponent().text = component;
                            });
                            


                            core.editorView.panel.screens[screenIndex-1].elements.addChild(textArea);
                    } else if(componentType == "Radio"){

                            reg = ~/(?<=new Radio\(['"])[^'"]{0,50}/gm;
                            reg.match(componentContent);
                            var radioText = "";
                            if(reg.matched(0) != ""){
                                radioText = reg.matched(0);
                            }

                            // New Button
                            var radio = new Radio(radioText);
                            // Size
                            radio.width = componentWidth * core.editorView.appView.width ;
                            radio.height = componentHeight* core.editorView.appView.height ;

                            // Position
                            radio.x = componentX * core.editorView.appView.width;
                            radio.y = componentY * core.editorView.appView.height;

                            radio.addEventListener(MouseEvent.CLICK,(e)->{
                                var regEvent = ~/(?<=\/\/ TriggerEvent\s)[\w\W]*(?=\/\/ End TriggerEvent)/gm;
                                regEvent.match(componentContent);
                                trace("Trigger Event: "+regEvent.matched(0));
                                trace(component);
                                core.eventView.codeArea.getCodeArea().text = regEvent.matched(0);
                                core.eventView.saveButton.currentComponent = component;
                                core.eventView.currentComponent.getCurrentComponent().text = component;

                                var regEvent1 = ~/(?<=\/\/ Refresh\s)[\w\W]*(?=\/\/ End Refresh)/gm;
                                regEvent1.match(componentContent);
                                trace("Refresh : "+regEvent1.matched(0));
                                trace(component);
                                core.settingsView.codeArea.getCodeArea().text = regEvent1.matched(0);
                                core.settingsView.saveButton.currentComponent = component;
                                core.settingsView.currentComponent.getCurrentComponent().text = component;

                                var regEvent2 = ~/(?<=\/\/ Title\s)[\w\W]*(?=\/\/ End Title)/gm;
                                regEvent2.match(componentContent);
                                trace("Title : "+regEvent2.matched(0));
                                trace(component);
                                core.titleView.codeArea.getCodeArea().text = regEvent2.matched(0);
                                core.titleView.saveButton.currentComponent = component;
                                core.titleView.currentComponent.getCurrentComponent().text = component;
                            });
                            


                            core.editorView.panel.screens[screenIndex-1].elements.addChild(radio);
                    } else if(componentType == "PopUpDatePicker"){

                        // New PopUpDatePicker
                        var popUpDatePicker = new PopUpDatePicker();
                        // Size
                        popUpDatePicker.width = componentWidth * core.editorView.appView.width ;
                        popUpDatePicker.height = componentHeight* core.editorView.appView.height ;

                        // Position
                        popUpDatePicker.x = componentX * core.editorView.appView.width;
                        popUpDatePicker.y = componentY * core.editorView.appView.height;

                        popUpDatePicker.addEventListener(MouseEvent.CLICK,(e)->{
                            var regEvent = ~/(?<=\/\/ TriggerEvent\s)[\w\W]*(?=\/\/ End TriggerEvent)/gm;
                            regEvent.match(componentContent);
                            trace("Trigger Event: "+regEvent.matched(0));
                            trace(component);
                            core.eventView.codeArea.getCodeArea().text = regEvent.matched(0);
                            core.eventView.saveButton.currentComponent = component;
                            core.eventView.currentComponent.getCurrentComponent().text = component;

                            var regEvent1 = ~/(?<=\/\/ Refresh\s)[\w\W]*(?=\/\/ End Refresh)/gm;
                            regEvent1.match(componentContent);
                            trace("Refresh : "+regEvent1.matched(0));
                            trace(component);
                            core.settingsView.codeArea.getCodeArea().text = regEvent1.matched(0);
                            core.settingsView.saveButton.currentComponent = component;
                            core.settingsView.currentComponent.getCurrentComponent().text = component;

                            var regEvent2 = ~/(?<=\/\/ Title\s)[\w\W]*(?=\/\/ End Title)/gm;
                            regEvent2.match(componentContent);
                            trace("Title : "+regEvent2.matched(0));
                            trace(component);
                            core.titleView.codeArea.getCodeArea().text = regEvent2.matched(0);
                            core.titleView.saveButton.currentComponent = component;
                            core.titleView.currentComponent.getCurrentComponent().text = component;
                        });
                        


                        core.editorView.panel.screens[screenIndex-1].elements.addChild(popUpDatePicker);
                    }



                }
                // Clear the view
                core.editorView.appView.getAppView().removeChildren();

                // Add elements 
                var screenIndex = core.editorView.panel.toggleGroup.selectedIndex;
                core.editorView.appView.getAppView().addChild(core.editorView.panel.screens[screenIndex].elements);
                trace(core.editorView.panel.screens[screenIndex].elements.numChildren);
                trace("ScreenIndex: "+screenIndex);

            }
        });
    }

}