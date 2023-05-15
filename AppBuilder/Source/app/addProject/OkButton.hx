package app.addProject;

using StringTools;
import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.TextInput;
import feathers.controls.Check;
import feathers.controls.TextArea;
import feathers.controls.Radio;
import feathers.controls.PopUpDatePicker;
import feathers.events.TriggerEvent;
import openfl.events.MouseEvent;
#if sys
import sys.io.File;
#end
import haxe.io.Path;



class OkButton {
    var okButton:Button;
    public var projectsPath:String;
    public var projectName:String;
    public var path:String; 
    public var homeDrive:String;

    public function new(core:Core){
        
        okButton = new Button("Crează");
        
        refresh(core);
        events(core);
    }

    public function getOkButton(){
        return okButton;
    }

    public function refresh(core:Core){
        // Size 
        okButton.width = 0.2 * core.stage.stageWidth;
        okButton.height = 0.1 * core.stage.stageHeight;
        

        // Position
        okButton.x = core.stage.stageWidth/2 - okButton.width/2;
        okButton.y = 0.7 * core.stage.stageHeight;
    }

    public function events(core:Core){
         okButton.addEventListener(TriggerEvent.TRIGGER, (e)->{

            projectsPath = core.initialScreen.openFolderButton.path; 
            projectName = core.addProject.projectName.getProjectName().text;


            // Path
            path = Path.join([projectsPath, projectName]).toString();
         

            if(sys.FileSystem.exists(path)){
                trace("Project exists");

                // We read the number of screens
                var sourceDirectory = sys.FileSystem.readDirectory(path+"/Source/app");
                var numberOfScreens = 0;
                var folders = [];
                for(file in sourceDirectory){
                    var regex = ~/^[a-z]/;
                    if(regex.match(file)==true){
                        numberOfScreens++;
                        folders.push(file);
                    }
                }

                trace("Number of screens: "+numberOfScreens);

                // We add the unexistent Screens
                if(numberOfScreens != 1){
                    for(i in 2...numberOfScreens+1){
                        core.editorView.panel.addScreen("Screen"+i,core);
                    }

                    core.editorView.panel.addScreenButton.i = numberOfScreens+1;
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

                // We search in every Folder for elements
                for(folder in folders){
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
                }

                core.editorView.appView.getAppView().addChild(core.editorView.panel.screens[0].elements);

            } else {

                trace(projectsPath);
                trace(projectName);
                // Aici creem un proiect OpenFl nou
                Sys.command("cd " + projectsPath + " && openfl create project " + projectName);

                // Pregatim proiectul pentru App Builder
                
            var source="";
                source = Path.join([path, "Source"]).toString();

                Sys.command("cd " + source + " && mkdir app");

                // We create the screen1
                Sys.command("cd "+source + "/app && mkdir screen1");
                
                var screenName = "Screen1";
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
        // refreshChildren

    }

}";

            // Save the Screen1 content 
            File.saveContent(source +"/app/Screen1.hx",screenContent);


                
            // xml file 
            var xml= Path.join([path, "project.xml"]).toString();
                trace(xml);

                // Adaugam feathersui in project.xml

                var projectXml = File.getContent(xml);

                var projectXmlRegex = ~/(?<=<haxelib name="openfl" \/>$)\n/gm;

                projectXml = projectXmlRegex.replace(projectXml,'
	<haxelib name="feathersui" />
    <window width="800" height="640"/>
');
                File.saveContent(xml, projectXml);

                // Creem fisierul Core.hx
                
                var content = 
"import openfl.display.Stage;
import openfl.display.Sprite;

class Core {
    var core:Sprite;
    public var stage:Stage;
    // var Children

    public function new(stage){
        this.stage = stage;

        core = new Sprite();

        // create Children

        // add Children

        refresh();
    }

    public function getCore(){
        return core;
    }

    public function refresh(){
        // refreshButton

    }

} ";

            // Save content
            var contentPath="";
                contentPath = Path.join([path, "Source/Core.hx"]).toString();
                trace(contentPath);

                File.saveContent(contentPath, content);

                // Change the Main.hx
                var mainPath = Path.join([projectsPath,projectName, "Source","Main.hx"]).toString();
                var mainContent = File.getContent(mainPath);

                var regex = ~/(?<=import openfl.display.Sprite;)\n/mg;

                mainContent = regex.replace(mainContent,"
import openfl.events.Event;");

                regex = ~/(?<=class Main extends Sprite\n\{)\n/mg;

                mainContent = regex.replace(mainContent,"
    var core:Core;
");

                regex = ~/(?<=super...$)\n/mg;

                mainContent = regex.replace(mainContent,"
        core = new Core(stage);
        this.addChild(core.getCore());

		events();
	}

	public function events() {
		// Resize
		stage.addEventListener(Event.RESIZE, (event) -> {
			core.refresh();
		});

");
                
            // Save content
            File.saveContent(mainPath, mainContent);


            // Change Core for Screen1
            var corePath = source+"/Core.hx";
            var coreCode = File.getContent(corePath);
            var screenName = "Screen1";
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
    public var "+lowercaseScreenName+":"+uppercaseScreenName+";
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
                
            }
            
            core.getCore().removeChild(core.addProject.getAddProject());
            core.getCore().addChild(core.editorView.getEditorView());
            
        });
        
    }
}
